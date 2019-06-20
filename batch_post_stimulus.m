clear; close all force; clc;
% For just looking at one particular recording (experiment within a
% session)

%% LOAD DATA
load('FiltCoeffs.mat','SOS','G');
[data,meta] = read_Intan_RHS2000_file(SOS,G);
[~,name,~] = fileparts(filenames{1});
name = strsplit(name,'_');
rat = name{1};
name = strjoin(name(1:5),'_');

%% REMOVE "BAD" FILES
for ii = 1:numel(data)
   nSamples = numel(data{ii}.t);
end
nMode = mode(nSamples);
data(nSamples~=nMode) = [];

%% VISUALIZE ALIGNED LFP
plotAverageLFP(data,meta,name);

%% GET SPIKES
spikes = quickSpikeDetect(data,meta);

%% VISUALIZE ALIGNED SPIKING
[~,spike_cell,goodIdx] = plotSpikePETH(data,spikes,meta,name);
for ii = goodIdx
   figure('Name',sprintf('%s: Raster',data{1}.amplifier_channels(ii).native_channel_name),...
      'Units','Normalized',...
      'Color','w',...
      'Position',[0.3+0.1*randn(1) 0.3+0.1*randn(1) 0.3 0.3]);
   plotSpikeRaster(spike_cell{ii},'PlotType','vertline');
   line([0 0],[0 numel(data)+1],'Color','m','LineWidth',2,'LineStyle','--');
end

