
global kp ki kd

k = 1;
m = 1;

A = [0 1;-k/m 0];
B = [0;1/m];
C = [1 0];
D = 0;


bf = B;
bs = B;

Kg = inv(1+ kd*C*bf);

Apid = [A zeros(size(A,1),1); C zeros(1,1)];
Bpid = [bf bs; 0 -1];
Cpid = [C 0;C 0; zeros(1,size(C,2)) 1; Kg*C*A 0];
Dpid = [0 0;0 -1;0 0;0 Kg*C*bs];

Apid_cl = [A-bf*(kp*C+kd*Kg*C*A) -bf*ki; C 0];
Bpid_cl = [bf*(kp-kd*Kg*C*bs)+bs; -1];
Cpid_cl = [C 0];
Dpid_cl = 0;

states_pid = {'x','x_dot','z'};
inputs_pid = {'s'};
outputs_pid= {'x'};
sys_ss_pid = ss(Apid_cl,Bpid_cl,Cpid_cl,Dpid_cl, ...
                'statename',states_pid, ...
                'inputname',inputs_pid, ...
                'outputname',outputs_pid)

figure(1);
grid on
hold on
t = 0:0.01:5;
r = 1*ones(size(t));

[y,t,x] = lsim(sys_ss_pid,r,t,[0.00001 0 0]);
%subplot(2,1,1), plot(t,y,'-b');
%ylabel('x');
%title('Closed-Loop step response with PID controller in SS form');

saved_t = t;
saved_y = y;

