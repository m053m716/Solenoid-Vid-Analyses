function fig = plotTraces(data,meta,ch,field)
%% PLOTTRACES  Superimpose individual traces to a figure
%
%  fig = PLOTTRACES(data,meta);
%  fig = PLOTTRACES(data,meta,ch);
%  fig = PLOTTRACES(data,meta,ch,field);
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
%    field     :     Fieldname of struct to plot (integer; optional)
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
      'NextPlot','add');

   for ii = 1:numel(data)
      plot(ax,data{ii}.t*1e3,data{ii}.(field)(iCh,:));
   end

   title(chName,...
      'FontName','Arial','FontSize',18,'Color','k');
   xlabel('Time (ms)',...
      'FontName','Arial','Color','k','FontSize',14);
   ylabel('Amplitude (\muV)',...
      'FontName','Arial','Color','k','FontSize',14);
   xlim(XLIM);
   ylim(YLIM);
end
end