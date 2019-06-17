function [data,spikes,meta] = getExperimentalData(filenames)
%% GETEXPERIMENTALDATA  Extract & save experimental data
%
%  [data,spikes,meta] = GETEXPERIMENTALDATA(filenames);
%
%  --------
%   INPUTS
%  --------
%  filenames      :     Cell array of char specifying full filename of each
%                          recording in this experiment.
%
%  --------
%   OUTPUT
%  --------
%    data         :     Cell array of data for each experiment.
%
%    spikes       :     Cell array of detected spike indices for each
%                          experiment.
%
%    meta         :     Experiment metadata parsed from the first binary
%                          file in filenames.
%
% By: Max Murphy  v1.0  2019-06-01

%% LOAD DATA
load('FiltCoeffs.mat','SOS','G');
[data,meta] = read_Intan_RHS2000_file(SOS,G,filenames);

[~,name,~] = fileparts(filenames{1});
name = strsplit(name,'_');
rat = name{1};
name = strjoin(name(1:5),'_');

%% REMOVE "BAD" FILES
for ii = 1:numel(data)
   nSamples = numel(data{ii}.t);
end
nMode = mode(nSamples);
data(nSamples~=nMode) = [];

%% GET SPIKES & SAVE
spikes = quickSpikeDetect(data);

if nargout < 1
   save(sprintf('%s.mat',name),'data','spikes','meta','-v7.3');
end

end
