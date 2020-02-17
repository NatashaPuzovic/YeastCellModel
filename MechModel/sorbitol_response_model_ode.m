function dxdt = sorbitol_response_model_ode(t, x, k) 

% toymodel_ode(time, variables_vector, parameter_vector)
% Function that implements the right hand side of the ODE for toymodel. 

%% rename variables
                    % internal nutrient and ATP
si        = x(1);
a         = x(2);
                    % proteins
r         = x(3); 
et       = x(4);
em      = x(5);
eg       = x(6);
q         = x(7);
                    % free mRNAs
mr       = x(8); 
mt       = x(9);
mm     = x(10);
mg      = x(11);
mq      = x(12);
                    % bound mRNAs
cr       = x(13); 
ct       = x(14);
cm      = x(15);
cg       = x(16);
cq       = x(17);
                    % glycerol and pop size
g     = x(18);
N         = x(19);

%% initialize the rates of change for each variable with 0
                    % internal nutrient and ATP
dsidt     = 0;
dadt     = 0;
                    % proteins
drdt      = 0;
detdt    = 0;
demdt   = 0;
degdt   = 0;
dqdt      = 0;
                    % free mRNAs
dmrdt    = 0;
dmtdt    = 0;
dmmdt   = 0;
dmgdt   = 0;
dmqdt    = 0;
                    % bound mRNAs
dcrdt      = 0;
dctdt     = 0;
dcmdt    = 0;
dcgdt     =0;
dcqdt     = 0;
                    % glycerol
dgdt   = 0;
                    % population size
dNdt       = 0; 

%% hog nuclear import
alpha = 1.5; % shape parameter (k)
theta = 0.1;
beta = 1/theta; % rate parameter

hog = gampdf(t, alpha, beta);

%% for each reaction - add up contributions to rates of changes
nu_imp = et*k.yps_t*k.s/(k.Kt + k.s); % nutrient import rate
nu_cat = em*k.yps_m*si/(k.Km + si); % metabolic rate (internal nutrient -> a) 

gamma = k.gammamax*a/(k.Kgamma + a); % translational elongation rate

Rt = cr + ct + cm + cg + cq; % number of all translating ribosomes (bound ribosomes)
lambda = gamma*Rt/k.M; % growth rate/dilution rate

omega_r = k.wr*a/(k.theta_r + a); % transcription rates for each gene category
omega_t = k.wt*a/(k.theta_nr + a); 
omega_m = k.wm*a/(k.theta_nr + a); 
% omega_g = k.wg*a/(k.theta_nr + a); 
omega_g = k.wg*a*(hog*100 + 1)/(k.theta_nr + a);
I = 1/(1 + (q/k.Kq)^k.hq);
omega_q = k.wq*a/(k.theta_nr + a) * I; 

nu_r = cr*gamma/k.nr; % translation rates for each gene category
nu_t = ct*gamma/k.nt;
nu_m = cm*gamma/k.nm;
nu_g = cg*gamma/k.ng;
nu_q = cq*gamma/k.nq;

rho_glyc = eg*k.yps_g*si/(k.Kg + si); % enzyme reaction rate

                    % internal nutrient and ATP
dsidt     = nu_imp - nu_cat - lambda*si - rho_glyc;
dadt     = k.ns*nu_cat - ...
                (k.nr*nu_r + k.nt*nu_t + k.nm*nu_m + k.ng*nu_g + k.nq*nu_q) - lambda*a;
                    % proteins
drdt      = nu_r - lambda*r + ...
                (nu_r - k.kb*r*mr + k.ku*cr + ...
                nu_t - k.kb*r*mt + k.ku*ct + ...
                nu_m - k.kb*r*mm + k.ku*cm + ...
                nu_g - k.kb*r*mg + k.ku*cg + ...
                nu_q - k.kb*r*mq + k.ku*cq);
detdt    = nu_t - lambda*et;
demdt   = nu_m - lambda*em;
degdt   = nu_g - lambda*eg;
dqdt      = nu_q - lambda*q;
                    % free mRNAs
dmrdt    = omega_r - (lambda + k.dm)*mr + nu_r - k.kb*r*mr + k.ku*cr;
dmtdt    = omega_t - (lambda + k.dm)*mt + nu_t - k.kb*r*mt + k.ku*ct;
dmmdt   = omega_m - (lambda + k.dm)*mm + nu_m - k.kb*r*mm + k.ku*cm;
dmgdt   = omega_g - (lambda + k.dm)*mg + nu_g - k.kb*r*mg + k.ku*cg;
dmqdt    = omega_q - (lambda + k.dm)*mq + nu_q - k.kb*r*mq + k.ku*cq;
                    % bound mRNAs
dcrdt      = -lambda*cr + k.kb*r*mr - k.ku*cr - nu_r;
dctdt     =  -lambda*ct + k.kb*r*mt - k.ku*ct - nu_t;
dcmdt    =  -lambda*cm + k.kb*r*mm - k.ku*cm - nu_m;
dcgdt    =  -lambda*cg + k.kb*r*mg - k.ku*cg - nu_g;
dcqdt     =  -lambda*cq + k.kb*r*mq - k.ku*cq - nu_q;
                    % glycerol
dgdt   = rho_glyc - lambda*g;
                    % population size
dNdt       = lambda*N - k.dn*N;
%% output vector of rates of change of all variables
dxdt    = [dsidt; dadt; ...
                drdt; detdt; demdt; degdt; dqdt; ...
                dmrdt; dmtdt; dmmdt; dmgdt; dmqdt; ...
                dcrdt; dctdt; dcmdt; dcgdt; dcqdt; ...
                dgdt; ...
                dNdt];

end