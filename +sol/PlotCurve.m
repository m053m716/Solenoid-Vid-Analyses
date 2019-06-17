function [fig,averageCurve] = PlotCurve(plotArray,nSamples,varName)
%Plot Average Curves

%% 
if nargin < 3
    varName = 'Data';
end

%% MAKE FIGURE
nSamples = 10

fig = figure('Name','Check Curve',...
    'Units','Normalized',...
    'Position',[0.1 0.1 0.8 0.8],...
    'Color','w');

ax = axes(fig,'Units','Normalized',...
    'Position',[0.1 0.1 0.8 0.8],...
    'NextPlot','add');

%% Plotaverage curve
reshaped = reshape(plotArray,nSamples,[]);
averageCurve = mean(reshaped,2); 

plot(ax,1:nSamples,reshaped,'Color',[0.7 0.7 0.7]); 
plot(ax,1:nSamples,averageCurve,'Color','k','LineWidth',2);
title(varName,'FontName','Arial','Color','k','FontSize',16);
xlabel('Samples','FontName','Arial','Color','k','FontSize',14);

end

