cd 'D:'\Github\Natasha\Modelling\MechModel\
clear all; clc
    
tfinal = 600; % duration of entire experiment [min]
tperiods = [ 30 60 100 300 600]; % duration of one period (onstep + offstep) [min]
% tperiods = [12 24 30 40 60 100 200 300 600]; % duration of one period (onstep + offstep) [min]
% tperiods = [2 4 6 12 15 20 24 30 40 60 75 100 120 150 200 300 600]; % duration of one period (onstep + offstep) [min]

M_normal = 10000000; % osmolarity of normal medium
M_stress = 30000000; % osmolarity of high salt medium

% configure integrator
configure_integrator;
% set parameters and constants
set_parameters_and_constants;
% set initial values at steady state
set_starv_initial_condition;

lambda_steady = 0.0243;
dt_steady = 28.5615;

%% simulate under one period duration
tperiod = 600;

% run simulation
run_starv_simulation;
% plot all on entire t
plot_starv_growth_molspecies;

%% simulate under different period durations
numsims = length(tperiods);
results = cell(1, numsims);

for nsim = 1:numsims 
tperiod = tperiods(nsim);

% set initial values at steady state
set_initial_condition;
% run simulation
run_simulation;
% plot all on entire t
plot_growth_molspecies;
% save sim results and time to cell
results{nsim} = [result, t, h, Pi, Pe, deltaP, gamma, Rt, lambda, doubling_time];

end

%% get mean growth rates in all period durations
mean_lambdas = zeros(1, numsims);
mean_doubling_times = zeros(1, numsims);
for nsim = 1:numsims
   mean_lambdas(nsim) = mean(results{nsim}(:, 27));
   mean_doubling_times(nsim) = mean(results{nsim}(:, 28));
end

peak_sensitivity = find(mean_doubling_times == max(mean_doubling_times));

%% plot mean growth rates in all period durations
set(0,'DefaultFigureVisible','on')
lambdaFig = figure('Position', get(0, 'Screensize'));
plot(tperiods, mean_lambdas, '-o', 'LineWidth', 1.8, 'MarkerSize', 4, 'MarkerFaceColor', [0.1, 0.7, 0.9]); hold on
line([0 tperiods(numsims)], [lambda_steady lambda_steady], 'LineStyle', '--'); hold on
line([0 tperiods(numsims)], [lambda_steady/2 lambda_steady/2], 'LineStyle', '--'); hold on
set(gca,'XTick', [2 12 20 30 60 100 150 200 300 600]);
ylim([0 0.03]);
set(gca,'YTick', [0 0.005 0.01 lambda_steady/2 0.015 0.02 lambda_steady 0.03]);
set(gca,'YTickLabel', str2mat('0','0.005','0.01', '\lambda_{no stress}/2', '0.015', '0.02', '\lambda_{no stress}', '0.03'),  'FontWeight', 'bold')
ylabel('\lambda [min^-1]', 'fontsize', 16, 'FontWeight', 'bold');
xlabel('Oscillation period [min]', 'fontsize', 16, 'FontWeight', 'bold'); hold off

fig_name = 'growthrate-period.png';
print(lambdaFig, fig_name, '-dpng');

%% plot mean doubling times in all period durations
set(0,'DefaultFigureVisible','on')
lambdaFig = figure('Position', get(0, 'Screensize'));
plot(tperiods, mean_doubling_times, '-o', 'LineWidth', 1.8, 'MarkerSize', 4, 'MarkerFaceColor', [0.1, 0.7, 0.9]); hold on
line([0 tperiods(numsims)], [dt_steady dt_steady], 'LineStyle', '--'); hold on
line([0 tperiods(numsims)], [dt_steady*2 dt_steady*2], 'LineStyle', '--'); hold on
set(gca,'XTick', [2 12 20 30 60 100 150 200 300 600]);
ylim([26 60]);
set(gca,'YTick', [dt_steady 30 35 40 50 dt_steady*2]);
set(gca,'YTickLabel', str2mat('d_{no stress}','30', '35','40', '50', '2d_{no stress}'),  'FontWeight', 'bold')
ylabel('Doubling time [min]', 'fontsize', 16, 'FontWeight', 'bold');
xlabel('Oscillation period [min]', 'fontsize', 16,  'FontWeight', 'bold'); hold off

fig_name = 'doubletime-period.png';
print(lambdaFig, fig_name, '-dpng');

%% plot single variables in all periods

% plot growth rate
figure
for nsim = 1:numsims
   plot(results{nsim}(:, 20), results{nsim}(:, 27), 'LineWidth', 1.5); hold on
end
ylabel('\lambda', 'fontsize', 14);
xlabel('time [min]', 'fontsize', 14); hold off

%% plot all on a part of t
plot_piece_growth_molspecies;
