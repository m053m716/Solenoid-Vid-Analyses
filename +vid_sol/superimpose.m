function [fig,n,scaledCurve] = superimpose(spike_ts,averageCurve,tVid)
%% SUPERIMPOSE
%
%   fig = SUPERIMPOSE(spike_ts,averageCurve,tVid)
%
%   --------
%    INPUTS
%   --------
%   spike_ts    :       Array corresponding to single channel from spike_ts
%                           cell array that has lists of spike times
%                           relative to 0 for all channels on recording
%                           arrays.
%
%   averageCurve    :   Solenoid video pixel values averaged over many
%                           trials of the solenoid stimulus. Taken from
%                           cell array where each element is a different
%                           pixel value (e.g. x- or y- or distance etc)
%
%   tVid            :   Times corresponding to the video frames.
%

%% DEFAULTS
BIN_VEC = linspace(-0.2,0.3,251);

%%
fig = figure('Name','Superimposed Spike Histogram');
n = histcounts(spike_ts,BIN_VEC);
bar(BIN_VEC(1:(end-1)),n);  hold on;

if iscell(averageCurve)
    scaledCurve = cell(size(averageCurve));
    for ii = 1:numel(averageCurve)
        scaledCurve{ii} = (averageCurve{ii} - min(averageCurve{ii}));
        scaledCurve{ii} = (scaledCurve{ii}./max(scaledCurve{ii})).*max(n);
%         plot(tVid,scaledCurve{ii},'LineWidth',2,'Color','r');
        plot(tVid,scaledCurve{ii},'LineWidth',2);
    end
else
    scaledCurve = (averageCurve - min(averageCurve));
    scaledCurve = (scaledCurve./max(scaledCurve)).*max(n);
    plot(tVid,scaledCurve,'LineWidth',2,'Color','r');
end

xlim([min(tVid),max(tVid)]);