cd D:\Github\Natasha\Modelling\MechModel\ 
clear all; clc

tfinal = 600; % duration of entire experiment [min]
tperiod  = 30; % duration of one period (onstep + offstep) [min]
numperiods = floor(tfinal/tperiod);

% configure integrator (check 'doc ode15s' for more info)
configure_integrator;
% set parameters
set_parameters_and_constants;
% set initial values at steady state
set_initial_condition;
            
%% simulate 
t = [];
result = [];
i = 0;

for n = 1:numperiods
    % simulate normal medium
    [tsim, resultsim] = ode15s(@(t,result) normal_model_ode(t,result,k),[0,tperiod/2],x0,options);
    t = [t; (tsim + (tperiod/2)*i)];
    result = [result; resultsim];
    i = i +1;
    
    % simulate osmotic stress
    x0 =  resultsim(length(resultsim), :);
    [tsim, resultsim] = ode15s(@(t,result) sorbitol_response_model_ode(t,result,k),[0,tperiod/2],x0,options);
    t = [t; (tsim + (tperiod/2)*i)];
    result = [result; resultsim];
    i = i + 1;
    x0 =  resultsim(length(resultsim), :);
end

% rename variables
rename_variables_from_simresult;

% calculate growth rate and plot
calc_additional_measures;

%% plot all on entire t
% color of areas denoting stress stimulus
areacol = [0, 0.4470, 0.7410];

figure
subplot(4,2,1)
plot(t,N, 'LineWidth', 1.5); ylabel('N', 'fontsize', 14); hold on
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = 0.3;
end; hold off

subplot(4,2,2)
plot(t, Rt, 'LineWidth', 1.5); ylabel('Rt (# transl rbsms)', 'fontsize', 14); hold on
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = 0.3;
end; hold off

subplot(4,2,3)
plot(t,lambda, 'LineWidth', 1.5); ylabel('\lambda', 'fontsize', 14); hold on
plot(t, mean_lambda*ones(size(t)), '--', 'Color', 'b') 
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = 0.3;
end; hold off

subplot(4,2,4)
plot(t,doubling_time, 'LineWidth', 1.5); ylabel('doubling time [min]', 'fontsize', 14); hold on
plot(t, mean_doubling_time*ones(size(t)), '--', 'Color', 'b') 
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = 0.3;
end; hold off

subplot(4,2,5)
plot(t,eg, 'LineWidth', 1.5, 'Color', 'r'); ylabel('eg (Gpd1)', 'fontsize', 14); hold on
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = 0.3;
end; hold off

subplot(4,2,6)
plot(t,glyc, 'LineWidth', 1.5, 'Color', 'r'); ylabel('glycerol', 'fontsize', 14); hold on
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = 0.3;
end; hold off

subplot(4,2,7)
plot(t,et, 'LineWidth', 1.5, 'Color', 'r'); ylabel('et', 'fontsize', 14); hold on
xlabel('time [min]', 'fontsize', 14)
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = 0.3;
end; hold off

subplot(4,2,8)
plot(t,r, 'LineWidth', 1.5, 'Color', 'r'); ylabel('r', 'fontsize', 14); hold on
xlabel('time [min]', 'fontsize', 14)
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = 0.3;
end; hold off


%%
figure;
hold on
plot(t, glyc, 'LineWidth', 1.5, 'Color', 'k');
xlabel('time [min]', 'fontsize', 14);
ylabel('glycerol', 'fontsize', 14); 
ylims = ylim;

for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = [0, 0.4470, 0.7410];
    ha.EdgeAlpha = 0;
    ha.FaceAlpha = 0.3;
end; hold off

%% plot all on smaller t interval
t_end = 900;

figure
subplot(4,2,1)
plot(t(1:t_end),N(1:t_end), 'LineWidth', 1.5); ylabel('N', 'fontsize', 14); 

subplot(4,2,2)
plot(t(1:t_end), Rt(1:t_end), 'LineWidth', 1.5); ylabel('Rt (# transl rbsms)', 'fontsize', 14);

subplot(4,2,3)
plot(t(1:t_end),lambda(1:t_end), 'LineWidth', 1.5); ylabel('\lambda', 'fontsize', 14);

subplot(4,2,4)
plot(t(1:t_end),doubling_time(1:t_end), 'LineWidth', 1.5); ylabel('doubling time [min]', 'fontsize', 14); 

subplot(4,2,5)
plot(t(1:t_end),eg(1:t_end), 'LineWidth', 1.5, 'Color', 'r'); ylabel('eg (Gpd1)', 'fontsize', 14); 

subplot(4,2,6)
plot(t(1:t_end),glyc(1:t_end), 'LineWidth', 1.5, 'Color', 'r'); ylabel('glycerol', 'fontsize', 14); 

subplot(4,2,7)
plot(t(1:t_end),et(1:t_end), 'LineWidth', 1.5, 'Color', 'r'); ylabel('et', 'fontsize', 14); 
xlabel('time [min]', 'fontsize', 14)

subplot(4,2,8)
plot(t(1:t_end),r(1:t_end), 'LineWidth', 1.5, 'Color', 'r'); ylabel('r', 'fontsize', 14); 
xlabel('time [min]', 'fontsize', 14)



