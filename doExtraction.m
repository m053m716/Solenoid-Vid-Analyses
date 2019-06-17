function doExtraction(xlsxFile,subset)
%% DOEXTRACTION   Do data extraction for the given xlsx file
%
%  DOEXTRACTION;
%  DOEXTRACTION(xlsxFile);
%
%  --------
%   INPUTS
%  --------
%  xlsxFile    :     (Optional) char array of the xlsx file to use to point
%                       to the recordings. If not specified, a UI will
%                       prompt for the xlsx file to use.
%
%  --------
%   OUTPUT
%  --------
%  Saves all the relevant data in the current directory.
%
% By: Max Murphy  v1.0  2019-06-01

%%
TANK = 'R:\Rat\Intan'; % Path holding animal folders that hold .rhs files

%% PARSE INPUT
if nargin < 1
   [fname,pname] = uigetfile('*.xlsx','Select RAT xlsx file',pwd);
   if fname == 0
      disp('No file selected. Script canceled.');
      return;
   else
      xlsxFile = fullfile(pname,fname);
   end
else
   [~,fname,ext] = fileparts(xlsxFile);
   fname = [fname ext];
end

rat = strsplit(fname,'.');
rat = rat{1};

T = readtable(xlsxFile);

if nargin < 2
   subset = 1:size(T,1);
else
   subset = reshape(subset,1,numel(subset)); % ensure correct orientation
end

%% 
path = fullfile(TANK,rat);
for ii = subset
   F = dir(fullfile(path,[rat '*_' T.Name{ii} '_*.rhs']));
   fsize = [F.bytes];
   th = mean(fsize) - 4*std(fsize);
   F(fsize < th) = [];
   name = {F.name}.';
   filenames = fullfile(path,name);
   getExperimentalData(filenames);
end