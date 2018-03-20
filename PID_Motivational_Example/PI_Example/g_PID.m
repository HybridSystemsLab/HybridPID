function xplus = g_PID(x)
global T1 T2 kp ki kd A B C K Ag

z1  = x(1);
z2  = x(2);
zI  = x(3);
u   = x(4);
ms  = x(5);
tau = x(6);
r   = x(7);
time = x(8);

x1 = [z1-r; z2; zI; u; ms];
x2 = tau;

x1_plus = Ag*x1;
x2_plus = T1 + (T2-T1)*rand(1,1);
       
x1_plus(1) = z1;
xplus = [x1_plus;
         x2_plus;
         r;
         time];
end