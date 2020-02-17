%% set simulation time
cd 'D:'\Kursevi\'Whole Cell Modeling (CRI)'\'modified model'\
clear all; clc

tfinal  = 1e3;                              % final time

%% configure integrator (check 'doc ode15s' for more info)
options = odeset('NonNegative', [1:14]);      % ensures variables stay positive 
                                            % (this is not always necessary 
                                            % but can be helpful, but make sure 
                                            % your system is actually a positive system!)

options = odeset(options, 'RelTol', 1e-10,...
                          'AbsTol', 1e-13);  % accuracy of integrator 
                                            % (here set to default values)

%% set parameters

k = struct();

k.dn                 = 0.0001; % death rate
k.s                    = 1e5; % external nutrient
k.dm                 = 0.1; % mRNA degradation rate
k.ns                  = 0.5; % nutrient efficiency
k.nr                   = 7459; % ribosome length
k.nt                  = 300; % length of non-ribosomal proteins
k.nm                  = 300; % length of non-ribosomal proteins
k.ng                  = 300; % length of non-ribosomal proteins
k.nq                  = 300; % length of non-ribosomal proteins
k.gammamax    = 1260; % max translation elongation rate
k.Kgamma         = 7; % translation elongation threshold
k.yps_t               = 726; % max nutrient import rate
k.Kt                   = 1000; % nutrient import threshold
k.yps_m              = 5800; % max enzymatic rate
k.yps_g              = 5800; % max enzymatic rate
k.Km                  = 1000000; % enzymatic threshold (steady 1000)
k.Kg                  = 1000; % enzymatic threshold
k.wr                   = 930; % max ribosome trascription rate
k.we                  = 4.14; % max enzyme transcription rate
k.wt                  = 4.14; % max enzyme transcription rate
k.wm                 = 4.14; % max enzyme transcription rate
k.wg                 = 0.0414; % max enzyme transcription rate
k.wq                  = 948.93; % max q-transcription rate
k.theta_r           = 426.87; % ribosome transcription threshold
k.theta_nr         = 4.38; % non-ribosomal transcription threshold
k.Kq                   = 152219; % q-autoinhibition threshold
k.hq                   = 4; % q-autoinhibition Hill coeffient
k.kb                   = 1; % mRNA-ribosome binding rate
k.ku                   = 1; % mRNA-ribosome unbinding rate
k.M                    = 1e8; % total cell mass
k.kcm                  = 0.00599; % chloramphenicol-binding rate

%% set initial values at steady state
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
                    % pop size
N0        = 1;

x0      = [si0, a0, ... % definition of the initial vector of variables
                r0, et0, em0, eg0, q0, ...
                mr0, mt0, mm0, mg0, mq0, ...
                cr0, ct0, cm0, cg0, cq0, ...
                glyc0, ...
                N0]; 

%% simulate
[t,result] = ode15s(@(t,result) modifiedmodel_ode(t,result,k),[0,tfinal],x0,options);

%% rename variables
                    % internal nutrient and ATP
si        = result(:, 1);       % a = first column of result
a         = result(:, 2);       % b = second column of result, ...
                    % proteins
r         = result(:, 3); 
et       = result(:, 4);
em      = result(:, 5);
eg       = result(:, 6);
q         = result(:, 7);
                    % free mRNAs
mr       = result(:, 8); 
mt       = result(:, 9);
mm     = result(:, 10);
mg      = result(:, 11);
mq      = result(:, 12);
                    % bound mRNAs
cr       = result(:, 13); 
ct       = result(:, 14);
cm      = result(:, 15);
cg       = result(:, 16);
cq       = result(:, 17);
                    % glycerol
glyc     = result(:, 18);
N         = result(:, 19);

%% calculate growth rate and plot
gamma = nan(length(a), 1);
Rt = nan(length(a), 1);
lambda = nan(length(a), 1);
doubling_time = nan(length(a), 1);


for i = 1:length(a)
    gamma(i) = k.gammamax*a(i)/(k.Kgamma + a(i));
    Rt(i) = cr(i) + ct(i)+ cm(i) + cq(i);
    lambda(i) = gamma(i)*Rt(i)/k.M;
    doubling_time(i) = log(2)/lambda(i);
end

disp(['lambda = ' num2str(lambda(i))])
disp(['doubling time = ' num2str(doubling_time(i))])

%% plot all on entire t
figure
subplot(4,2,1)
plot(t,N, 'LineWidth', 1.5); ylabel('N', 'fontsize', 14);

subplot(4,2,2)
plot(t, Rt, 'LineWidth', 1.5); ylabel('Rt (# transl rbsms)', 'fontsize', 14);

subplot(4,2,3)
plot(t,lambda, 'LineWidth', 1.5); ylabel('\lambda', 'fontsize', 14);

subplot(4,2,4)
plot(t,doubling_time, 'LineWidth', 1.5); ylabel('doubling time [min]', 'fontsize', 14); 

subplot(4,2,5)
plot(t,eg, 'LineWidth', 1.5, 'Color', 'r'); ylabel('eg (Gpd1)', 'fontsize', 14); 

subplot(4,2,6)
plot(t,glyc, 'LineWidth', 1.5, 'Color', 'r'); ylabel('glycerol', 'fontsize', 14); 

subplot(4,2,7)
plot(t,et, 'LineWidth', 1.5, 'Color', 'r'); ylabel('et', 'fontsize', 14); 
xlabel('time [min]', 'fontsize', 14)

subplot(4,2,8)
plot(t,q, 'LineWidth', 1.5, 'Color', 'r'); ylabel('r', 'fontsize', 14); 
xlabel('time [min]', 'fontsize', 14)

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