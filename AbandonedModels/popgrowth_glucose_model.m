%% model definition, gamma_period = f(gamma_c, T, t_del, k)

function gamma_period = popgrowth_glucose_model(gamma_c, T, t_del, k)
    if t_del >= T/2
        gamma_period = gamma_c/2;
    
    % dropdown complete
    elseif t_del + gamma_c/k <= T/2
        gamma_period = 1/T*(t_del*gamma_c + ...
            gamma_c^2/k + ...
            gamma_c*(T/2 - t_del - gamma_c/k));
        
    % dropdown incomplete
    elseif t_del + gamma_c/k > T/2
        mid = (-k)*T/2 + gamma_c + k*t_del;
        gamma_period = 1/T*(t_del*gamma_c + ...
            (gamma_c + mid)*(T/2 - t_del) + ...
            t_del*mid);

    end

end