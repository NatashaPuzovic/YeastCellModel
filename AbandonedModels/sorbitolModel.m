%% sorbitol stimulations under constant glucose

P = 1000; % amount of precursors in a single time unit
alpha = 0.9; % resource allocation parameter

num_time_units = 500; 
gamma_responses = zeros(1, num_time_units);
osmolite_responses = zeros(1, num_time_units);

a_homeostasis = 10000; % amount osmolite needed to reach homeostasis

gamma_responses(1) = P * alpha;

osmolite_responses(1) = P * (1 - alpha);

for i=2:num_time_units
    if sum(osmolite_responses) > a_homeostasis
        alpha = 1;    
    end
    inst_gamma = P * alpha;
    gamma_responses(i) = inst_gamma;
    
    inst_osmolite = P * (1 - alpha);
    osmolite_responses(i) = osmolite_responses(i-1) + inst_osmolite;
   
end

plot(gamma_responses, 'r', 'LineWidth', 2), hold on
plot(osmolite_responses, 'b', 'LineWidth', 2) 
title('Single step osmostress');
xlabel('Time unit');
ylabel('Inst growth and osmolite ammount');
legend('inst gamma', 'osmolite amount');