%% Check points
close all force;
varNames = T.Properties.VariableNames; 
fig = cell(size(varNames));
averageCurve = cell(size(varNames));
for ii = [2,5,8]
    plotArray = T.(varNames{ii});
    [fig{ii},averageCurve{ii}] = sol.PlotCurve(plotArray,10,varNames{ii});
end