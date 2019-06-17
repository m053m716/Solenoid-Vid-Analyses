function makeFullFigs(xlsxFile)
%% MAKEFULLFIGS   Make full figure for each recording in xlsx file
%
%  MAKEFULLFIGS(xlsxFile);
%
% By: Max Murphy  v1.0  2019-06-03  Original version (R2017a)

%%
if iscell(xlsxFile)
   for ii = 1:numel(xlsxFile)
      makeFullFigs(xlsxFile{ii});
   end
   return;
end

%%
T = readtable(xlsxFile);



end