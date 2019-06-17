function [spike_ts,spike_cell,goodIdx] = plotSpikePETH(data,spikes,meta,name)
%% PLOTSPIKEPETH  Plot spike peri-event time histogram

%%
COL = {[1.0 0.3 0.3]; [0.3 0.3 1.0]; [0.3 0.75 0.3]};
PROBE = {'A';'B';'C'};

%%
if nargin > 3
   stimType = strsplit(name,'_');
   rat = stimType{1};
   stimType = stimType{5};
   stimType = strsplit(stimType,'-');
   stimType = stimType{2};
end

nCh = size(spikes{1},1);
spike_ts = cell(nCh,1);
spike_cell = cell(nCh,1);
goodIdx = [];
for ii = 1:nCh
   spike_cell{ii} = cell(numel(spikes),1);
   for ik = 1:numel(spikes)
      tt = data{ik}.t(logical(spikes{ik}(ii,:)));
      spike_ts{ii} = [spike_ts{ii}, tt];
      spike_cell{ii}{ik} = tt;
   end
   offset = 0.3 * (ii/nCh);
   
   
   if ~isempty(spike_ts{ii})
      chName = meta.amplifier_channels(ii).native_channel_name;
      if nargin > 3
         fig = figure('Name',sprintf('%s-%s: Spike PETH',name,chName),...
            'Units','Normalized',...
            'Color','w',...
            'Position',[0.2+offset 0.2+offset 0.3 0.3]);
      else
         figure('Name',sprintf('%s: Spike PETH',...
            meta.amplifier_channels(ii).native_channel_name),...
            'Units','Normalized',...
            'Color','w',...
            'Position',[0.2+offset 0.2+offset 0.3 0.3]);
      end
      
      switch(upper(chName(1)))
         case {'A','B','C'}
            histogram(spike_ts{ii},linspace(-0.2,0.3,251),...
               'EdgeColor','none',...
               'FaceColor',COL{strcmp(PROBE,chName(1))});
         otherwise 
            histogram(spike_ts{ii},linspace(-0.2,0.3,251));
      end
      xlabel('Time (sec)','FontName','Arial','Color','k','FontSize',14);
      ylabel('Count','FontName','Arial','Color','k','FontSize',14);
      
      
      goodIdx = [goodIdx,ii]; %#ok<*AGROW>
      if nargin > 3
         title(sprintf('%s-%s: %s PETH',rat,chName,stimType),'FontName','Arial','Color','k','FontSize',16);
         if exist(fullfile(rat,'PETH'),'dir')==0
            mkdir(fullfile(rat,'PETH'));
         end
         savefig(fig,fullfile(rat,'PETH',[name '_'  chName '_PETH.fig']));
         saveas(fig,fullfile(rat,'PETH',[name '_' chName '_PETH.png']));
         delete(fig);
      else
         title(sprintf('%s: PETH',chName),'FontName','Arial','Color','k','FontSize',16);
      end
   end
end

end