%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   File: 
%       RunPID
%   
%   Description:
%       This file is used for finding the matrix P used in the construction
%   of the Lyapunov function, simulating the PID controller with the gains 
%   used to find matrix P under both continuous and intermittent case, and 
%   then plotting solutions.
%
%   Note System Dependencies: 
%       CVX convex optimization solver is used in this file
%
%   Authors: 
%       Daniel Lavell (dlavell@ucsc.edu)
%
%   Last Modified:  
%       3/19/18
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
global K A B C Af Ag T1 T2 cont t_ u_ counter


%%%%% Plant %%%%%%
A = [0 1;-1 0];
B = [0;1];
C = [1 1];

%%%%% Intermittency %%%%%%
T1 = .01;
T2 = .1;

%%%%% Gains %%%%%%
kp = 6;
ki = 2;
kd = 0;
kp_t = kp*C;      % - inv(1+ kd*C*B)*kd*C*B*kp*C;
ki_t = ki;        % - inv(1+ kd*C*B)*kd*C*B*ki;
%kd_t = inv(1+ kd*C*B)*kd*C*A;
K = [kp_t ki_t 0 0]

%%%%% Transformations %%%%%%
Af = [A [0;0] B [0;0];...
     0 0  0   0   1;...
      zeros(2,5)];
      
Ag = [1 0 0 0 0;
      0 1 0 0 0;
      0 0 1 0 0;
      -K;
      C  0 0 0];
%{
H1 = expm(Af*T2)*Ag;
H2 = expm(Af*T1)*Ag;
Hmid = expm(Af*(T1+T2)/2)*Ag;

%%%%%%%%% SOLVE FOR P %%%%%%%%%%%
    n = length(Af);
    cvx_begin sdp
        variable P(n,n) symmetric
        H1'*P*H1 - P <= -eye(n)
        Hmid'*P*Hmid - P <= -eye(n)
        H2'*P*H2 - P <= -eye(n)
        P >= eye(n)
    cvx_end
%}
    
%%%%%% Continuous Case %%%%%%
cont = 1;
counter = 1;

simulate_PID

% plot solution
figure(1)
subplot(3,1,1);
plot(t,z1,'k');
hold on
subplot(3,1,2); 
plot(t_,u_,'k');
hold on

%{
%%%%%%%%%% V(x) %%%%%%%%%%%
x1 = [z1';z2';zI';u_(1:length(z1));ms'];
for i = 1:length(t)
    V(i) = x(i,1:5)*expm(Af'*0)*P*expm(Af*0)*x(i,1:5)';
end
figure(2) 
plot(t,V,'k');
hold on
%}


%%%%%%%% Intermittent Case %%%%%%%%
cont = 0;
simulate_PID


% plot solution
figure(1)
subplot(3,1,1);
plot(t,z1,'b');
grid on
legend('Continuous Case','With Intermittency');
ylabel('$y(t)$','Interpreter','latex','FontSize', 18);

subplot(3,1,2); 
plot(t,u,'b');
grid on
legend('Continuous Case','With Intermittency');
ylabel('$u(t)$','Interpreter','latex','FontSize', 18);
%xlabel('$t(s)$','Interpreter','latex','FontSize', 18);
axis([0 5 -1 6])

subplot(3,1,3); 
plot(t,tau);
grid on
legend('\tau');
ylabel('$\tau(t)$','Interpreter','latex','FontSize', 18);
xlabel('$t(s)$','Interpreter','latex','FontSize', 18);
axis([0 5 0 .11])

%{  
%%%%%%%%%% V(x) %%%%%%%%%%%
x1 = [z1';z2';zI';u';ms'];
clear V
for i = 1:length(t)
    V(i) = x(i,1:5)*expm(Af'*x(i,6))*P*expm(Af*x(i,6))*x(i,1:5)';
end

figure(2) 
grid on
plot(t,V,'b');
legend('Continuous Case','With Intermittency');
xlabel('$t(s)$','Interpreter','latex','FontSize', 18);
ylabel('$V(x)$','Interpreter','latex','FontSize', 18);
%}

    
    
    






%subplot(311)
%plot(t,z1)
%subplot(312)
%a = .01;
%for i = 1:length(t)
%    V(i) = x(i,1:5)*expm(Af'*x(i,6))*P*expm(Af*x(i,6))*x(i,1:5)';
%end
%plot(t,V)
%subplot(313)
%plot(t,x(:,6))

%{
for index = 1:100

    %%%%% Gains %%%%%%
    rand_p = 200;
    rand_i = 200;
    rand_d = 25;

    % Plug and chuggggg
    kp =  100 + rand_p*rand;
    ki =  100 + rand_i*rand;
    kd =  0   + rand_d*rand;
    
    kp_t = kp*C - inv(1+ kd*C*B)*kd*C*B*kp*C;
    ki_t = ki - inv(1+ kd*C*B)*kd*C*B*ki;
    kd_t = inv(1+ kd*C*B)*kd*C*A;
    K = [kp_t+kd_t ki_t 0 0];
    
    %%%%% Transformations %%%%%%
    Af = [A [0;0] B [0;0];...
         0 0  0   0   1;...
          zeros(2,5)];
      
    Ag = [1 0 0 0 0;
          0 1 0 0 0;
          0 0 1 0 0;
          -K;
          C  0 0 0];
      
    %H1 = exp(Af*T1)*Ag;
    H2 = exp(Af*T2)*Ag;

    %% %%%%%%%%% SOLVE FOR P %%%%%%%%%%%
    n = 5;
    cvx_begin sdp
        variable P(n,n) symmetric
        %H1'*P*H1 - P <= -eye(n)
        H2'*P*H2 - P <= -eye(n)
        P >= eye(n)
    cvx_end
    
    P
    
    if(~isnan(P(1,1))) % Apparently not a valid way to check 
        display('Found One !!!!!!');
        [kp ki kd]
        break
    end
end

%% %%%% Continuous Case %%%%%%
cont = 1;
counter = 1;

simulate_PID

% plot solution
figure(1)
subplot(2,1,1);
plot(t,z1,'k');
hold on
subplot(2,1,2); 
plot(t_,u_,'k');
hold on

%%%%%%%%%%% V(x) %%%%%%%%%%%
x1 = [z1';z2';zI';u_(1:length(z1));ms'];
for i = 1:length(z1)
    V(i) = (exp(Af*0)*x1(:,i))'*P*(exp(Af*0)*x1(:,i));
end
figure(2) 
plot(t,V,'k');
hold on


%% %%%%%% Intermittent Case %%%%%%%%
cont = 0;
simulate_PID

% plot solution
figure(1)
subplot(2,1,1);
plot(t,z1,'b');
grid on
legend('Continuous Case','With Intermittency');
ylabel('$y(t)$','Interpreter','latex','FontSize', 18);

subplot(2,1,2); 
plot(t,u,'b');
grid on
legend('Continuous Case','With Intermittency');
ylabel('$u(t)$','Interpreter','latex','FontSize', 18);
xlabel('$t(s)$','Interpreter','latex','FontSize', 18);

%%%%%%%%%%% V(x) %%%%%%%%%%%
x1 = [z1';z2';zI';u';ms'];
clear V
for i = 1:length(z1)
    V(i) = (exp(Af*tau(i))*x1(:,i))'*P*(exp(Af*tau(i))*x1(:,i));
end

figure(2) 
grid on
plot(t,V,'b');
legend('Continuous Case','With Intermittency');
xlabel('$t(s)$','Interpreter','latex','FontSize', 18);
ylabel('$V(x)$','Interpreter','latex','FontSize', 18);
%}
