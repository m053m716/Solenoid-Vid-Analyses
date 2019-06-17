clear; clc;

% RAT = 'R19-94';
% PATH = fullfile('R:\Rat\Intan',RAT);
% REC = {'Site3AB-Solenoid+ICMS-0'; ... % L Solenoid 0ms   L ICMS 0ms
%        'Site3AB-Solenoid+ICMS-1'; ... % L Solenoid 0ms   L ICMS 50ms
%        'Site3AB-Solenoid+ICMS-2'; ... % L Solenoid 50ms  L ICMS 0ms
%        'Site3AB-Solenoid+ICMS-3'; ... % L Solenoid 0ms   R ICMS 0ms
%        'Site3AB-Solenoid+ICMS-4'; ... % R Solenoid 0ms   R ICMS 0ms
%        'Site3AB-Solenoid+ICMS-5'; ... % R Solenoid 0ms   R ICMS 50ms
%        'Site3AB-Solenoid+ICMS-6'; ... % R Solenoid 50ms  R ICMS 0ms
%        'Site3AB-Solenoid+ICMS-7'; ... % R Solenoid 0ms   L ICMS 0ms
%        'Site3AB-Solenoid+ICMS-8'; ... % R Solenoid 0ms   R ICMS 25ms
%        'Site3AB-Solenoid+ICMS-9'; ... % R Solenoid 25ms  R ICMS 0ms
%        'Site3AB-Solenoid+ICMS-10';... % R Solenoid 0ms   R ICMS 10ms
%        'Site3AB-Solenoid+ICMS-11';... % R Solenoid 0ms   L ICMS 10ms
%        'Site3AB-Solenoid+ICMS-12'};...% R Solenoid 0ms  LR ICMS 10ms
% REC = {'Site3AB-Catch-0'}; % L Solenoid 0ms   Solenoid Power Off
% REC = {'Site3AB-Solenoid-0';...     % L ICMS 0ms
%        'Site3AB-ICMS-0'};           % L Solenoid 0ms

% RAT = 'R19-101';
% PATH = fullfile('R:\Rat\Intan',RAT);
% Note: recordings below are listed in order taken:
% REC = {'Site1AB-Catch-0';              % No Solenoid       No ICMS
%        'Site1AB-RSolenoid-0';          % R Solenoid 0ms    No ICMS 
%        'Site1AB-RSolenoid+ICMS-0';     % R Solenoid 50ms   ICMS B-029 10ms
%        'Site1AB-RSolenoid+ICMS-1';     % R Solenoid 0ms    ICMS B-029 10ms
%        'Site1AB-RSolenoid+ICMS-2';     % R Solenoid 10ms   ICMS B-029 1ms
%        'Site1AB-RSolenoid+ICMS-3';     % R Solenoid 25ms   ICMS B-029 1ms
%        'Site1AB-RSolenoid+ICMS-4';     % R Solenoid 0ms    ICMS B-029 25ms
%        'Site1AB-RSolenoid-1';          % R Solenoid 0ms    No ICMS
%        'Site1AB-RSolenoid+ICMS-5';     % R Solenoid 0ms    ICMS B-002 25ms
%        'Site1AB-RSolenoid+ICMS-6';     % R Solenoid 0ms    ICMS B-027 25ms
%        'Site1AB-LSolenoid-0';          % L Solenoid 0ms    No ICMS
%        'Site1AB-LSolenoid+ICMS-0';     % L Solenoid 0ms    ICMS B-027 25ms
%        'Site1AB-LSolenoid+ICMS-1';     % L Solenoid 0ms    ICMS B-002 25ms
%        'Site1AB-LSolenoid+ICMS-2';     % L Solenoid 0ms    ICMS A-029 25ms
%        'Site1AB-LSolenoid+ICMS-3';     % L Solenoid 0ms    ICMS B-029 25ms
%        ... 'Site1AB-LSolenoid+ICMS-4';     % L Solenoid 0ms    ICMS A-002 25ms NO STIM ACTUALLY
%        'Site1AB-LSolenoid+ICMS-5';     % L Solenoid 0ms    ICMS A-027 25ms
%        'Site1AB-ICMS-0';               % No Solenoid       ICMS A-027 25ms
%        'Site1AB-ICMS-1';               % No Solenoid       ICMS A-002 25ms
%        'Site1AB-ICMS-2';               % No Solenoid       ICMS A-029 25ms
%        'Site1AB-ICMS-3';               % No Solenoid       ICMS B-002 25ms
%        ... 'Site1AB-ICMS-4';               % No Solenoid       ICMS B-027 25ms NO STIM ACTUALLY
%        'Site1AB-ICMS-5';               % No Solenoid       ICMS A-029 25ms
%        'Site1AB-LSolenoid+ICMS-6';     % L Solenoid 0ms    ICMS A-029 10ms
%        'Site1AB-LSolenoid+ICMS-7';     % L Solenoid 0ms    ICMS A-029 35ms
%        'Site1AB-LSolenoid-1';          % L Solenoid 0ms    No ICMS
%        'Site4AB-LSolenoid-0';          % L Solenoid 0ms    No ICMS
%        'Site4AB-L-ICMS-0';             % No Solenoid       ICMS A-024 10ms (R Elbow)
%        'Site4AB-L-ICMS-1';             % No Solenoid       ICMS B-025 10ms (L Forelimb)
%        'Site4AB-LSolenoid+ICMS-0';     % L Solenoid 0ms    ICMS A-024 10ms
%        'Site4AB-LSolenoid+ICMS-2';     % L Solenoid 10ms   ICMS B-025 0ms
%        'Site4AB-LSolenoid+ICMS-3';     % L Solenoid 10ms   ICMS A-024 0ms
%        };

RAT = 'R19-104';
PATH = fullfile('R:\Rat\Intan',RAT);
F = dir(fullfile(PATH,'R*.rhs'));
name = {F.name}.';
parsed = cell(size(name));
for ii = 1:numel(name)
   tmp = strsplit(name{ii},'_');
   parsed{ii} = tmp{5};
end
REC = unique(parsed);

for iR = 1:numel(REC)
   F = dir(fullfile(PATH,[RAT '*_' REC{iR} '_*.rhs']));
   fsize = [F.bytes];
   th = mean(fsize) - 4*std(fsize);
   F(fsize < th) = [];
   name = {F.name}.';
   filenames = fullfile(PATH,name);
   run_all_experiments(filenames);
end