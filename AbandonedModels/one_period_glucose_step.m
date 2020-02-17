function g = one_period_glucose_step(t_period, T, gamma_c)
    % no glucose
    g1 = (0).*(t_period <= T/2);
    % glucose
    g2 = (1.2*gamma_c).*(t_period > T/2);

    g = g1 + g2;
end