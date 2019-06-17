function batch_export_PETH(rat,channel)

% For R19-94
switch rat
   case 'R19-94'
      % openPlot(rat,site,recName,channel,ICMS TIME,SOLENOID TIME,type);
      openPlot(rat,'Site3AB','Solenoid+ICMS-0',channel,0,0,'PETH');
      openPlot(rat,'Site3AB','Solenoid+ICMS-1',channel,0,0,'PETH');
      openPlot(rat,'Site3AB','Solenoid+ICMS-1',channel,0.050,0,'PETH');
      openPlot(rat,'Site3AB','Solenoid+ICMS-2',channel,0,0.050,'PETH');
      openPlot(rat,'Site3AB','Solenoid+ICMS-3',channel,0,0,'PETH');
      openPlot(rat,'Site3AB','Solenoid+ICMS-4',channel,0,0,'PETH');
      openPlot(rat,'Site3AB','Solenoid+ICMS-5',channel,0.050,0,'PETH');
      openPlot(rat,'Site3AB','Solenoid+ICMS-6',channel,0,0.050,'PETH');
      openPlot(rat,'Site3AB','Solenoid+ICMS-7',channel,0,0,'PETH');
      openPlot(rat,'Site3AB','Solenoid+ICMS-8',channel,0.025,0,'PETH');
      openPlot(rat,'Site3AB','Solenoid+ICMS-9',channel,0,0.025,'PETH');
      openPlot(rat,'Site3AB','Solenoid+ICMS-10',channel,0.010,0,'PETH');
      openPlot(rat,'Site3AB','Solenoid+ICMS-11',channel,0.010,0,'PETH');
      openPlot(rat,'Site3AB','Solenoid+ICMS-12',channel,0.010,0,'PETH');
      openPlot(rat,'Site3AB','Solenoid-0',channel,nan,0,'PETH');
      openPlot(rat,'Site3AB','ICMS-0',channel,nan,0,'PETH');
      openPlot(rat,'Site3AB','Catch-0',channel,nan,0,'PETH');
   case 'R19-101'
      % openPlot(rat,site,recName,channel,ICMS_TIME,SOLENOID_TIME,type);
      openPlot(rat,'Site1AB','Catch-0',channel,nan,0,'PETH');
      openPlot(rat,'Site1AB','RSolenoid-0',channel,nan,0,'PETH');
      openPlot(rat,'Site1AB','RSolenoid+ICMS-0',channel,0.010,0,'PETH');
      openPlot(rat,'Site1AB','RSolenoid+ICMS-1',channel,0.010,0,'PETH');
      openPlot(rat,'Site1AB','RSolenoid+ICMS-2',channel,0.001,0.010,'PETH');
      openPlot(rat,'Site1AB','RSolenoid+ICMS-3',channel,0.001,0.025,'PETH');
      openPlot(rat,'Site1AB','RSolenoid+ICMS-4',channel,0.025,0,'PETH');
      openPlot(rat,'Site1AB','RSolenoid-1',channel,nan,0,'PETH');
      openPlot(rat,'Site1AB','RSolenoid+ICMS-5',channel,0.025,0,'PETH');
      openPlot(rat,'Site1AB','RSolenoid+ICMS-6',channel,0.025,0,'PETH');
      openPlot(rat,'Site1AB','LSolenoid-0',channel,nan,0,'PETH');
      openPlot(rat,'Site1AB','LSolenoid+ICMS-0',channel,0.025,0,'PETH');
      openPlot(rat,'Site1AB','LSolenoid+ICMS-1',channel,0.025,0,'PETH');
      openPlot(rat,'Site1AB','LSolenoid+ICMS-2',channel,0.025,0,'PETH');
      openPlot(rat,'Site1AB','LSolenoid+ICMS-3',channel,0.025,0,'PETH');
%       openPlot(rat,'Site1AB','LSolenoid+ICMS-4',channel,0.025,0,'PETH');
      openPlot(rat,'Site1AB','LSolenoid+ICMS-5',channel,0.025,0,'PETH');
      openPlot(rat,'Site1AB','ICMS-0',channel,0.025,nan,'PETH');
      openPlot(rat,'Site1AB','ICMS-1',channel,0.025,nan,'PETH');
      openPlot(rat,'Site1AB','ICMS-2',channel,0.025,nan,'PETH');
      openPlot(rat,'Site1AB','ICMS-3',channel,0.025,nan,'PETH');
%       openPlot(rat,'Site1AB','ICMS-4',channel,0.025,nan,'PETH');
      openPlot(rat,'Site1AB','ICMS-5',channel,0.025,nan,'PETH');
      openPlot(rat,'Site1AB','LSolenoid+ICMS-6',channel,0.010,0,'PETH');
      openPlot(rat,'Site1AB','LSolenoid+ICMS-7',channel,0.035,0,'PETH');
      openPlot(rat,'Site1AB','LSolenoid-1',channel,nan,0,'PETH');
      openPlot(rat,'Site4AB','LSolenoid-0',channel,nan,0,'PETH');
      openPlot(rat,'Site4AB','L-ICMS-0',channel,0.010,nan,'PETH');
      openPlot(rat,'Site4AB','L-ICMS-1',channel,0.010,nan,'PETH');
      openPlot(rat,'Site4AB','LSolenoid+ICMS-0',channel,0.010,0,'PETH');
      openPlot(rat,'Site4AB','LSolenoid+ICMS-2',channel,0,0.010,'PETH');
      openPlot(rat,'Site4AB','LSolenoid+ICMS-3',channel,0,0.010,'PETH');
   case 'R19-104'
      openPlot(rat,'Site1AB','ICMS-0',channel,0,nan,'PETH');      
      openPlot(rat,'Site1AB','ICMS-1',channel,0,nan,'PETH');    
      openPlot(rat,'Site1AB','ICMS-2',channel,0,nan,'PETH');  
      openPlot(rat,'Site1AB','ICMS-3',channel,0,nan,'PETH');    
      openPlot(rat,'Site1AB','ICMS-4',channel,0,nan,'PETH');    
      openPlot(rat,'Site1AB','ICMS-5',channel,0,nan,'PETH'); 
      openPlot(rat,'Site1AB','RSolenoid-1',channel,nan,0,'PETH');
      openPlot(rat,'Site1AB','RSolenoid+ICMS-0',channel,0,0.010,'PETH');
      openPlot(rat,'Site1AB','RSolenoid-2',channel,nan,0.010,'PETH'); 
      openPlot(rat,'Site1AB','RSolenoid+ICMS-1',channel,0,0.010,'PETH');  
      openPlot(rat,'Site1AB','RSolenoid+ICMS-2',channel,0,0.010,'PETH');  
      openPlot(rat,'Site1AB','RSolenoid+ICMS-3',channel,0,0.015,'PETH');  
      openPlot(rat,'Site1AB','RSolenoid+ICMS-4',channel,0,0.015,'PETH');  
      openPlot(rat,'Site1AB','RSolenoid+ICMS-5',channel,0,0.020,'PETH');  
      openPlot(rat,'Site1AB','RSolenoid+ICMS-6',channel,0,0.020,'PETH');  
      openPlot(rat,'Site1AB','RSolenoid+ICMS-7',channel,0.040,0,'PETH');  
      openPlot(rat,'Site1AB','RSolenoid+ICMS-8',channel,0.040,0,'PETH'); 
      openPlot(rat,'Site2AB','LSolenoid-0',channel,nan,0,'PETH');
      openPlot(rat,'Site2AB','LSolenoid-1',channel,nan,1,'PETH');
      openPlot(rat,'Site2AB','LSolenoid+ICMS-0',channel,0.020,0,'PETH');
      openPlot(rat,'Site2AB','LSolenoid+ICMS-1',channel,0.010,0,'PETH');
      openPlot(rat,'Site2AB','LSolenoid+ICMS-2',channel,0,0,'PETH');
      openPlot(rat,'Site2AB','LSolenoid+ICMS-3',channel,0,0.010,'PETH');
      openPlot(rat,'Site2AB','LSolenoid+ICMS-4',channel,0,0.020,'PETH');
      openPlot(rat,'Site2AB','ICMS-0',channel,0,nan,'PETH'); 
      openPlot(rat,'Site2AB','ICMS-1',channel,0,nan,'PETH'); 
      openPlot(rat,'Site2AB','ICMS-2',channel,0,nan,'PETH');      
   otherwise
      error('No recordings extracted for %s.',rat);
end

end
