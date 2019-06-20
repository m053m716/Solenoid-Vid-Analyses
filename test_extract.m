clear; clc;
F = dir('R:\Rat\Intan\R19-104\R19-104_2019_05_31_Site2AB-LSolenoid-1*.rhs');

filenames = cell(size(F,1),1);
for iF = 1:numel(F)
   filenames{iF} = fullfile(F(iF).folder,F(iF).name); 
end

run_all_experiments(filenames);