% simulation horizon
TSPAN = [0 2];
JSPAN = [0 1500];
rule = 1;
options = odeset('RelTol',1e-6,'MaxStep',.1);

% Initial Conditions
z1_0  = 2.5;
z2_0  = 0;
zI_0  = 0;
u_0   = 0;
ms_0  = 0;
tau_0 = 0;

% Not really need states...
r_0   = 0;
time_0= 0;

x0 = [z1_0,z2_0,zI_0,u_0,ms_0,tau_0,r_0,time_0];

% simulate
[t,j,x] = HyEQsolver( @f_PID,@g_PID,@C_PID,@D_PID,...
    x0,TSPAN,JSPAN,rule,options,'ode23t');

% Output
z1  = x(:,1);
z2  = x(:,2);
zI  = x(:,3);
u   = x(:,4);
ms  = x(:,5);
tau = x(:,6);
r   = x(:,7);