function varargout = Add2DataStructure(varargin)
% input 1 ... exisiting data structure created by ConvertRawData (or
% mat-file storing data structure as first variable)
% remaining inputs are 'Property' - 'Value' pairs as for ConvertRawData or
% a structure where Fieldnames are translated to properties and field
% values to values
% currently supported properties to add:
% 'RoiSet' - string with full path to IJ RoiSet.zip file or RoiSet cell
% array created by ij_roiDecoder
% 'Stim' - stimulation vector
% 'RefImg' - reference image for the current acquisition (e.g. 256x256
% average frame scan)
% 'tform' - a transformation matrix describing the transformation from
% movie to reference image
% the property 'SaveToDisk' (0 or 1) controls if the output structure is
% automatically saved to mat-file (default: 1), this property is itself not
% saved in the output structure

% this file written by Henry Luetcke (hluetck@gmail.com)

% current version: 2012-01-28

%% Parse inputs
% we need at least 2 inputs
if nargin < 2
   error('This function requires at least 2 input args.');
end
S = varargin{1};
if ischar(S) % assume mat-file and load first variable
    matSaveName = S;
    if ~exist(S, 'file')
           warning('Add2DataStructure:FileNotFound', 'Could not find file "%s", skipping it.', S);
        return;
    end;
    vars = whos('-file',S);
    S = load(S, vars(1).name);
    S = S.(vars(1).name);
else
    [path,matSaveName,ext] = fileparts(S.hdr.fileorigin);
    matSaveName = strrep(matSaveName,'__channel00','');
end
if ~isstruct(S)
   error('First input must be structure generated by ConvertRawData.');
end
inargs = varargin(2:end);
if isstruct(inargs{1})
    % convert structure to pseudo-input cellarray
    inargs = inargs{1};
    fields = fieldnames(inargs);
    pos = 1;
    inargs2 = {};
    for n = 1:length(fields)
        inargs2{pos} = fields{n}; pos = pos+1;
        inargs2{pos} = inargs.(fields{n}); pos = pos + 1;
    end
    inargs = inargs2;
end

% Reference image (e.g. 256x256 frame scan with averages)
% default reference image is the average image of each channel
SpInput = find(strcmpi(inargs, 'RefImg'));
if numel(SpInput)
    A = inargs{SpInput+1};
    if isstr(A)
        error('Reference image must be specified as numeric array');
    end
    S.refImg = A;
else
    if ~isfield(S,'refImg')
        for n = 1:numel(S.img_data)
            S.refImg{1,n} = mean(S.img_data{n},3);
        end
    end
end

% Tform
SpInput = find(strcmpi(inargs, 'tform'));
if numel(SpInput)
    S.tform = inargs{SpInput+1};
else
    S.tform = [];
end

% Roi set (Roi coordinates must be relative to the reference image)
SpInput = find(strcmpi(inargs, 'RoiSet'));
if numel(SpInput)
    roiSet = inargs{SpInput+1};
    if iscell(roiSet)
       S.roi = roiSet;
    elseif ischar(roiSet)
        try
            S.roi = ij_roiDecoder(roiSet,[size(S.refImg{1},1) size(S.refImg{1},2)]);
            S.roi = ij_RoiSetCompression(S.roi,1);
        catch
            warning('Failed to add roi file %s to data structure',roiSet);
        end
    else
        error('Values for RoiSet property must be string or cell arrays');
    end
end

% Stimulus
SpInput = find(strcmpi(inargs, 'Stim'));
if numel(SpInput)
    S.stim = inargs{SpInput+1};
end

S = orderfields(S);

% SaveToDisk
SpInput = find(strcmpi(inargs, 'SaveToDisk'));
if numel(SpInput)
   doSave = inargs{SpInput+1};
else
    doSave = 1;
end
if doSave
    SaveAndAssignInBase(S,matSaveName,'SaveOnly');
end


if nargout
   varargout{1} = S;
end




