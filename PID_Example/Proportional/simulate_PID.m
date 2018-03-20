% simulation horizon
TSPAN = [0 20];
JSPAN = [0 1500];
rule = 1;
options = odeset('RelTol',1e-6,'MaxStep',.001);

% Initial Conditions
z1_0  = 2.5;
z2_0  = -1.2;
u_0   = 1;
tau_0 = .1;

x0 = [z1_0,z2_0,u_0,tau_0];

% simulate
[t,j,x] = HyEQsolver( @f_PID,@g_PID,@C_PID,@D_PID,...
    x0,TSPAN,JSPAN,rule,options,'ode45');

% Output
z1  = x(:,1);
z2  = x(:,2);
u   = x(:,3);
tau = x(:,4);