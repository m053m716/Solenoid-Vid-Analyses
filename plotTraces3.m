function fig = plotTraces3(data,meta,ch)
%% PLOTTRACES3  Superimpose individual 3D time / spikeData / NEO traces
%
%  fig = PLOTTRACES3(data,meta);
%  fig = PLOTTRACES3(data,meta,ch);
%
%  --------
%   INPUTS
%  --------
%    data      :     Cell array of struct containing extracted data from
%                       individual recordings.
%
%    meta      :     Metadata struct associated with data.
%
%     ch       :     Channel (integer; optional)
%
%  --------
%   OUTPUT
%  --------
%    fig       :     Figure handle
%
% By: Max Murphy  v1.0  2019-06-03

%% DEFAULTS
XLIM = [-5 35];
YLIM = [-1500 500];
ZLIM = [-200 5000];

%% PARSE INPUT
if nargin < 3
   ch = 1:numel(meta.amplifier_channels);
else
   ch = reshape(ch,1,numel(ch));
end

if nargin < 4
   field = 'amplifier_data';
else
   field = lower(field);
   fnames = fieldnames(data{1,1});
   if ~ismember(field,fnames)
      error('Invalid field: %s',field);
   end
end


%% MAKE FIGURE(S)
for iCh = ch
   chName = meta.amplifier_channels(ch).native_channel_name;
   fig = figure('Name',sprintf('%s: Superimposed Traces',chName),...
      'Units','Normalized',...
      'Position',[0.2 0.2 0.5 0.5],...
      'Color','w');

   ax = axes(fig,...
      'NextPlot','add',...
      'View',[30 30]);

   t = data{1}.t*1e3;
   sdata = nan(numel(data),numel(t));
   for ii = 1:numel(data)
      sdata(ii,:) = data{ii}.spike_data(iCh,:);
   end
   x_neo = mmNEO(sdata);
   plot3(ax,t,sdata,x_neo);

   title(chName,...
      'FontName','Arial','FontSize',18,'Color','k');
   xlabel('Time (ms)',...
      'FontName','Arial','Color','k','FontSize',14);
   ylabel('Amplitude (\muV)',...
      'FontName','Arial','Color','k','FontSize',14);
   zlabel('Nonlinear Energy Operator (a.u.)',...
      'FontName','Arial','Color','k','FontSize',14);
   xlim(XLIM);
   ylim(YLIM);
   zlim(ZLIM);
end
end