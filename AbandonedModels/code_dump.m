%% plot instantaneous growth 
% experimental duration
t = 1:exp_duration;

% glucose levels
step = [zeros(1, T/2) 1.2*gamma_const*ones(1, T/2)]; 
steps = repmat(step, 1, num_periods);


% response
gamma_period = 1:T;

y1 = [gamma_const  t_del];

%% case - rocket to 0
figure
response_value = [gamma_const * ones(1, t_del), gamma_const:-gamma_const/5:0];
response_value = [response_value, zeros(1, T/2-numel(response_value))];
response_value = [response_value fliplr(response_value)];
response_values = repmat(response_value, 1, num_periods); 
plot(t, steps, 'LineWidth', 1.5); hold on
plot(response_values, 'LineWidth', 1.5)
xlabel(' Time [min]'), ylabel('Growth rate [1/min]')

%% case - reaches T/2 before y=0
figure
min_val= gamma_const/10;
slope = gamma_const:-gamma_const/10:min_val;
response_value = [gamma_const * ones(1, t_del), slope(1:T/2-t_del)];
response_value = [response_value, val_min*ones(1, t_del)];
response_value = [response_value slope(T/2-t_del:-1:1)];
response_values = repmat(response_value, 1, num_periods); 
plot(t, steps, 'LineWidth', 1.5); hold on
plot(response_values, 'LineWidth', 1.5)
xlabel(' Time [min]'), ylabel('Growth rate [1/min]')

%%
function gamma_period = popgrowth_glucose_model(gamma_c, T, t_del, k)
    if t_del >= T/2
        gamma_period = gamma_c/2;
    
    % dropdown complete
    elseif t_del + gamma_c/k <= T/2
        gamma_period = 1/T*(t_del*gamma_c + ...
            k*(gamma_c^2 - (k*(T/2 - t_del) + gamma_c)^2) + ...
            t_del*(k*(T/2 - t_del) + gamma_c));
        
    % dropdown incomplete
    elseif t_del + gamma_c/k > T/2
        gamma_period = 1/T*(t_del*gamma_c + gamma_c^2/2 + gamma_c*(T/2 - t_del - gamma_c/k));

    end

end