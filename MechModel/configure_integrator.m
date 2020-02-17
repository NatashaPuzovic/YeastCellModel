% configure integrator (check 'doc ode15s' for more info)
options = odeset('NonNegative', [1:14]);      % ensures variables stay positive 
                                            % (this is not always necessary 
                                            % but can be helpful, but make sure 
                                            % your system is actually a positive system!)

options = odeset(options, 'RelTol', 1e-10, ...
                          'AbsTol', 1e-13);  % accuracy of integrator 
                                            % (here set to default values)
