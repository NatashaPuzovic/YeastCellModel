% run simulation (this is the simulation where I assume pHog doesn't immeadiately go to
% 0 when the stress is removed, but needs time to drop to 0
numperiods = floor(tfinal/tperiod);
t = [];
result = [];
h = [];
Pe = [];
percounter = 0;

% simulate half of first period with normal medium
    [tsim, resultsim] = ode15s(@(t,result) normal_first_half_model_ode(t,result,k),[0,tperiod/2],x0,options);
    t = [t; (tsim + (tperiod/2)*percounter)];
    result = [result; resultsim];
    h = [h; zeros(length(tsim), 1)];
    Pe = [Pe; ones(length(tsim), 1)*P_normal];
    percounter = percounter + 1;
    
for nperiod = 1:numperiods-1
    % simulate osmotic stress
    x0 =  resultsim(length(resultsim), :);
    
    [tsim, resultsim] = ode15s(@(t,result) sorbitol_response_model_ode(t,result,k),[0,tperiod/2],x0,options);
    t = [t; (tsim + (tperiod/2)*percounter)];
    result = [result; resultsim];
    h = [h; gampdf(tsim, alpha, beta)];
    Pe = [Pe; ones(length(tsim), 1)*P_stress];
    percounter = percounter + 1;

    % simulate normal medium
    x0 =  resultsim(length(resultsim), :);
    [tsim, resultsim] = ode15s(@(t,result) normal_model_ode(t,result,k, tperiod),[0,tperiod/2],x0,options);
    t = [t; (tsim + (tperiod/2)*percounter)];
    result = [result; resultsim];
    h = [h; gampdf(tsim + tperiod/2, alpha, beta)];
    Pe = [Pe; ones(length(tsim), 1)*P_normal];
    percounter = percounter + 1;
end

    % simulate last period of osmotic stress
    x0 =  resultsim(length(resultsim), :);
    [tsim, resultsim] = ode15s(@(t,result) sorbitol_response_model_ode(t,result,k),[0,tperiod/2],x0,options);
    t = [t; (tsim + (tperiod/2)*percounter)];
    result = [result; resultsim];
    h = [h; gampdf(tsim, alpha, beta)];
    Pe = [Pe; ones(length(tsim), 1)*P_stress];
    percounter = percounter + 1;

% rename variables
rename_variables_from_simresult;

% calculate osm. pressure and growth rate
calc_additional_measures;

disp(['mean lambda = ' num2str(mean_lambda)])
disp(['mean doubling time = ' num2str(mean_doubling_time)])