
%close all 
%clear all
%clc

% initial conditions
global T1 T2 kp ki kd A B ag K cont

cont = 0;

k = 1;
m = 1;

A = [0 1;
    -k/m 0];
B = [0; 1/m];

% simulation horizon
TSPAN = [0 3];
JSPAN = [0 15000];
rule = 1;
options = odeset('RelTol',1e-6,'MaxStep',.1);


rand_max = 5;

% Initial Conditions
z1_0  = .000001;%rand_max*rand(1,1);
z2_0  = 0;%rand_max*rand(1,1);
zI_0  = 0;
u_0   = 0;
ms_0  = 0;
tau_0 = 0;
tauI_0= 0;
r_0   = 1;
z_1t  = 0;
z_2t  = 0;
time0 = 0;

x0 = [z1_0,z2_0,zI_0,u_0,ms_0,tau_0,tauI_0,r_0,z_1t,z_2t,time0];

% simulate
[t,j,x] = HyEQsolver( @f_PID,@g_PID,@C_PID,@D_PID,...
    x0,TSPAN,JSPAN,rule,options,'ode23t');

z1  = x(:,1);
z2  = x(:,2);
zI  = x(:,3);
u   = x(:,4);
ms  = x(:,5);
tau = x(:,6);
tauI= x(:,7);
r   = x(:,8);
z1t = x(:,9);
z2t = x(:,10);


