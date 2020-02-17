% set initial values at steady state
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
g0    = 1.7418e+07;
                    % pop size
N0        = 1;

x0      = [si0, a0, ... % definition of the initial vector of variables
                r0, et0, em0, eg0, q0, ...
                mr0, mt0, mm0, mg0, mq0, ...
                cr0, ct0, cm0, cg0, cq0, ...
                g0, ...
                N0]; 
            