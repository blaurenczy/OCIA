function [pixelTimeCourse, t, hashStruct] = OCIA_analysis_widefield_getPixTimeCourse(this, iFile)
% OCIA_analysis_widefield_getPixTimeCourse - [no description]
%
%       [pixelTimeCourse, t, hashStruct] = OCIA_analysis_widefield_getPixTimeCourse(this, iFile)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% default output
[pixelTimeCourse, t, hashStruct] = deal([]);

% get number of bins
nBins = this.an.wf.nBins;
nTotBins = prod(nBins);
% abort if no bins
if isempty(nBins) || any(nBins == 0); return; end;

if ~isempty(this.an.wf.ROIMasks);
    [pixelTimeCourse, t, hashStruct] = OCIA_analysis_widefield_getPixTimeCourse_ROIs(this, iFile);
    return;
end;

%% get the data
% get information from selected file
[filePath, ~, framesDatasetPath, ~, framesDim, frameRate] = OCIA_analysis_widefield_getFileInfo(this, iFile, true);
% baseline correction method
BLCorrMethod = this.an.wf.BLCorrMethod;
BLCorrParam = this.an.wf.BLCorrParam;
% window size for trace corrections with high-pass filter
windowSize = iff(strcmp(BLCorrMethod, 'slidingAvg'), round(frameRate ./ BLCorrParam), 0);

% limit frame range
frameRange = this.an.wf.frameRange;
if frameRange(2) == -1; frameRange(2) = Inf; end;
frameRange = [max(1, frameRange(1)), min(framesDim(3), frameRange(end))];
framesDim(3) = diff(frameRange) + 1;

% use cropped dimensions if any
H = framesDim(1); W = framesDim(2); nFrames = framesDim(3);
X = iff(isempty(this.an.wf.cropRect), 1, this.an.wf.cropRect, [], 1);
Y = iff(isempty(this.an.wf.cropRect), 1, this.an.wf.cropRect, [], 2);
W = iff(isempty(this.an.wf.cropRect), W, this.an.wf.cropRect, [], 3);
H = iff(isempty(this.an.wf.cropRect), H, this.an.wf.cropRect, [], 4);

% create time vector
t = (1 : nFrames) / frameRate;

% get the data in memory
hashStruct = OCIA_analysis_widefield_getHashStruct(this, iFile, 'WFPixelTimeCourse', 'stim|((base|evoked)Frames)|phase|power');
cachedData = ANGetCachedData(this, 'wf', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);
    
    t0 = tic;

    % check if binning factor is a divider of the image size (same pixel number in each bin)
    if mod(H, nBins(2)) ~= 0 || mod(W, nBins(1)) ~= 0;
        msg = sprintf('Number of bins is not a perfect divider for image size (nBins = [%d, %d], imgSize = [%d %d]).', nBins, W, H);
        showWarning(this, sprintf('OCIA:%s:BadBinning', mfilename()), msg);
        ANShowHideMessage(this, 1, msg);
        return;
    end;
    
    % get bin size
    binSizeW = W / nBins(1); binSizeH = H / nBins(2);

    % extract the pixel time course for each bin
    pixelTimeCourse = nan(nTotBins, nFrames);
    
    % number of chunks to divide the raw data into, which is limited by memory but still speeds
    %   up the processing since it avoids multiple read access to data
    nChunkW = this.an.wf.chunkSizeFactor(1);
    nChunkH = this.an.wf.chunkSizeFactor(2);
    chunkSizeW = round(W / nChunkW);
    chunkSizeH = round(H / nChunkH);
        
    % extract chunk by chunk
    for iChunk = 1 : (nChunkW * nChunkH);
        
        ANShowHideMessage(this, 1, sprintf(['Calculating bins (chunk %d/%d - init)... (%d bin(s), bin size = [%d, %d], ', ...
            'nChunks = [%d, %d], chunkSize = [%d, %d], nFrames = %d)'], iChunk, nChunkW * nChunkH, nTotBins, binSizeW, binSizeH, ...
            nChunkW, nChunkH, chunkSizeW, chunkSizeH, nFrames));
                
        % get bin's X and Y range
        [iChunkY, iChunkX] = ind2sub([nChunkH, nChunkW], iChunk);
        % load the pixels for the current chunk
        xChunkStart = ((iChunkX - 1) * chunkSizeW + X);
        yChunkStart = ((iChunkY - 1) * chunkSizeH + Y);
        xChunkEnd = xChunkStart + chunkSizeW - 1;
        yChunkEnd = yChunkStart + chunkSizeH - 1;
        chunkFrames = h5read(filePath, framesDatasetPath, [yChunkStart, xChunkStart, frameRange(1)], ...
            [chunkSizeH, chunkSizeW, nFrames]);
        
        ANShowHideMessage(this, 1, sprintf(['Calculating bins (chunk %d/%d - loaded)... (%d bin(s), bin size = [%d, %d], ', ...
            'nChunks = [%d, %d], chunkSize = [%d, %d], nFrames = %d)'], iChunk, nChunkW * nChunkH, nTotBins, binSizeW, binSizeH, ...
            nChunkW, nChunkH, chunkSizeW, chunkSizeH, nFrames));
               
        % get relevant bin indexes
        isBinOutOfRange = false(1, nTotBins);
        parfor iBin = 1 : nTotBins;
            % get bin's X and Y range
            [iY, iX] = ind2sub(fliplr(nBins), iBin);
            xStart = (iX - 1) * binSizeW + X;
            yStart = (iY - 1) * binSizeH + Y;
            xEnd = xStart + binSizeW - 1;
            yEnd = yStart + binSizeH - 1;
            % tag bin as not relevant if not within range (not loaded in current chunk, will be added in the next chunk
            isBinOutOfRange(iBin) = xStart < xChunkStart || yStart < yChunkStart || xEnd > xChunkEnd || yEnd > yChunkEnd;
        end;
        relevantBinIndexes = find(~isBinOutOfRange);
        
        ANShowHideMessage(this, 1, sprintf(['Calculating bins (chunk %d/%d - screened (%d relevant bins))... (%d bin(s), bin size = [%d, %d], ', ...
            'nChunks = [%d, %d], chunkSize = [%d, %d], nFrames = %d)'], iChunk, nChunkW * nChunkH, numel(relevantBinIndexes), nTotBins, binSizeW, binSizeH, ...
            nChunkW, nChunkH, chunkSizeW, chunkSizeH, nFrames));
        
        % initialize local maps
        pixelTimeCourseLocal = nan(numel(relevantBinIndexes), nFrames);
        % actually loop over the relevant bins
        parfor iBinLoop = 1 : numel(relevantBinIndexes);
            
            % get bin's X and Y range
            [iY, iX] = ind2sub(fliplr(nBins), relevantBinIndexes(iBinLoop));
            xStart = (iX - 1) * binSizeW + X;
            yStart = (iY - 1) * binSizeH + Y;
            
            % load the pixels for the selected range
            xRange = (xStart : (xStart + binSizeW - 1)) - xChunkStart + 1;
            yRange = (yStart : (yStart + binSizeH - 1)) - yChunkStart + 1;
            frames = chunkFrames(yRange, xRange, :); %#ok<PFBNS>
            
            % get average of selected pixels
            trace = reshape(nanmean(nanmean(frames, 1), 2), 1, nFrames);

            switch BLCorrMethod;
                case 'mean';
                    % correct the trace
                    trace = trace - nanmean(trace);
%                     trace = (trace - nanmean(trace)) / nanmean(trace);
                    
                case 'slidingAvg';
                    
                    % high-pass filter with a moving average filter
                    slidingAvg = zeros(size(trace));
                    for iFrame = 1 : nFrames;
                        frameStart = max(round(iFrame - 0.5 * windowSize), 1);
                        frameEnd = min(round(iFrame + 0.5 * windowSize), nFrames);
                        slidingAvg(iFrame) = nanmean(trace(frameStart : frameEnd));
                    end;
                    % correct the trace
                    trace = trace - slidingAvg;
                    
                case 'polynomial';
                    % fit a degree "BLCorrParam" polynomial
                    p = polyfit(1 : numel(trace), trace, BLCorrParam);
                    polyCorr = polyval(p, 1 : numel(trace));
                    % correct the trace
                    trace = trace - polyCorr;
                    
                case 'bpfilter';
                    trace = mpi_BandPassFilterTimeSeries(trace, 1 / frameRate, BLCorrParam(1), BLCorrParam(2));
                    
                otherwise;
                    % do nothing
            end;
            
            % store
            pixelTimeCourseLocal(iBinLoop, :) = trace;

        end; % bin loop end
        
        % copy back data
        pixelTimeCourse(relevantBinIndexes, :) = pixelTimeCourseLocal;
        
    end; % chunk loop end
    
    ANShowHideMessage(this, 1, sprintf(['Calculating bins done (%.2f sec). (%d bin(s), bin size = [%d, %d], ', ...
        'nChunks = [%d, %d], chunkSize = [%d, %d])'], toc(t0), nTotBins, binSizeW, binSizeH, ...
        nChunkW, nChunkH, chunkSizeW, chunkSizeH));
        
    % store the variables in the cached structure
    cachedData = struct('pixelTimeCourse', pixelTimeCourse, 'dataType', 'WFPixelTimeCourse', ...
        'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'wf', hashStruct, cachedData);
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    ANShowHideMessage(this, 1, 'Loading data from cache ...');
    pixelTimeCourse = cachedData.pixelTimeCourse;
    

end;

end
