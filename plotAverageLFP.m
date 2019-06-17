function plotAverageLFP(data,meta,name)
%% PLOTAVERAGELFP    Averages LFP data together and plots


t = data{1}.t;
if nargin > 2
    rat = strsplit(name,'_');
    rat = rat{1};
end

for ii = 1:size(data{1}.lfp_data,1)
    tmp = zeros(numel(data),size(data{1}.lfp_data,2));
    for ik = 1:numel(data)
        if size(data{ik}.lfp_data,2)==size(tmp,2)
            tmp(ik,:) = data{ik}.lfp_data(ii,:);
        else
            tmp(ik,:) = nan(1,size(tmp,2));
        end
    end
    
    avgLFP = nanmean(tmp,1);
    avgLFP = avgLFP(1:1000:end);
    
    e = nanstd(tmp,[],1)./sqrt(numel(data));
    e = e(1:1000:end);
    e = [avgLFP-e;avgLFP+e;nan(1,numel(e))];
    e = reshape(e,1,numel(e));
    
    tt = data{1}.t(1:1000:end);
    tt = [tt;tt;nan(1,numel(tt))]; %#ok<*AGROW>
    tt = reshape(tt,1,numel(tt));
    
    offset = 0.3 * ii/size(data{1}.lfp_data,1);
    if nargin > 2
        fig = figure('Name',sprintf('%s-%s: Average LFP',name,...
            meta.amplifier_channels(ii).native_channel_name),...
            'Units','Normalized',...
            'Position',[0.2 + offset, 0.3 + offset, 0.3 0.3],...
            'Color','w');
    else
        figure('Name',sprintf('Channel %s: Average LFP',...
            meta.amplifier_channels(ii).native_channel_name),...
            'Units','Normalized',...
            'Position',[0.2 + offset, 0.3 + offset, 0.3 0.3],...
            'Color','w');
    end
    
    plot(t(1:1000:end),avgLFP,'Color','k','Linewidth',2);
    hold on;
    line([0 0],[-100 100],'Color','m','LineStyle','--','LineWidth',2);
    line(tt,e,'Color','r','LineStyle',':','LineWidth',1);
    
    xlabel('Time (sec)','FontName','Arial','FontSize',14,'Color','k');
    ylabel('Amplitude (\muV)','FontName','Arial','FontSize',14,'Color','k');
    title([meta.amplifier_channels(ii).native_channel_name ': <LFP>'],...
        'FontName','Arial','FontSize',16,'Color','k');
    
    if nargin > 2
        if exist(fullfile(rat,'LFP'),'dir')==0
            mkdir(fullfile(rat,'LFP'));
        end
        savefig(fig,fullfile(rat,'LFP',[name '_' meta.amplifier_channels(ii).native_channel_name '_LFP.fig']));
        saveas(fig,fullfile(rat,'LFP',[name '_' meta.amplifier_channels(ii).native_channel_name '_LFP.png']));
        delete(fig);
    end
end



end