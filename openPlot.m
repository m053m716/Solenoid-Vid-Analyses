function [fig,z,t] = openPlot(rat,site,rec,channel,t_icms,t_sol,type)
%% OPENPLOT  Opens relevant figure and scales x limits
%
%  fig = OPENPLOT(rat,site,rec,channel);
%  fig = OPENPLOT(rat,site,rec,channel,t_icms,t_sol,type);
%
%  --------
%   INPUTS
%  --------
%    rat       :     (Char) Name of rat (e.g. 'R19-94')
%
%    site      :     (Char) Recording site (e.g. Site3AB')
%
%    rec       :     (Char) Recording name (e.g. 'Solenoid+ICMS-0')
%
%   channel    :     (Char) Name of recording channel (e.g. 'A-017')
%
%    t_icms    :     (scalar double; optional) Time of ICMS
%
%    t_sol     :     (scalar double; optional) Time of solenoid
%
%   type       :     (Char; optional) Type of figure 
%                       -> ('Rasters'/'PETH' (def)/'LFP')
%
%  --------
%   OUTPUT
%  --------
%    fig       :     Figure handle to opened figure.
%
%     z        :     Data used to generate figure.
%
%     t        :     Times corresponding to each data point.
%
% If no output argument is specified, then a .svg file is exported to
% OUT_DIR (for figure creation etc.)

%% DEFAULTS
XLIM = [-0.02 0.28];
FIG_POS = [0.30 0.35 0.45 0.30];
OUT_DIR = 'G:\Lab Member Folders\Max Murphy\Writing\_MANUSCRIPTS\2019-05-23_SolenoidStim\Fig0-PrelimLatencies';

%% PARSE INPUT
if nargin < 5
   t_icms = nan;
end

if nargin < 6
   t_sol = nan;
end

if nargin < 7 % Parse TYPE info
   type = 'PETH';
end

% Parse RAT info
if exist(rat,'dir')==0
   [pname,fname] = fileparts(rat);
   if isempty(pname)
      rat = fullfile(pwd,fname);
   end
   error('%s does not exist.',rat);
end

F = dir(fullfile(rat,type,[rat '*.fig']));
block = strsplit(F(1).name,'_');
block = strjoin(block(1:4),'_');

switch type
   case 'Rasters'
      ext = 'Raster.fig';
   case 'PETH'
      ext = 'PETH.fig';
   case 'LFP'
      ext = 'LFP.fig';
   otherwise
      error('%s is not a valid type (check capitalization)',type);
end

fig = openfig(fullfile(rat,type,[block '_' site '-' rec '_' channel '_' ext]));
figure(fig);
set(fig,'Position',FIG_POS);
xlim(XLIM);

y = get(gca,'YLim');


switch type % Currently, only add extra for PETH
   case 'PETH'
      c = get(gca,'Children');

      idx = 0;
      for ii = 1:numel(c)
         if isa(c(ii),'matlab.graphics.chart.primitive.Histogram')
            idx = ii;
            break;
         end
      end
      t = c.BinEdges(1:(end-1)) + c.BinWidth/2;
      z = c.Values;
      [pk,loc] = findpeaks(z,t,...
         'MinPeakHeight',median(z)+(median(abs(median(z)-z)))*4,...
         'MinPeakProminence',(median(abs(median(z)-z)))*2.5);
      dloc = diff(loc);
      dpk = diff(pk);
   otherwise
      pk = [];
      loc = [];
      z = [];
      t = [];      
end

line(gca,[t_icms t_icms],y,'Color','m','LineStyle','--','LineWidth',2);
line(gca,[t_sol t_sol],y,'Color','k','LineStyle',':','LineWidth',2);


for ii = 1:numel(pk)
   curloc = loc(ii);
   curpk = pk(ii);
   if curloc > 0.012
      if ii > 1
         if (dloc(ii-1) < 0.012) && (abs(dpk(ii-1)) < 40)
            if (dpk(ii-1) > -40)
               curpk = curpk-40;
               if ii < numel(pk)
                  dpk(ii) = dpk(ii) + 40;
               end
            elseif (dpk(ii-1) < 40)
               curpk = curpk+40;
               if ii < numel(pk)
                  dpk(ii) = dpk(ii) - 40;
               end
            end            
         end
      end
      
      text(gca,curloc-0.004,curpk+25,...
         sprintf('%g ms',1000*loc(ii)),...
         'FontName','Arial','FontSize',12,...
         'FontWeight','bold',...
         'Color',[0.25 0.25 0.25]);
   end
end

% Only export if no output argument is called:
if nargout < 1
   out_dir = fullfile(OUT_DIR,block,channel);
   if exist(out_dir,'dir')==0
      mkdir(out_dir);
   end
   expAI(fig,fullfile(out_dir,[block '_' site '-' rec '_' channel]));
   saveas(fig,fullfile(out_dir,[block '_' site '-' rec '_' channel '.png']));
   delete(fig);
end


end