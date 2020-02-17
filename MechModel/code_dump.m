%% set initial values at steady state for Km 10^6
si0      =   128590;
a0       =  10.7060;
                % proteins
r0         = 25.1764; 
et0       =  7.3448e+03;
em0      = 7.3448e+03;
eg0         = 73.4477;
q0         = 2.3874e+05;
                    % free mRNAs
mr0       =  34.1296; 
mt0       =  9.9354;
mm0     = 9.9354;
mg0      = 0.0994;
mq0      = 322.9541;
                    % bound mRNAs
cr0       = 762.8302; 
ct0       = 70.1881;
cm0      =  70.1881;
cg0       = 0.7019;
cq0       = 2.2815e+03;
                    % glycerol
glyc0    = 1.7418e+07;

x0      = [si0, a0, ... % definition of the initial vector of variables
                r0, et0, em0, eg0, q0, ...
                mr0, mt0, mm0, mg0, mq0, ...
                cr0, ct0, cm0, cg0, cq0, ...
                glyc0]; 
            
         
%% looks like 0.2M stress from Muzzey
alpha = 1.9; % shape parameter (k)
theta = 0.5;
beta = 1/theta; % rate parameter
hog = 2*gampdf(t, alpha, beta);
figure
plot(t, hog)
%% looks like 0.4M stress from Muzzey
alpha = 1.9; % shape parameter (k)
theta = 0.25;
beta = 1/theta; % rate parameter
hog = 4*gampdf(t, alpha, beta);
figure
plot(t, hog)
%% looks like 0.6M stress from Muzzey
alpha = 5; % shape parameter (k)
theta = 0;
beta = 1/theta; % rate parameter
hog = 4*gampdf(t, alpha, beta);
figure
plot(t, hog)
