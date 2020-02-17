% run simulation (under normal medium pHog is zero, under osmostress pHog
% is gamma distributed
numperiods = floor(tfinal/tperiod);
t = [];
result = [];
h = [];
Pe = [];
percounter = 0;

for nperiod = 1:numperiods
    % simulate normal medium
    [tsim, resultsim] = ode15s(@(t,result) normal_model_ode(t,result,k),[0,tperiod/2],x0,options);
    t = [t; (tsim + (tperiod/2)*percounter)];
    result = [result; resultsim];
    h = [h; zeros(length(tsim), 1)];
    Pe = [Pe; ones(length(tsim), 1)*P_normal];
    percounter = percounter + 1;
    
    % simulate osmotic stress
    x0 =  resultsim(length(resultsim), :);
    [tsim, resultsim] = ode15s(@(t,result) sorbitol_response_model_ode(t,result,k),[0,tperiod/2],x0,options);
    t = [t; (tsim + (tperiod/2)*percounter)];
    result = [result; resultsim];
    h = [h; gampdf(tsim, alpha, beta)];
    Pe = [Pe; ones(length(tsim), 1)*P_stress];
    percounter = percounter + 1;
    x0 =  resultsim(length(resultsim), :);
end

% rename variables
rename_variables_from_simresult;

% calculate osm. pressure and growth rate
calc_additional_measures;

disp(['mean lambda = ' num2str(mean_lambda)])
disp(['mean doubling time = ' num2str(mean_doubling_time)])