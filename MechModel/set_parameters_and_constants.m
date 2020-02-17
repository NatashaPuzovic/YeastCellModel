% set parameters and constants
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

% physical constants
physconst = struct();
physconst.R = 0.08314; % ideal gas constant  [L*bar*mol^-1*K^-1]
physconst.Temp = 298.15; % temperature [K]

% hog nuclear import
alpha = 1.5; % shape parameter (k)
theta = 0.1;
beta = 1/theta; % rate parameter

