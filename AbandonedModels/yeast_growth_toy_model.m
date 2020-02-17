% this is a toy model of yeast growth in periodic glucose starvation

cd 'D:'\Github\Natasha\Modelling''

%% parameters
gamma_c = 0.006; % constitutive growth rate in glucose medium [min^-1]
k = 0.0005; % slope of linear approximation of log phase during start of growth
t_del = 3; % time of delay [min]

periods_from_exp = [12 24 48  96 192]; % duration of oscillations
% periods = [12 24 36 48 72 96 120 144 192 288 384 480 576]; % duration of oscillations

periods = 1:1:720;
exp_duration = 720; % experiment duration [min]

% load experimental data
load exp_data.txt
ave_experimental_data = [ mean(exp_data((exp_data(:, 1) == 12), 2)), ...
                                            mean(exp_data((exp_data(:, 1) == 24 ), 2)), ...
                                            mean(exp_data((exp_data(:, 1) == 48), 2)), ...
                                            mean(exp_data((exp_data(:, 1) == 96 ), 2)), ...
                                            mean(exp_data((exp_data(:, 1) == 192 ), 2)) ];
%% simulate average population growth for each period
% parameters for the model go model(gamma_c, T, t_del, k)
simulated_growth_rates = zeros(1, numel(periods));

for i = 1:numel(periods)
    T = periods(i);
    simulated_growth_rates(i) = popgrowth_glucose_model(gamma_c, T, t_del, k);
end

% plot simulated growth response
figure
plot(periods, simulated_growth_rates, 'LineWidth', 1.5); hold on
scatter(periods_from_exp, simulated_growth_rates(periods_from_exp), 20, 'b', 'filled')
line([0:periods(end)],  gamma_c/2*ones(1, periods(end) + 1), 'LineStyle', '--')
title('Simulated average growth rate per period');
xlabel('Period [min]', 'FontSize', 12, 'FontWeight', 'bold')
ylabel('Population growth rate', 'FontSize', 12, 'FontWeight', 'bold')
ylim([0 0.007])
yticks([0 0.001 0.002 0.003 0.004 0.005 0.006 0.007 ])
xticks(sort([periods_from_exp 0 300 400 500 600 700 720]))
yticklabels({'0', '0.001', '0.002', '0.003', '0.004', '0.005', 'gamma_c = 0.006', '0.007'})
legend('Sim growth rate', 'Sim growth rate (exper eval periods)')

%%
% plot simulated growth response with experimental datapoints
figure
plot(periods, simulated_growth_rates, 'LineWidth', 2), hold on
scatter(periods_from_exp, simulated_growth_rates(periods_from_exp), 20, 'b', 'filled'), hold on
scatter(exp_data(:, 1), exp_data(:, 2), 20, [1 0.6 0.3] , 'filled')
line([0:periods(end)],  gamma_c/2*ones(1, periods(end) + 1), 'LineStyle', '--')
title('Simulated average growth rate per period');
xlabel('Period [min]', 'FontSize', 12, 'FontWeight', 'bold')
ylabel('Population growth rate', 'FontSize', 12, 'FontWeight', 'bold')
ylim([0 0.007])
yticks([0 0.001 0.002 0.003 0.004 0.005 0.006 0.007 ])
xticks(sort([periods_from_exp 0 300 400 500 600 700 720]))
yticklabels({'0', '0.001', '0.002', '0.003', '0.004', '0.005', 'gamma_c = 0.006', '0.007'})
legend('Sim growth rate', 'Sim growth rate (exper eval periods)', ...
            'Experimental growth rate')


%% KS test between simulated and experimental data
                                            
[same_distribution, pval] = kstest2(ave_experimental_data, simulated_growth_rates, 'Alpha', 0.05);

same_distribution
pval

%% plot instantaneous growth 
% period duration
T = 12;
t_period = 0:.01:(T - .01);

% one period glucose step and growth
one_period_glucose = one_period_glucose_step(t_period, T, gamma_c); 
one_period_growth = one_period_insta_growth(t_period, gamma_c, T, t_del, k);

% plot glucose and growth during one period
plot(t_period, one_period_glucose, 'b'), hold on
plot(t_period, one_period_growth, 'r', 'LineWidth', 1)
xlim([0 T]);
title('Growth rate during glucose stepdown');
xlabel('Time [min]', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Glucose level/Population growth rate', 'FontSize', 12, 'FontWeight', 'bold');
legend('Glucose conc (0% or 2%)', 'Population growth rate')

% experimental duration
num_periods = floor(exp_duration/T);

% period duration is a divisor of experimental duration
if  mod(exp_duration, T) == 0
    all_periods_glucose = repmat(one_period_glucose, 1, num_periods);
    all_periods_growth = repmat(one_period_growth, 1, num_periods);
% period duration is not a divisor of experimental duration    
else
    all_periods_glucose = repmat(one_period_glucose, 1, num_periods);
    all_periods_growth = repmat(one_period_growth, 1, num_periods);
    
    period_left_over = (exp_duration - num_periods*T)/T;
    glucose_left_over = one_period_glucose(1:(T*period_left_over*100));
    growth_left_over = one_period_growth(1:(T*period_left_over*100));
    
    all_periods_glucose = [all_periods_glucose glucose_left_over];
    all_periods_growth = [all_periods_growth growth_left_over];
    
end


% plot glucose and growth during entire experiment
t_all = 0:.01:(exp_duration - .01);
plot(t_all, all_periods_glucose, 'b'), hold on
plot(t_all, all_periods_growth, 'r', 'LineWidth', 1)
xlim([0 exp_duration])
title('Growth rate during periodic glucose stepdown');
xlabel('Time [min]', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Glucose level/Population growth rate', 'FontSize', 12, 'FontWeight', 'bold');
legend('Glucose conc (0% or 2%)', 'Population growth rate')