close all 
%clear all
%clc

% initial conditions
global T1 T2 kp ki kd A B ag K

T1 = .01;
T2 = 2*T1;

k = 1;
m = 1;

A = [0 1;
    -k/m 0];
B = [0; 1/m];

% simulation horizon
TSPAN = [0 5];
JSPAN = [0 15000];
rule = 1;
options = odeset('RelTol',1e-6,'MaxStep',.1);


rand_max = 5;
%kp =  100;
%ki =  200;
%kd =  20;
%kp =  10;
%ki =  200;
%kd =  2;

% Initial Conditions
z1_0  = .8;%rand_max*rand(1,1);
z2_0  = 0;%rand_max*rand(1,1);
zI_0  = 0;
u_0   = 0;
tau_0 = 0;
ms_0  = 0;
tauI_0= 0;
r_0   = 0;
t__0  = 0;

x0 = [z1_0,z2_0,zI_0,u_0,tau_0,ms_0,tauI_0,r_0,t__0];

% simulate
[t,j,x] = HyEQsolver( @f_PID,@g_PID,@C_PID,@D_PID,...
    x0,TSPAN,JSPAN,rule,options,'ode23t');

z1  = x(:,1);
z2  = x(:,2);
zI  = x(:,3);
u   = x(:,4);
tau = x(:,5);
ms  = x(:,6);
tauI= x(:,7);
r   = x(:,8);
t_  = x(:,9);

threshold = 5;
if(abs(z1(end) - r(end)) > threshold)
    display('Assumed unstable... moving on...');
    P = nan;
    P3 = nan;
    return 
end

% plot solution
figure(1)
subplot(2,1,1), plot(t,z1);
grid on
hold on
plot(t,r,'r');
ylabel('$y(t)$','Interpreter','latex','FontSize', 18);
legend('y(t)','r(t)');

subplot(2,1,2); plot(t,u);
grid on
ylabel('$u(t)$','Interpreter','latex','FontSize', 18);
xlabel('time (s)','Interpreter','latex','FontSize', 18);
legend('u(t)');




Af = [A [0;0] B; zeros(2,4)];
Ag = ag

H = exp(Af*T1)*Ag;

%%%%%%%%%%% SOLVE FOR P %%%%%%%%%%%

n = 4;

cvx_begin sdp
    variable P(n,n) symmetric
    H'*P*H - P <= -eye(n)
    P >= eye(n)
cvx_end

P

%end

Af3 = [A B; zeros(1,3)];

Ag3 = [1 0 0;
      0 1 0;
      -K(1,1) -K(1,2) -K(1,4)];
  
H3 = exp(Af3*T1)*Ag3;

n = 3;

cvx_begin sdp
    variable P3(n,n) symmetric
    H3'*P3*H3 - P3 <= -eye(n)
    P3 >= eye(n)
cvx_end

P3



% n = 3;
% 
% cvx_begin sdp
%     variable F
%     variable Phelp(n,n) symmetric
%     %variable J(n,n)
%     [-(F+F')    F*Ag3   H3'*Phelp;
%        F*Ag3    -Phelp    0;
%      X'*Phelp   0   -Phelp] <= -eye(9)
%     Phelp >= eye(n)
% cvx_end
% 
% Phelp



P = 1.0e+16 *[
    1.3746    0.0714   -1.2442   -0.2024;
    0.0714    0.5430   -0.4492   -0.1707;
   -1.2442   -0.4492    1.8831   -0.1851;
   -0.2024   -0.1707   -0.1851    0.5600];




%%%%%%%%%%% Compute Lyapunov Candidate V(x) %%%%%%%%%%%
alpha = .001;

x1 = [z1';z2';zI';u'];
P = P/sqrt(norm(P));

for i = 1:length(z1)
    V(i) = exp(-alpha*tau(i))*((exp(Af*(T2-tau(i)))*x1(:,i))'*P*(exp(Af*(T2-tau(i)))*x1(:,i)));
    V2(i)= exp(alpha*tau(i))*(exp(Af*tau(i))*x1(:,i))'*P*(exp(Af*tau(i))*x1(:,i));
end

% plot solution
figure(2) 
subplot(2,1,1); plot(t,abs(z1));
grid on
hold on
plot(t,V2,'r');
ylabel('$V(x)$','Interpreter','latex','FontSize', 18);
legend('|x|_A','V(x)');

err = abs(z1-r);
subplot(2,1,2),plot(t,err);
grid on
hold on
ylabel('$\left| r(t)-y(t) \right|$','Interpreter','latex','FontSize', 18);
xlabel('time (s)','Interpreter','latex','FontSize', 18);
legend('|r(t)-y(t)|');






