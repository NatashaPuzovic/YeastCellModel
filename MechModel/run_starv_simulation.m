% run simulation (under normal medium pHog is zero, under osmostress pHog
% is gamma distributed
numperiods = floor(tfinal/tperiod);
t = [];
result = [];
percounter = 0;

for nperiod = 1:numperiods
    % simulate normal medium
    k.s                    = 1e5;
    [tsim, resultsim] = ode15s(@(t,result) normal_model_ode(t,result,k),[0,tperiod/2],x0,options);
    t = [t; (tsim + (tperiod/2)*percounter)];
    result = [result; resultsim];
    percounter = percounter + 1;
    
    % simulate no glucose
    x0 =  resultsim(length(resultsim), :);
    k.s                    = 0;
    [tsim, resultsim] = ode15s(@(t,result) normal_model_ode(t,result,k),[0,tperiod/2],x0,options);
    t = [t; (tsim + (tperiod/2)*percounter)];
    result = [result; resultsim];
    percounter = percounter + 1;
    x0 =  resultsim(length(resultsim), :);
end

% rename variables
rename_variables_from_simresult;

% calculate osm. pressure and growth rate
calc_starv_additional_measures;

disp(['mean lambda = ' num2str(mean_lambda)])
disp(['mean doubling time = ' num2str(mean_doubling_time)])