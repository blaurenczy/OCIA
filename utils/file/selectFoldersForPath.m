function selectFoldersForPath
% GUI selection of some commonly used folders to be added to the Matlab
% search path using addFolders2Path
% folders are added recursively

% create list dialog (paths are relative to localPath)
% / or \ does not matter

liststr = {...
    'Projects/AOD_imaging',...
    'Projects/AuditoryLearning',...
    'Projects/CalciumSim',...
    'Projects/EventDetect',...
    'Projects/NeuronSim',...
    'Projects/Oddball_2P',...
    'Projects/Oddball_Ephys',...
    'Projects/TwoPhotonAnalyzer',...
    'Projects/YCchronic',...
    'daq', ...
    };
[Selection,ok] = listdlg('liststring',liststr,'promptstring',...
    'Add folders to path','okstring','Do it','cancelstring','No way',...
    'Name','Path Selection','ListSize',[320 400]);
if ~ok, return, end

pathsSelected = cell(1,numel(Selection));
for n = 1:numel(Selection)
    pathsSelected{n} = liststr{Selection(n)};
end

% add recursively
addFolders2Path(pathsSelected,1);