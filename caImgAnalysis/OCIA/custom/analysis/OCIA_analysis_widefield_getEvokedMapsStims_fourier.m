function [stimMaps, refImg, stimIDs, stimIndexes, imgH, imgW, hashStruct] = OCIA_analysis_widefield_getEvokedMapsStims_fourier(this, iDWRows)
% OCIA_analysis_widefield_getEvokedMapsStims_fourier - [no description]
%
%       [stimMaps, refImg, stimIDs, stimIndexes, imgH, imgW, hashStruct] = OCIA_analysis_widefield_getEvokedMapsStims_fourier(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% defines some parameters
nBins = this.an.wf.nBins;

% abort if no bins
if isempty(nBins) || any(nBins == 0); return; end;

%% get the data
% get the data in memory
hashStruct = OCIA_analysis_widefield_getHashStruct(this, [], 'WFEvokedMapsStimsFou', [], ...
    struct('path', this.path.intrSave, 'iDWRows', iDWRows));
cachedData = ANGetCachedData(this, 'wf', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);
    
    % create stim map
    nStims = numel(iDWRows);
    nBins = this.an.wf.nBins;
    stimMaps = nan(nBins(1), nBins(2), nStims);
    stimIndexes = [];
    % fill it with data of all stims
    for iRow = iDWRows;
        powerMap = OCIA_analysis_widefield_getPowerAndPhaseMap(this, iRow);
        % abort if no data
        if isempty(powerMap); return; end;
        % get stim index
        [~, ~, ~, ~, ~, ~, ~, pitchLims] = OCIA_analysis_widefield_getFileInfo(this, iRow, true);
        if pitchLims(1) ~= 0; stimID = sprintf('%dkHz', pitchLims(1) / 1000);
        else stimID = 'no sound';
        end;
        stimIDs = this.an.wf.stimIDs;
        iStim = find(strcmp(stimID, stimIDs));
        stimIndexes(end + 1) = iStim; %#ok<AGROW>
        stimMaps(:, :, iStim) = powerMap;
    end;

    % no plot if no data
    if isempty(stimMaps); return; end;

    % get reference image
    [~, ~, ~, refImg] = OCIA_analysis_widefield_getFileInfo(this, iDWRows(1));
    % crop image if needed
    if ~isempty(refImg) && ~isempty(this.an.wf.cropRect);
        refImg = refImg(this.an.wf.cropRect(2) + (0 : this.an.wf.cropRect(4) - 1), ...
            this.an.wf.cropRect(1) + (0 : this.an.wf.cropRect(3) - 1));
    end;
    imgH = size(refImg, 1); imgW = size(refImg, 2);
        
    % store the variables in the cached structure
    cachedData = struct('stimMaps', stimMaps, 'refImg', refImg, 'stimIDs', { stimIDs }, 'stimIndexes', stimIndexes, ...
        'imgH', imgH, 'imgW', imgW, 'dataType', 'WFEvokedMapsStimsStd', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'wf', hashStruct, cachedData);
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    ANShowHideMessage(this, 1, 'Loading data from cache ...');
    stimMaps = cachedData.stimMaps;
    refImg = cachedData.refImg;
    stimIDs = cachedData.stimIDs;
    stimIndexes = cachedData.stimIndexes;
    imgH = cachedData.imgH;
    imgW = cachedData.imgW;
    

end;

end
