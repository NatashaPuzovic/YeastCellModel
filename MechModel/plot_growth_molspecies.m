% plot all on entire t

% stress area color and transparency
areacol = [0, 0.4470, 0.7410];
areatransparency = 0.3;

BigFig = figure('Position', get(0, 'Screensize'));
set(0,'DefaultFigureVisible','off')
%set(gcf,'visible','off');
   % set(0, 'CurrentFigure', BigFig);
   % clf reset;
subplot(4,3,1)
plot(t,N, 'LineWidth', 1.5); ylabel('N', 'fontsize', 14); hold on
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = areatransparency;
end; hold off

subplot(4,3,2)
plot(t,lambda, 'LineWidth', 1.5); ylabel('\lambda [min^-1]', 'fontsize', 14); hold on
plot(t, mean_lambda*ones(size(t)), '--', 'Color', 'b') 
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = areatransparency;
end; hold off

subplot(4,3,3)
plot(t,doubling_time, 'LineWidth', 1.5); ylabel('doubling time [min]', 'fontsize', 14); hold on
plot(t, mean_doubling_time*ones(size(t)), '--', 'Color', 'b') 
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = areatransparency;
end; hold off

subplot(4,3,4)
plot(t, Pi, 'LineWidth', 1.5); ylabel('\Pi_i, \Pi_e [MPa]', 'fontsize', 14); hold on
plot(t, Pe, 'LineWidth', 1.5, 'Color', 'g'); hold on
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = areatransparency;
end; hold off

subplot(4,3,5)
plot(t, deltaP, 'LineWidth', 1.5, 'Color', 'k'); ylabel('\Delta\Pi [MPa]', 'fontsize', 14); hold on
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = areatransparency;
end; hold off

subplot(4,3,6)
plot(t,h, 'LineWidth', 1.5, 'Color', 'r'); ylabel('nuclHog', 'fontsize', 14); hold on
xlabel('time [min]', 'fontsize', 14)
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = areatransparency;
end; hold off

subplot(4,3,7)
plot(t,eg, 'LineWidth', 1.5, 'Color', 'r'); ylabel('eg (Gpd1)', 'fontsize', 14); hold on
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = areatransparency;
end; hold off

subplot(4,3,8)
plot(t,g, 'LineWidth', 1.5, 'Color', 'r'); ylabel('glycerol', 'fontsize', 14); hold on
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = areatransparency;
end; hold off

subplot(4,3,9)
plot(t,et, 'LineWidth', 1.5, 'Color', 'r'); ylabel('et', 'fontsize', 14); hold on
xlabel('time [min]', 'fontsize', 14)
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = areatransparency;
end; hold off

subplot(4,3,10)
plot(t,em, 'LineWidth', 1.5, 'Color', 'r'); ylabel('em', 'fontsize', 14); hold on
xlabel('time [min]', 'fontsize', 14)
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = areatransparency;
end; hold off

subplot(4,3,11)
plot(t,q, 'LineWidth', 1.5, 'Color', 'r'); ylabel('q', 'fontsize', 14); hold on
xlabel('time [min]', 'fontsize', 14)
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = areatransparency;
end; hold off

subplot(4,3,12)
plot(t,r, 'LineWidth', 1.5, 'Color', 'r'); ylabel('r', 'fontsize', 14); hold on
xlabel('time [min]', 'fontsize', 14)
ylims = ylim;
for i = 1:2:numperiods*2
    ha = area([tperiod*i/2 tperiod*(i+1)/2], [ylims(2) ylims(2)], ylims(1));
    ha.FaceColor = areacol; ha.EdgeAlpha = 0;
    ha.FaceAlpha = areatransparency;
end; hold off

suptitle(['Hyperosmotic shock, period = ', num2str(tperiod), 'min'])

fig_name = sprintf('hyperosmotic_shock_%s_period.png', num2str(tperiod));
print(BigFig, fig_name, '-dpng');