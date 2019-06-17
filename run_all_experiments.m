function run_all_experiments(filenames)
%% RUN_ALL_EXPERIMENTS  View data for all of a day's recordings

%% LOAD DATA
load('FiltCoeffs.mat','SOS','G');
[data,meta] = read_Intan_RHS2000_file(SOS,G,filenames);

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

%% GET SPIKES & SAVE
spikes = quickSpikeDetect(data);
save(sprintf('%s.mat',rat),'data','spikes','meta','-v7.3');

%% VISUALIZE ALIGNED LFP
plotAverageLFP(data,meta,name);

%% VISUALIZE ALIGNED SPIKING
[~,spike_cell,goodIdx] = plotSpikePETH(data,spikes,meta,name);
for ii = goodIdx
   fig = figure('Name',sprintf('%s-%s: Raster',...
      name,meta.amplifier_channels(ii).native_channel_name),...
      'Units','Normalized',...
      'Color','w',...
      'Position',[0.3+0.1*randn(1) 0.3+0.1*randn(1) 0.3 0.3]);
   plotSpikeRaster(spike_cell{ii},'PlotType','vertline');
   line([0 0],[0 numel(data)+1],'Color','m','LineWidth',2,'LineStyle','--');
   
   if exist(fullfile(rat,'Rasters'),'dir')==0
      mkdir(fullfile(rat,'Rasters'));
   end
   savefig(fig,fullfile(rat,'Rasters',...
      [name '_' meta.amplifier_channels(ii).native_channel_name '_Raster.fig']));
   saveas(fig,fullfile(rat,'Rasters',...
      [name '_' meta.amplifier_channels(ii).native_channel_name '_Raster.png']));
   delete(fig);
end
end
