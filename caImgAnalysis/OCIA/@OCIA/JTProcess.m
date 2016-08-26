function JTProcess(this, processMode, varargin)
% JTProcess - [no description]
%
%       JTProcess(this, processMode, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% abort if no frame set
if this.GUI.jt.iFrame == 0; return; end;

% if no mode specified, set mode to empty
if ~exist('processMode', 'var'); processMode = ''; end;

% if the auto-track checkbox triggered the call but it was a de-activation event, abort
if strcmp(processMode, 'autoTrackChanged') && ~get(this.GUI.handles.jt.autoTrack, 'Value');
    
    % display message and stats
    nFramesTracked = this.GUI.jt.iFrame - this.GUI.jt.startFrame;
    if nFramesTracked > 0;
        timeTracked = toc(this.GUI.jt.startTime);
        showMessage(this, sprintf('Stopped auto-tracking of joints (%d frames in %.1f seconds, %.1f frames/sec).', ...
            nFramesTracked, timeTracked, nFramesTracked / timeTracked));
    else
        showMessage(this, 'Auto-tracking disabled.', 'yellow');
    end;
    
    % reset the counters
    this.GUI.jt.startFrame = [];
    this.GUI.jt.endFrame = [];
    this.GUI.jt.startTime = [];
    
    % set the focus to the frame setter if the call was from a GUI element
    if numel(varargin); uicontrol(this.GUI.handles.jt.frameSetter); end;
    return;
    
% if the process all button triggered the call, launch the processing of all frames
elseif strcmp(processMode, 'all');
    
    % activate auto-track and process until the end
    set(this.GUI.handles.jt.autoTrack, 'Value', 1);
    % set the counters
    this.GUI.jt.startFrame = this.GUI.jt.iFrame;
    this.GUI.jt.endFrame = this.jt.nFrames;
    this.GUI.jt.startTime = tic;
    set(this.GUI.handles.jt.frameSetter, 'Value', min(this.GUI.jt.iFrame + 1, this.jt.nFrames));
    
    showMessage(this, 'Started auto-tracking joints ...', 'yellow');
    
end;

processTic = tic; % for performance timing purposes

% get what to plot
showDebugPlot = get(this.GUI.handles.jt.viewOpts.debugPlots, 'Value');

% get the current frame, the joint type and others
iFrame = this.GUI.jt.iFrame;
selectedJoints = this.GUI.jt.iJoint;
iJointType = find(strcmp('auto', this.jt.jointTypes(:, 2)), 1, 'first');
iRefJointType = iJointType;
jConfig = this.jt.jointConfig;

o('#JTProcess(): frame %d, jointType %d, endFrame: %d, selectedJoints:%s ...', iFrame, iJointType, ...
    this.GUI.jt.endFrame, sprintf(' %d', selectedJoints), 4, this.verb);

% if on first frame
if iFrame == 1;
    if all(all(this.jt.joints(selectedJoints, iFrame, :, iJointType)));
        showMessage(this, 'All selected joint are placed, you can move on to the next frames ...');
    else
        showMessage(this, 'Not all selected joints are placed, please place them before moving on.', 'yellow');
    end;
    if strcmp(processMode, 'all') && get(this.GUI.handles.jt.processAll, 'Value');
        set(this.GUI.handles.jt.frameSetter, 'Value', iFrame + 1);
    else
        % set the focus to the frame setter if the call was from a GUI element
        if numel(varargin); uicontrol(this.GUI.handles.jt.frameSetter); end;
    end;
    return;
end;

% check if the previous frame that has the selected joints set in the current joint type
iRefFrame = [];
if iFrame > 1 && all(all(this.jt.joints(selectedJoints, iFrame - 1, :, iJointType)));
    iRefFrame = iFrame - 1;
end;

% if no reference frame found, abort
if isempty(iRefFrame);
%     showWarning(this, 'OCIA:JT:JTProcess:NoRef', ...
%         'No neighboring reference frame found! Please annotate previous frame.');
    % set the focus to the frame setter if the call was from a GUI element
    if numel(varargin); uicontrol(this.GUI.handles.jt.frameSetter); end;
    return;
end;

% close old debug plots and reset the image's display
close(findobj('Tag', 'JTFindJointDebugPlots'));
JTUpdateGUI(this);

%% process each joint
newCoords = zeros(this.jt.nJoints, 2);

% loop over each joint
for iJoint = this.jt.jointProcessOrder;

    % skip virtual joints, non-selected joints or enforeced joints
    if jConfig{iJoint, 2} || ~any(iJoint == selectedJoints) || this.GUI.jt.forcedJoints(iJoint, iFrame, iJointType);
        continue;
    end;
    
    % get the right frames to use
    if this.GUI.handles.jt.viewOpts.preProc;    framesToUse = this.jt.frames;
    else                                        framesToUse = this.jt.oriFrames;
    end;
    
    % get the standard box size and use it for getting the frame-wise correlation within the bounding box
    boxSize = jConfig{iJoint, 3}(2, :);
    % make sure box sides are always odd length
    for i = 1 : 2; if mod(boxSize(i), 2) == 0; boxSize(i) = boxSize(i) - 1; end; end;
    % get the coordinates from the previous frame
    refCoords = squeeze(this.jt.joints(iJoint, iRefFrame, :, iRefJointType))';
    % build the box's limits and crop the images
    boxLim = [refCoords - boxSize / 2, boxSize - 1]; % use -1 to get the size right
    img = imcrop(framesToUse(:, :, iFrame), boxLim);
    refImg = imcrop(framesToUse(:, :, iRefFrame), boxLim);
    % get the frame-wise correlation from the reference to the current frame
    frameCorr = getFrameCorr(img, refImg);

    % adjust the box's size using the frame-wise correlation: get the box limits and the maximum size range
    minBoxSize = jConfig{iJoint, 3}(1, :); maxBoxSize = jConfig{iJoint, 3}(3, :);
    boxSizeRangeDiff = maxBoxSize - minBoxSize;
    % set the maximum and minimum expected correlation change
    minFrameCorr = 0.65; maxFrameCorr = 0.95; frameCorrDiff = maxFrameCorr - minFrameCorr;
    % adjust the box's size according to the frame-wise correlation (linear relationship)
    boxSize = round(min(boxSizeRangeDiff * (1 - (max(frameCorr - minFrameCorr, 0) / frameCorrDiff)) + minBoxSize, maxBoxSize));
    % make sure box sides are always odd length
    for i = 1 : 2; if mod(boxSize(i), 2) == 0; boxSize(i) = boxSize(i) - 1; end; end;
    o('#JTProcess(): joint %d, img vs refImg correlation (frame %d vs %d) : %.4f => boxSize: [%d, %d] => [%d, %d].', ...
        iJoint, iFrame, iRefFrame, frameCorr, jConfig{iJoint, 3}(2, :), boxSize, 2, this.verb);
     
    % build the box's new limits and crop the images with the new limits
    boxLim = floor([refCoords - boxSize / 2, boxSize - 1]); % use -1 to get the size right
    img = imcrop(framesToUse(:, :, iFrame), boxLim);
    refImg = imcrop(framesToUse(:, :, iRefFrame), boxLim);
    
    % crop the mask unless it is empty
    jointMask = this.jt.jointROIMasks{iJoint};
    if ~isempty(jointMask); jointMask = imcrop(jointMask, boxLim); end;
    
    % set the bounding boxe's limits
    this.GUI.jt.boundBoxPos(iJoint, iFrame, iJointType, :) = [refCoords - boxSize / 2 boxSize];
    
    % find the joint and store the coordinates
    newCoords(iJoint, :) = JTFindJoint(this, img, refImg, jointMask, iJoint, iFrame, iRefFrame, ...
        [boxLim(1), boxLim(2)], showDebugPlot);
    
    % store the joints
    this.jt.joints(iJoint, iFrame, :, iJointType) = newCoords(iJoint, :);
    
end;

% try to find virtual joints
JTUpdateVirtualJoints(this, iFrame, iJointType);
% refresh the joints' display
JTUpdateGUI(this);
    
% tile the figures if any
if showDebugPlot;
    tilefigs();
    figure(this.GUI.figH);
end;

% if the auto-track is still on and we are not at the last target frame yet, go on for the next frame
if get(this.GUI.handles.jt.autoTrack, 'Value') && ~isempty(this.GUI.jt.endFrame) && iFrame <= this.GUI.jt.endFrame;
    
    o('#JTProcess(): frame %d, jointType %d, selectedJoints: %s done (%3.1f sec).', iFrame, iJointType, ...
        sprintf(' %d', selectedJoints), toc(processTic), 3, this.verb);
    
    % if we are not at the end yet, go to next frame
    if iFrame < this.GUI.jt.endFrame;
        
        o('#JTProcess(): moving on to frame %d ...', iFrame + 1, 3, this.verb);
    	set(this.GUI.handles.jt.frameSetter, 'Value', iFrame + 1);
        
    % if we reached the last frame, enforce the last points and refresh the display
    else
        
        o('#JTProcess(): stopping and validating last joint.', 3, this.verb);
        this.GUI.jt.forcedJoints(this.GUI.jt.iJoint, this.GUI.jt.iFrame, this.GUI.jt.iJointType) = 1;
        JTUpdateGUI(this);
        % set the focus to the frame setter if the call was from a GUI element
        if numel(varargin); uicontrol(this.GUI.handles.jt.frameSetter); end;
        
        % display message and stats
        nFramesTracked = this.GUI.jt.iFrame - this.GUI.jt.startFrame;
        if nFramesTracked > 0;
            timeTracked = toc(this.GUI.jt.startTime);
            showMessage(this, sprintf('Stopped auto-tracking of joints (%d frames in %.1f seconds, %.1f frames/sec).', ...
                nFramesTracked, timeTracked, nFramesTracked / timeTracked));
        else
            showMessage(this, 'Auto-tracking disabled.', 'yellow');
        end;
        
        % reset the counters
        this.GUI.jt.startFrame = [];
        this.GUI.jt.endFrame = [];
        this.GUI.jt.startTime = [];
        
    end;
    
    return;
    
end;

% set the focus to the frame setter if the call was from a GUI element
if numel(varargin); uicontrol(this.GUI.handles.jt.frameSetter); end;

o('#JTProcess(): frame %d, jointType %d, selectedJoints: %s done (%3.1f sec).', iFrame, iJointType, ...
    sprintf(' %d', selectedJoints), toc(processTic), 4, this.verb);

end
