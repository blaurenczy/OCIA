function configs = analyseROIStatsMultiDay(animalID, targetDays, targetSpots)

dbgLevel = 2;
configs = {};

% set(0, 'DefaultFigurePosition', [50, 100, 1200, 850]);

%% get days with spots
year = '2013'; % leave this as a string, not a number
analysisRootPaths = struct( ...
     'HIFOWSH350x2D01',  'D:\Balazs\Analysis\', ...
...%    'HIFOWSH350x2D01',  'W:\Neurophysiology\Projects\Auditory\Analysis\AuditoryLearning\', ...
...%     'HIFOWSH640x2D03',  'C:\Users\laurenczy.HIFO\Documents\LocalData\Analysis\', ...
    'HIFOWSH640x2D03',  'D:\data\Analysis\', ...
...%     'OoPC',             'W:\Projects\Auditory\Analysis\AuditoryLearning\');
    'OoPC',             'D:\Users\BaL\PhD\AuditoryLearningAnalysis\');

rawDataRootPaths = struct( ...
...%     'HIFOWSH350x2D01',  'D:\Balazs\RawData\', ...
    'HIFOWSH350x2D01',  'W:\Neurophysiology\RawData\Balazs_Laurenczy\', ...
...%     'HIFOWSH640x2D03b',  'C:\Users\laurenczy.HIFO\Documents\LocalData\RawData\', ...
    'HIFOWSH640x2D03b',  'D:\data\RawData\HDF5\', ...
...%     'OoPC',             'W:\RawData\Balazs_Laurenczy\');
    'OoPC',             'D:\Users\BaL\PhD\AuditoryLearningRaw\');

defaultFigurePos = struct( ...
    'HIFOWSH350x2D01',  [20, 65, 1240, 870], ...
...%    'HIFOWSH640x2D03',  [-1250, 30, 1200, 890], ... 
...%    'HIFOWSH640x2D03',  [30, 250, 1200, 690], ...  
...%    'HIFOWSH640x2D03',  [10, 10, 1260, 930], ...
    'HIFOWSH640x2D03',  [10, 100, 1260, 840], ...
...%    'HIFOWSH640x2D03',  [21   316   796   607], ...
    'OoPC',             [25, 60, 1850, 930]);

[~, computerName] = system('hostname');
analysisRootPath = analysisRootPaths.(genvarname(computerName));
rawDataRootPath = rawDataRootPaths.(genvarname(computerName));
analysisPathExtended = [analysisRootPath year '\' animalID '\'];

set(0, 'DefaultFigurePosition', defaultFigurePos.(genvarname(computerName)));

o('#analyseROIStatsMultiDay(): animalID = "%s".', animalID, 1, dbgLevel);
o('#analys...MultiDay(): analysisRootPath = "%s".', analysisRootPath, 3, dbgLevel);
o('#analys...MultiDay(): analysisPathExtended = "%s".', analysisPathExtended, 3, dbgLevel);

% get all days with at least 1 "spot**" folder inside for this mouse
getDaysTic = tic; % for performance timing purposes
daysWithSpot = getDaysWithSpot(year, analysisRootPath, animalID, 1);
o('#analys...MultiDay(): Found %d day(s) with spot for animal %s (%3.1f sec).', ...
    numel(daysWithSpot), animalID, toc(getDaysTic), 2, dbgLevel);

o('#analys...MultiDay(): %d day(s) to process...', numel(daysWithSpot), 1, dbgLevel);

masterConfig = getAnalyseROIStatsDefaultConfig();
    
% columns: see description below somewhere in the code
nMaxSPots = 15;
configStructs = cell(numel(daysWithSpot), nMaxSPots);
ROIStatsStructs = cell(numel(daysWithSpot), nMaxSPots);
ROIStatsGlobal = cell(numel(daysWithSpot) * 5 * 30, 15);
iROIStatsGlobal = 1;

%% Process each day with spots
for iDay = 1 : numel(daysWithSpot);
    
    % only target day(s)
    if any(masterConfig.targetDays) && ~any(masterConfig.targetDays == iDay); continue; end;
    dayTic = tic; % for performance timing purposes
    
    day = daysWithSpot(iDay);
    % list of spots with short name in notebook file
    spotList = day.spotList(:, 1);
    currentDate = day.day;
    
    o('  #analys...MultiDay(): processing day %d/%d: "%s", %d spot(s)...', iDay, numel(daysWithSpot), ...
        currentDate, numel(spotList), 2, dbgLevel);
    
    % perform analysis in different directory than the raw data directory
    analysisPath = [analysisPathExtended currentDate];
        
    %%  - Process each spot
    for iSpot = 1 : numel(spotList);
    
        % only target spot(s)    
        if any(masterConfig.targetSpots) && ~any(masterConfig.targetSpots == iSpot); continue; end;
        spotTic = tic; % for performance timing purposes
        spotNum = str2double(strrep(spotList{iSpot}, 'spot', ''));
        
        o('    #analys...MultiDay(): processing day %d/%d: "%s", spot %d/%d; "%s" ...', ...
            iDay, numel(daysWithSpot), currentDate, iSpot, numel(spotList), spotList{iSpot}, 2, dbgLevel);
    
        % prepare the path for the ROIStats mat-file of this spot
        loadFileTic = tic; % for performance timing purposes
        spotPath = sprintf('%s%s%s', analysisPath, filesep, spotList{iSpot}, filesep);
        ROIStatsFileName = sprintf('%s_BF_%s_ROIStats', currentDate, spotList{iSpot});
        ROIStatMatFilePath = sprintf('%s%s.mat', spotPath, ROIStatsFileName);
        
        % show warning if ROIStatas mat-file cannot be found
        if ~exist(ROIStatMatFilePath, 'file');
            warning('analyseROIStatsMultiDay:ROIStatsFileNotFound', ...
                'Could not find ROIStats file for day %d/%d: "%s", spot %d at "%s". Skipping.', ...
                iDay, numel(daysWithSpot), currentDate, iSpot, ROIStatMatFilePath);
            continue;
        end;
        
        % load the ROIStats mat-file for this spot
        ROIStatsMatFile = load(ROIStatMatFilePath);
        config = ROIStatsMatFile.(['x' ROIStatsFileName]);
        o(['      #analys...MultiDay(): processing day %d/%d: "%s", spot %d/%d; "%s" ', ...
            'loading file done (%3.1f sec).'], iDay, numel(daysWithSpot), currentDate, iSpot, numel(spotList), ...
            spotList{iSpot}, toc(loadFileTic), 2, dbgLevel);
        
        % overwrite the fieldnames of the masterConfig for the plotting options
        fNames = fieldnames(masterConfig);
        for iField = 1 : numel(fNames);
            config.(fNames{iField}) = masterConfig.(fNames{iField});
        end;
    
        configStructs{iDay, spotNum} = config;
        % proceed to the analysROIStatsSingleDay (PSROIStats, BF, etc. calculations and plotting)
        analyseSingleDayTic = tic; % for performance timing purposes
        cd(spotPath);
        ROIStats = analyseROIStatsSingleDay(config); % analyse stuff ! :D
        ROIStatsStructs{iDay, spotNum} = ROIStats;
        ROISet = ROIStats.ROISet;
        o(['      #analys...MultiDay(): processing day %d/%d: "%s", spot %d/%d; "%s" ', ...
            'analyseSingleDay done (%3.1f sec).'], iDay, numel(daysWithSpot), currentDate, iSpot, ...
            numel(spotList), spotList{iSpot}, toc(analyseSingleDayTic), 2, dbgLevel);
        
        if masterConfig.doMultiDayAnalysis;
            
            filt = 'sgfilt';

            % extract the depth from the CaImgExp mat-file
            fullRawDataPath = [rawDataRootPath year filesep animalID filesep currentDate];
            stimFile = [fullRawDataPath filesep 'CaImgExp_' currentDate '.mat'];% load CaImgExp
            CaImgExpMat = load(stimFile); % load the CaImgExp mat-file
            iSpotInCaImgExp = str2double(strrep(spotList{iSpot}, 'spot', ''));
            spotStruct = CaImgExpMat.CaImgExp.spots{iSpotInCaImgExp};
            o(['      #analys...MultiDay(): processing day %d/%d: "%s", spot %d/%d; "%s" ', ...
                'depth loaded (%d um) (%3.1f sec).'], iDay, numel(daysWithSpot), currentDate, iSpot, ...
                numel(spotList), spotList{iSpot}, spotStruct.depth, toc(analyseSingleDayTic), 2, dbgLevel);

            % extract the number of ROIs (including neuropil) and create the range for this ROISet 
            %   in the global table 
            nROIs = size(ROISet, 1);
            ROIStatsGlobalRange = iROIStatsGlobal : iROIStatsGlobal + nROIs - 1;

            % extract all basic properties of the ROIs
            ROIStatsGlobal(ROIStatsGlobalRange, 1) = repmat({animalID}, nROIs, 1);
            ROIStatsGlobal(ROIStatsGlobalRange, 2) = repmat({currentDate}, nROIs, 1);
            ROIStatsGlobal(ROIStatsGlobalRange, 3) = repmat(spotList(iSpot), nROIs, 1);
            ROIStatsGlobal(ROIStatsGlobalRange, 4) = repmat({spotStruct.depth}, nROIs, 1);
            ROIStatsGlobal(ROIStatsGlobalRange, 5) = ROISet(:, 1);  % ROIID
            ROIStatsGlobal(ROIStatsGlobalRange, 6) = repmat({'unknown'}, nROIs, 1);  % ROIType
            
            % add the raw ROIStats for each ROI
            for iROI = 1 : nROIs;
                ROIStatsGlobal{ROIStatsGlobalRange(iROI), 7} = ROIStats.PS.(filt).raw(iROI, :);
            end;
            
            % extract the noise properties of the ROIs
            ROIStatsGlobal(ROIStatsGlobalRange, 8) = num2cell(ROIStats.stats.(filt).noiseLevels); % noise level
            
%             % allocate the structures to store responsiveness and tuning properties 
%             for iROI = 1 : nROIs;
%                 ROIStatsGlobal{ROIStatsGlobalRange(iROI), 9} = struct();
%                 ROIStatsGlobal{ROIStatsGlobalRange(iROI), 10} = struct();
%                 ROIStatsGlobal{ROIStatsGlobalRange(iROI), 11} = struct();
%                 ROIStatsGlobal{ROIStatsGlobalRange(iROI), 12} = struct();
%             end;
            
            % get the response "stat" types as unique fieldnames of the evokedResp structure
            respStats = unique(strrep(fieldnames(ROIStats.stats.(filt).evokedResp), 'Err', ''));
            nStats = numel(respStats);
            UOF = {'UniformOutput', false};
            % get the evoked response for each ROI-stimulus-statType as 3D matrix
            evokedRespEachStats = reshape(cell2mat(cellfun(@(fName)ROIStats.stats.(filt).evokedResp.(fName), ...
                respStats, UOF{:})), nStims, nStats, nROIs);
            % permute to have a nStats x nROIs x nStims matrix
            evokedRespEachStats = permute(evokedRespEachStats, [2 3 1]);
            % get the tuning properties for each ROI-statType as a nStats x nROIs matrix
            BFEachStats = cell2mat(cellfun(@(fName)ROIStats.stats.(filt).tuning.(fName).BF, respStats, UOF{:}));
            maxRespAtBFEachStats = ...
                cell2mat(cellfun(@(fName)ROIStats.stats.(filt).tuning.(fName).maxRespAtBF, respStats, UOF{:}));
            meanRespEachStats = ...
                cell2mat(cellfun(@(fName)ROIStats.stats.(filt).tuning.(fName).meanResp, respStats, UOF{:}));
            tuningIndex = find(strcmp(respStats, masterConfig.tuningStat));
            
            % extract the evoked response for each "stat" type and the tuning properties for one stat type
            for iROI = 1 : nROIs;
                ROIStatsGlobal{ROIStatsGlobalRange(iROI), 9} = evokedRespEachStats(:, iROI, :);
                ROIStatsGlobal{ROIStatsGlobalRange(iROI), 10} = BFEachStats(tuningIndex, iROI);
                ROIStatsGlobal{ROIStatsGlobalRange(iROI), 11} = maxRespAtBFEachStats(tuningIndex, iROI);
                ROIStatsGlobal{ROIStatsGlobalRange(iROI), 12} = meanRespEachStats(tuningIndex, iROI);
            end;
            
            % increment the counter
            iROIStatsGlobal = iROIStatsGlobal + nROIs;
            
        end;
        o('    #analys...MultiDay(): processing day %d/%d: "%s", spot %d/%d; "%s" done (%3.1f sec).', iDay, ...
            numel(daysWithSpot), currentDate, iSpot, numel(spotList), spotList{iSpot}, toc(spotTic), 2, dbgLevel);
        
    end;
    o('  #analys...MultiDay(): processing day %d/%d: "%s", %d spot(s) done (%3.1f sec).', ...
        iDay, numel(daysWithSpot), currentDate, numel(spotList), toc(dayTic), 2, dbgLevel);
    
end;

if masterConfig.doMultiDayAnalysis;

    cd(analysisPathExtended);
    
    % remove useless pre-allocated empty cells
    ROIStatsGlobal(cellfun(@isempty, ROIStatsGlobal(:, 1)), :) = [];

    %% Create the ROIPresence plot
    ROIIDWithSpots = cell(size(ROIStatsGlobal, 1), 1);
    for iROI = 1 : size(ROIIDWithSpots, 1);
        ROIIDWithSpots{iROI} = sprintf('%s_%s', strrep(ROIStatsGlobal{iROI, 3}, 'spot', 'sp'), ...
            ROIStatsGlobal{iROI, 5});
    end;

    % define the unique variables and count them
    uniqueROIIds = unique(ROIIDWithSpots);
    uniqueDays = unique(ROIStatsGlobal(:, 2));
    uniqueSpots = unique(ROIStatsGlobal(:, 3));
    nROIs = size(uniqueROIIds, 1);
    nDays = size(uniqueDays, 1);
    nSpots = size(uniqueSpots, 1);

    % get the ROI presences and get their BF & peakEvokedResp
    ROIsPresence = zeros(nROIs, nDays);
    ROIsBF = zeros(nROIs, nDays);
    ROIsPeakEvokedResp = zeros(nROIs, nDays);
    ROIsDepth = zeros(nROIs, nDays);
    for iDay = 1 : nDays;
        for iROI = 1 : nROIs;
            ROIsPresence(iROI, iDay) = ~isempty(ROIStatsGlobal(strcmp(ROIStatsGlobal(:, 2), uniqueDays{iDay}) & ...
                strcmp(ROIIDWithSpots(:, 1), uniqueROIIds{iROI}), :));

            if ROIsPresence(iROI, iDay);
                ROIsBF(iROI, iDay) = ROIStatsGlobal{strcmp(ROIStatsGlobal(:, 2), uniqueDays{iDay}) & ...
                    strcmp(ROIIDWithSpots(:, 1), uniqueROIIds{iROI}), 10};
                ROIsPeakEvokedResp(iROI, iDay) = ROIStatsGlobal{...
                    strcmp(ROIStatsGlobal(:, 2), uniqueDays{iDay}) & ...
                    strcmp(ROIIDWithSpots(:, 1), uniqueROIIds{iROI}), 11};
                ROIsDepth(iROI, iDay) = ROIStatsGlobal{...
                    strcmp(ROIStatsGlobal(:, 2), uniqueDays{iDay}) & ...
                    strcmp(ROIIDWithSpots(:, 1), uniqueROIIds{iROI}), 4};
            else
                ROIsBF(iROI, iDay) = NaN;
                ROIsPeakEvokedResp(iROI, iDay) = NaN;
                ROIsDepth(iROI, iDay) = NaN;
            end;
        end;
    end;

    % get the middle index of the spots in the unique list to display the label
    spotIndexMiddles = zeros(1, nSpots);
    for iSpot = 1 : nSpots;
        spotIndexMiddles(iSpot) = mean(find(~cellfun(@isempty, strfind(uniqueROIIds, ...
            strrep(uniqueSpots{iSpot}, 'spot', 'sp')))));
    end;

    % plot the ROI Presence
    if masterConfig.doSaveROIPresencePlot;
        saveNameROIPres = sprintf('%s_ROIPresence', animalID);
        figH = figure('Name', saveNameROIPres, 'NumberTitle', 'off');
        intensity = 0.4;
        colormap([intensity 0 0; 0 intensity 0; 0 intensity 0; 0 0 intensity]);
        ROIsPresence = ROIsPresence - 1;
        ROIsPresence(~cellfun(@isempty, strfind(uniqueROIIds, 'NPil')), :) = 1;
        imagesc(ROIsPresence, [-1 1]);
        set(gca, 'XTick', 1 : nDays, 'XTickLabel', uniqueDays, 'YTick', spotIndexMiddles, ...
            'YTickLabel', uniqueSpots, 'XLim', [0.5, nDays + 0.5], 'YLim', [0.5, nROIs + 0.5]);
        title(sprintf('ROI Presence for %s', animalID), 'Interpreter', 'none');
        makePrettyFigure(figH);
        set(gca, 'FontSize', 8);
        saveFigToDir(figH, saveNameROIPres, 'multiDayAnalysis', ...
            masterConfig.doSaveROIPresencePlot, 1, 1);
    end;
    
    %% spots response probability
    spotRespProb = zeros(1, nSpots);
    spotRespProbErr = zeros(1, nSpots);
    respProbIndex = find(strcmp(respStats, 'respProb'));
    if respProbIndex;
        for iSpot = 1 : nSpots;
            spotRespProbAllROIsCell = ROIStatsGlobal(~cellfun(@isempty, strfind(ROIIDWithSpots, ...
                strrep(uniqueSpots{iSpot}, 'spot', 'sp'))), 9);
            spotRespProbAllROIs = cell2mat(cellfun(@(x)reshape(x(respProbIndex, 1, :), 1, nStims), ...
                spotRespProbAllROIsCell, UOF{:})); %#ok<FNDSB>
            spotRespProb(iSpot) = nanmean(spotRespProbAllROIs(:));
    %         spotRespProbErr(iSpot) = nansem(spotRespProbAllROIs(:));
            spotRespProbErr(iSpot) = nanstd(spotRespProbAllROIs(:));
        end;

        % plot if required
        if masterConfig.doSaveSpotRespProbPlot;
            saveNameRespProb = sprintf('%s_SpotsRespProb', animalID);
            figRespProb = figure('Name', saveNameRespProb, 'NumberTitle', 'off');
            hold all;
            for iSpot = 1 : nSpots;
                errorbar(iSpot, spotRespProb(iSpot), spotRespProbErr(iSpot), '.');
            end;
            legend(arrayfun(@(iSpot)sprintf('%s (N=%d)', uniqueSpots{iSpot}, ...
                sum(~cellfun(@isempty, strfind(ROIIDWithSpots, strrep(uniqueSpots{iSpot}, 'spot', 'sp'))))), ...
                1 : nSpots, 'UniformOutput', false)');
            xlabel('Spots'); ylabel('Mean response probability of all ROIs for each spot');
            set(gca, 'XLim', [0.9, nSpots + 0.1], 'YLim', [0 1], 'YTick', (1 : 10) / 10, 'YTickLabel', (1 : 10) / 10, ...
                'XTick', 1 : nSpots, 'XTickLabel', uniqueSpots);
            title('Spots response probability accross all days');
            makePrettyFigure();
            saveFigToDir(figRespProb, saveNameRespProb, 'multiDayAnalysis', masterConfig.doSaveNvsNP1Plots, 1, 1);
        end;
    end;
    
    %% spots tuning
    spotTun = zeros(1, nSpots);
    spotTunErr = zeros(1, nSpots);
    for iSpot = 1 : nSpots;
        spotTunAllROIsCell = ROIStatsGlobal(~cellfun(@isempty, strfind(ROIIDWithSpots, ...
            strrep(uniqueSpots{iSpot}, 'spot', 'sp'))), 9);
        spotTunAllROIs = cell2mat(cellfun(@(x)reshape(x(tuningIndex, 1, :), 1, nStims), spotTunAllROIsCell, UOF{:}));
        spotTun(iSpot) = nanmean(spotTunAllROIs(:));
%         spotRespProbErr(iSpot) = nansem(spotRespProbAllROIs(:));
        spotTunErr(iSpot) = nanstd(spotTunAllROIs(:));
    end;
    
    % plot if required
    if masterConfig.doSaveSpotTunPlot;
        saveNameTun = sprintf('%s_SpotsTuning', animalID);
        figTun = figure('Name', saveNameTun, 'NumberTitle', 'off');
        hold all;
        for iSpot = 1 : nSpots;
            errorbar(iSpot, spotTun(iSpot), spotTunErr(iSpot), '.');
        end;
        legend(arrayfun(@(iSpot)sprintf('%s (N=%d)', uniqueSpots{iSpot}, ...
            sum(~cellfun(@isempty, strfind(ROIIDWithSpots, strrep(uniqueSpots{iSpot}, 'spot', 'sp'))))), ...
            1 : nSpots, 'UniformOutput', false)');
        xlabel('Spots'); ylabel('Max tuning of all ROIs for each spot');
        set(gca, 'XLim', [0.9, nSpots + 0.1], 'XTick', 1 : nSpots, 'XTickLabel', uniqueSpots);
        title('Spots tuning accross all days');
        makePrettyFigure();
        saveFigToDir(figTun, saveNameTun, 'multiDayAnalysis', masterConfig.doSaveNvsNP1Plots, 1, 1);
    end;
    
    % plot if required
    if masterConfig.doSaveSpotDayTimeCoursePlot;
        
        for iSpot = 1 : nSpots;
            %% plot for current spot
            spotNum = str2double(strrep(uniqueSpots{iSpot}, 'spot', ''));
            saveNameSpotDayTC = sprintf('%s_%s_dayTimeCourse', animalID, uniqueSpots{iSpot});
            figH = figure('Name', saveNameSpotDayTC, 'NumberTitle', 'off');
            
            % get the days where the spot is present
            daysForSpot = {};
            for iDay = 1 : nDays;
                if any(strcmp(ROIStatsGlobal(:, 2), uniqueDays{iDay}) & ...
                    strcmp(ROIStatsGlobal(:, 3), uniqueSpots{iSpot}));
                    daysForSpot{end + 1} = uniqueDays{iDay}; %#ok<AGROW>
                end;
            end;
            
            nDaysForSpot = numel(daysForSpot);
            for iDay = 1 : nDaysForSpot;
                
                subplot(3, nDaysForSpot, iDay);
                for iDayWS = 1 : numel(daysWithSpot);
                    if strcmp(daysWithSpot(iDayWS).day, daysForSpot{iDay});
                        dayNum = iDayWS;
                        break;
                    end;
                end;
%                 matFilePath = sprintf('./%s/%s/%s.mat', daysForSpot{iDay}, uniqueSpots{iSpot}, ...
%                     configStructs{dayNum, spotNum}.runFileIDs{2});
%                 matFileStruct = load(matFilePath);
%                 refImg = matFileStruct.(genvarname(configStructs{dayNum, spotNum}.runFileIDs{2})).refImg;
                
                refChannel = 2;
                expInfoFilePath = sprintf('./%s/ExperimentInfo.mat', daysForSpot{iDay});
                expInfoStruct = load(expInfoFilePath);
                expInfo = expInfoStruct.expInfo;
                refImagesFileName = expInfo(strcmp(uniqueSpots{iSpot}, expInfo(:, 1)) ...
                    & strcmp(expInfo(:, 2), 'Ref256x'), :);
                firstRefImageFileName = refImagesFileName{1, 3};
                
                matFilePath = sprintf('./%s/%s/%s.mat', daysForSpot{iDay}, uniqueSpots{iSpot}, ...
                    firstRefImageFileName);
                matFileStruct = load(matFilePath);
                refImg = matFileStruct.(genvarname(firstRefImageFileName)).img_data;

                imshow(imadjust(linScale(double(refImg{refChannel}))));
                title(sprintf('Day %d', iDay));
                set(gca, 'Visible', 'off');
                
                
                subplot(3, nDaysForSpot, [iDay + nDaysForSpot, iDay + 2 * nDaysForSpot]);
                evokedRespsAll = ROIStatsStructs{dayNum, spotNum}.PS.sgfilt.trial.mean.allNorm;
                nSpotROIs = size(evokedRespsAll, 2);
%                 selROIs = 1 : nSpotROIs;
                selROIs = unique(randi(nSpotROIs, min(round(nSpotROIs * 0.5), 7), 1));
%                 selROIs = [2 6 8 22 23 24]; 130711_01 - spot04
%                 selROIs = [1 : 4, 7, 15, 17]; 130711_01 - spot02
                ROIStatsStructs{dayNum, spotNum}.ROISet(selROIs, 1);
                nSelROIs = numel(selROIs);
%                 selStims = [2 5 8 9 13];
                selStims = 1 : nStims;
                nSelStims = numel(selStims);
                hold on;
                evokedRespsToDisplay = evokedRespsAll(:, selROIs, selStims);
                minData = min(evokedRespsToDisplay(:));
                maxData = max(evokedRespsToDisplay(:));
                yShift = abs(maxData) + abs(minData);
                for iSelROI = 1 : nSelROIs;
                    iROI = selROIs(iSelROI);
                    evokedResps = evokedRespsAll(:, iROI, selStims);
                    evokedResps = reshape(evokedResps, size(evokedResps, 1), nSelStims);
                    plot(evokedResps + yShift * (iSelROI) + minData);
                end;
%                 set(gca, 'Visible', 'off');
                ylim([-2, yShift * nSelROIs]);
                
            end;
            
%             tightfig();
            makePrettyFigure();
            saveFigToDir(figH, saveNameSpotDayTC, 'multiDayAnalysis', masterConfig.doSaveSpotDayTimeCoursePlot, 1, 1);
        end;
    end;

    %% do the N VS N+1 plots for each spot and pooled
    if masterConfig.doSaveNvsNP1Plots;
        
        groupMethods = {'ROIName', 'SpotName', 'Depth'};
        nGroups = numel(groupMethods);
        animalShortID = strrep(animalID, 'mou_bl_', '');
        
        for iSpot = 1 : nSpots + 1;
            if iSpot == nSpots + 1;
                spotShortName = 'allSpots';
                ROIIndForSpot = true(nROIs, 1);
            else
                spotShortName = strrep(uniqueSpots{iSpot}, 'spot', 'sp');
                ROIIndForSpot = ~cellfun(@isempty, strfind(uniqueROIIds, spotShortName));
            end;
            
            ROIsBFForSpot = ROIsBF(ROIIndForSpot, :);
            ROIsPeakEvokedRespForSpot = ROIsPeakEvokedResp(ROIIndForSpot, :);
            uniqueROIIdsForSpot = uniqueROIIds(ROIIndForSpot);
            
            figH = figure('NumberTitle', 'off', 'Name', sprintf('%s_%s', animalShortID, spotShortName));
            for iGroup = 1 : nGroups;
                groupMeth = groupMethods{iGroup};
                switch groupMeth;
                    case 'ROIName';
                        % group by ROI name - one color per ROI
                        groupingIDs = uniqueROIIdsForSpot;
                    case 'SpotName';
                        % group by spot - one color per spot
                        groupingIDs = regexprep(uniqueROIIdsForSpot, '_(\d+|NPil)', '');
                    case 'Depth';
                        % group by depth - color depends on depth
                        ROIMeanDepth = nanmean(ROIsDepth(ROIIndForSpot, :), 2);
                        minDepth = min(ROIMeanDepth);
                        groupingIDs = round(ROIMeanDepth - minDepth);
                end;

                subplot(2, nGroups, iGroup);
                saveName = sprintf('%s_%s_NVSNP1_BF_%s', animalShortID, spotShortName, groupMeth);
                plotNVSNP1(ROIsBFForSpot / 1000, groupingIDs, 'Best Freq. [kHz]', saveName, 0, 0);

                subplot(2, nGroups, iGroup + nGroups);
                saveName = sprintf('%s_%s_NVSNP1_PeakResp_%s', animalShortID, spotShortName, groupMeth);
                plotNVSNP1(ROIsPeakEvokedRespForSpot, groupingIDs, ...
                    'Max Evoked Resp. [% dFF/dRR]', saveName, 0, 0);
            end;
            
            saveFigToDir(figH, sprintf('%s_%s_NVSNP1', animalShortID, spotShortName), 'multiDayAnalysis', ...
                masterConfig.doSaveNvsNP1Plots, 1, 1);
        end;
    end;

    
end;

end

