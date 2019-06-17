function [figA,figB] = makeElectrodePlot_LFP(rat,site,rec,t_icms,t_sol)
%% MAKEELECTRODEPLOT_LFP    Make 32-channel layout electrode LFP averages
%
%  [figA,figB] = MAKEELECTRODEPLOT_LFP(rat,site,rec);
%
%  --------
%   INPUTS
%  --------
%    rat       :     Name of rat (e.g. 'R19-104')
%
%    site      :     Name of recording site (e.g. 'Site1AB')
%
%    rec       :     Name describing recording type (e.g. 'ICMS-0')
%
%  --------
%   OUTPUT
%  --------
%    figA       :     Figure handle to combined plot that incorporates
%                       subplots of PETH for each channel on the 4-shank,
%                       32-channel electrode on port A.
%
%    figB       :     Figure handle to combined plot that incorporates
%                       subplots of PETH for each channel on the 4-shank,
%                       32-channel electrode on port B.
%
% By: Max Murphy  v1.0  2019-05-31

%% LAYOUT
YLIM = [-750 750];
XLIM = [-0.25 0.4];

L = {'019','021','000','029',...
     '009','016','005','003',...
     '014','010','001','004',...
     '013','011','026','002',...
     '012','023','031','028',...
     '018','015','007','006',...
     '017','008','025','027',...
     '022','020','024','030'};

%% PARSE INPUT
if nargin < 4
   t_icms = nan;
end

if nargin < 5
   t_sol = nan;
end

%% FIND FILES
Fa = dir(fullfile(rat,'LFP',[rat '*_' site '-' rec '_A*_LFP.fig']));
Fb = dir(fullfile(rat,'LFP',[rat '*_' site '-' rec '_B*_LFP.fig']));

if numel(Fa) > 0
   figA = figure(...
      'Name',sprintf('Port-A LFP: %s_%s_%s',rat,site,rec),...
      'Color','w',...
      'Units','Normalized',...
      'Position',[0.05 0.1 0.4 0.8]);
end

if numel(Fb) > 0
   figB = figure(...
      'Name',sprintf('Port-B LFP: %s_%s_%s',rat,site,rec),...
      'Color','w',...
      'Units','Normalized',...
      'Position',[0.55 0.1 0.4 0.8]);
end

for ii = 1:numel(Fa)
   channel = strsplit(Fa(ii).name,'_');
   channel = channel{6};
   idx = find(ismember(L,channel(3:5)),1,'first');
   
   fig = openPlot(rat,site,rec,channel,t_icms,t_sol,'LFP');
   c = get(fig,'Children');
   cc = get(c,'Children');
   figure(figA);
   h = subplot(8,4,idx);
   copyobj(cc,h);
   set(h,'XLim',XLIM);
   set(h,'YLim',YLIM);
   delete(fig);
end

for ii = 1:numel(Fb)
   channel = strsplit(Fb(ii).name,'_');
   channel = channel{6};
   idx = find(ismember(L,channel(3:5)),1,'first');
   
   fig = openPlot(rat,site,rec,channel,t_icms,t_sol,'LFP');
   c = get(fig,'Children');
   cc = get(c,'Children');
   figure(figB);
   h = subplot(8,4,idx);
   copyobj(cc,h);
   set(h,'XLim',XLIM);
   set(h,'YLim',YLIM);
   delete(fig);
end

if nargout < 1
   if exist(fullfile(rat,'Combined-LFP'),'dir')==0
      mkdir(fullfile(rat,'Combined-LFP'));
   end
   
   savefig(figA,fullfile(rat,'Combined-LFP',sprintf('%s_%s_%s_A_Combined-LFP.fig',rat,site,rec)));
   saveas(figA,fullfile(rat,'Combined-LFP',sprintf('%s_%s_%s_A_Combined-LFP.png',rat,site,rec)));
   savefig(figB,fullfile(rat,'Combined-LFP',sprintf('%s_%s_%s_B_Combined-LFP.fig',rat,site,rec)));
   saveas(figB,fullfile(rat,'Combined-LFP',sprintf('%s_%s_%s_B_Combined-LFP.png',rat,site,rec)));
   
   delete(figA);
   delete(figB);
end




end