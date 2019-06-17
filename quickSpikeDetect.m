function spikes = quickSpikeDetect(data,meta)
%% QUICKSPIKEDETECT  Use voltage_threshold in spike_triggers from Intan

NEO_THRESH_MIN = 1000;
NEO_THRESH_MAX = 3000;

if iscell(data)
   spikes = cell(size(data));
   for ii = 1:numel(data)
      if nargin < 2
         spikes{ii} = quickSpikeDetect(data{ii});
      else
         spikes{ii} = quickSpikeDetect(data{ii},meta);
      end
   end
   return;
end

spikes = zeros(size(data.spike_data));

if nargin < 2
   x_neo = mmNEO(data.spike_data);
%    tmp = (x_neo >= NEO_THRESH_MIN) & (x_neo <= NEO_THRESH_MAX);
%    % Get only leading edge
%    for ii = 1:size(spikes,1)
%       dtmp = [0 diff(tmp(ii,:))];
%       spikes(ii,:) = dtmp > 0;
%    end

   for ii = 1:size(spikes,1)
      [pk,loc] = findpeaks(x_neo,'MinPeakHeight',NEO_THRESH_MIN);
      loc(pk>=NEO_THRESH_MAX) = [];
      spikes(ii,loc) = 1;
   end

else
   th = [meta.spike_triggers.voltage_threshold];
   th(abs(th)<10) = -inf; % exclude channels with no activity

   for ii = 1:size(spikes,1)
      tmp = data.spike_data(ii,:) <= th(ii);
      dtmp = [0 diff(tmp)];
      spikes(ii,:) = dtmp > 0;
   end
end


end