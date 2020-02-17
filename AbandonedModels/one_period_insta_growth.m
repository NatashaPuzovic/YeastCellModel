% plots instantaneous growth response vs glucose stimulus

function y = one_period_insta_growth(t, gamma_c, T, t_del, k)
    % dropdown complete
    if t_del + gamma_c/k <= T/2
        
        y1 = (gamma_c).*(t <= t_del); % max growth while there is still glycogen
        y2 = ((-k)*t + gamma_c + k*t_del).*(t_del < t & t <= t_del + gamma_c/k); % drop
        % zero growth while there's no glucose and before new glucose is
        % detected
        y3 = (0).*(t_del + gamma_c/k < t & t <= T/2 + t_del);
        y4 = (k*t - k*(T/2 + t_del)).*(T/2 + t_del < t & t <= T/2 + t_del + gamma_c/k); % rise
        y5 = (gamma_c).*(T/2 + t_del + gamma_c/k < t & t <= T); % max growth when there is glucose
        y = y1 + y2 + y3 + y4 + y5; 
        
    % dropdown not complete
    elseif t_del + gamma_c/k > T/2
        y1 = (gamma_c).*(t <= t_del); % max growth while there is still glycogen
        y2 = ((-k)*t + gamma_c + k*t_del).*(t_del < t & t <= T/2); % drop
        midline = (-k)*T/2 + gamma_c + k*t_del;
        y3 = (midline).*(T/2 < t & t <= T/2 + t_del); % midline
        y4 = (k*t - k*(T/2 + t_del) + midline).*(T/2 + t_del < t & t <= T); % rise
        y = y1 + y2 + y3 + y4; 
        %
    end
end
