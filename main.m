%% MAIN  This code does X
% By: Max Murphy / Zac Green  v1.0  2019-06-04

clear; clc

%% GET ACCESS TO VIDEO FILE(S) OF INTEREST
% doc fullfile
% doc uigetfile
% VIDEOFILE = 'blablabla';
% v = VideoReader(VIDEOFILE);

%% FIND PROPER REGION TO "LOOK FOR" BLUE THRESHOLD
% Read in a frame of the video
% Plot it: doc imshow
% doc figure
% doc imagesc

% Set a region of interest:
%  doc imroi
%  doc imrect

%% DETERMINE HOW MANY FRAMES TO EXPORT
N_FRAMES = 10;

%% USE WHILE LOOP TO ITERATE ON V
% doc >=
% doc VideoReader.hasFrame
% doc &&
% doc &
% doc ||
% doc |
% doc while loop
% doc if
% doc switch case (may not need, but similar to if)

% while (some condition is true)
%    (content: go through all frames in video)
%    (check the frame for presence of blue pixels at some coordinate)
%    (video frames are stored as nRows x nColumns x 3 RGB matrices)
%
%     if (frame with blue light)
%        % doc imwrite
%        % doc mkdir
%        % doc exist
%     end
% end
