%% MAIN  This code does X
% By: Max Murphy / Zac Green  v1.0  2019-06-04

clear; clc

%% GET ACCESS TO VIDEO FILE(S) OF INTEREST
% doc fullfile
% doc uigetfile

VIDEOFILE = fullfile('K:\Rat\Video\Solenoid Experiments','R19-104_2019_05_31_Site2AB-LSolenoid-1.MP4');
v = VideoReader(VIDEOFILE);

%% FIND PROPER REGION TO "LOOK FOR" BLUE THRESHOLD
% Read in a frame of the video


% Plot it: doc imshow
% doc figure
% doc imagesc

A = 0;
v.CurrentTime = 1.1887;
video = readFrame(v);
ROI = roipoly(video);

                


% Set a region of interest:
%  doc imroi
%  doc imrect
   

%% DETERMINE HOW MANY FRAMES TO EXPORT
N = 10;

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
    %   (how to split into channels)
        
        
    
%    (video frames are stored as nRows x nColumns x 3 RGB matrices)
%
%     if (frame with blue light)
%        % doc imwrite
%        % doc mkdir
%        % doc exist
%     end
% end

tic;
v.CurrentTime = 0;
A = [];
while v.hasFrame
    video = readFrame(v);
    blue = video(:,:,3);
    meanB = mean(blue(ROI));
    if meanB >= 50 
        if isempty(A)
         A = [A;v.CurrentTime];
            fprintf(1,'Added time: %g\n',v.CurrentTime);
        end
        if ((v.CurrentTime-A)>.1)
            A = [A;v.CurrentTime];
            fprintf(1,'Added time: %g\n',v.CurrentTime);
        end
    end
end
        

%% CREATE FIGURE INTERFACE
pos = [0,0,0.5,0.5];
FigUI = figure('Name','MyUI','Units', 'normalized', 'Position',pos,'Color','w');
ax=axes(FigUI);
ax.XLim = [1,v.Width];
ax.YLim = [1,v.Height];
im=imagesc(ax,[1,v.Width],[1,v.Height],randn(v.Height,v.Width));
    
I = (video);
im.CData = I;

%% Array Calculations
%x = horizontal distance
xdcurrent = darray([(end-10)+1:end],1);
xscurrent = sarray([(end-10)+1:end],1);
x = xscurrent - xdcurrent;
%y = vertical distance
ydcurrent = darray([(end-10)+1:end],2);
yscurrent = sarray([(end-10)+1:end],2);
y = yscurrent - ydcurrent;
% xt = time
xt = sarray([(end-10)+1:end],3);
% d = distance
d = (x.^2 + y.^2).^(1/2)
% plot
plot(xt,d)

%% Check points
T = readtable('C:\Users\Zac Green\Documents\MyRepos\Solenoid-Vid-Analyses\Outputs\6-13-19-LoSD-max61s.xlsx');
close all force;
varNames = T.Properties.VariableNames; 
fig = cell(size(varNames));
averageCurve = cell(size(varNames));
for ii = [1,2,3,4,5,6,7,8]
    plotArray = T.(varNames{ii});
    [fig{ii},averageCurve{ii}] = sol.PlotCurve(plotArray,10,varNames{ii});
end

%% Full Script

VIDEOFILE = fullfile('K:\Rat\Video\Solenoid Experiments','R19-104_2019_05_31_Site2AB-LSolenoid-1.MP4');
v = VideoReader(VIDEOFILE);

A = 0;
v.CurrentTime = 1.1887;
video = readFrame(v);
ROI = roipoly(video);


tic;
v.CurrentTime = 0;
darray = []
sarray = []
plotarray=[]
dataarray=[]
A = [];
N=10
while v.hasFrame
%while v.CurrentTime < 30
    video = readFrame(v);
    blue = video(:,:,3);
    meanB = mean(blue(ROI));
    if meanB >= 50 
        if isempty(A)
            A = [A;v.CurrentTime];
            fprintf(1,'Added time: %g\n',v.CurrentTime);
        end
        if ((v.CurrentTime-A(end))>.1)
            A = [A;v.CurrentTime];
            fprintf(1,'Added time: %g\n',v.CurrentTime);
        end
        if ismember(v.CurrentTime,A)
            for k = 1:N
                % digit position (white)
                pos = [0,0,1,1];
                FigUI = figure('Name','MyUI','Units', 'normalized', 'Position',pos,'Color','w');
                ax=axes(FigUI);
                ax.XLim = [1,v.Width];
                ax.YLim = [1,v.Height];
                im=imagesc(ax,[1,v.Width],[1,v.Height],randn(v.Height,v.Width));
                I = (video);
                im.CData = I;
                darray = [darray; getPosition(impoint), v.CurrentTime];
                %darray = [darray; mean(getPosition(imfreehand)), v.CurrentTime];
                close 
                video = readFrame(v);
            end
            v.CurrentTime = (A(end)-.005)
            video = readFrame(v);
        end
        if ismember(v.CurrentTime,A)
            for k = 1:N
                %solenoid position (blue)
                pos = [0,0,1,1];
                FigUI = figure('Name','MyUI','Units', 'normalized', 'Position',pos,'Color','blue');
                ax=axes(FigUI);
                ax.XLim = [1,v.Width];
                ax.YLim = [1,v.Height];
                im=imagesc(ax,[1,v.Width],[1,v.Height],randn(v.Height,v.Width));
                I = (video);
                im.CData = I;
                sarray = [sarray; getPosition(impoint), v.CurrentTime];
                close
                video = readFrame(v);
            end
        end
       sol.TrialPlot
    end
end
toc;
