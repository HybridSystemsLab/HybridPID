function xplus = g_PID(x)
global T1 T2 kp ki kd A B ag K

z1  = x(1);
z2  = x(2);
zI  = x(3);
u   = x(4);
ms  = x(5);
tau = x(6);
tauI= x(7);
r   = x(8);
z1t = x(9);
z2t = x(10);

%zI = zI + ms*tauI;
x1 = [z1; z2; zI; u; ms];
x2 = [tau; tauI];
 

k = 1;
m = 1;

A = [0 1;-k/m 0];
B = [0;1/m];
C = [1 0];
D = 0;

bf = B;
bs = B;

%if(tauI == 0) 
%    Kg = 0;
%else
%    Kg = ((z1-r)-ms)/(tauI*z1);
%end
%K = [kp*(1-r/z1)+kd*Kg 0 ki 0];

Kg = inv(1+ kd*C*bf);
K = [[kp*(1-r/z1) 0]+kd*Kg*A(1,:) ki 0 0];

Ag = [1 0 0 0 0;
      0 1 0 0 0;
      0 0 1 0 0;
      -K;
       C*(1-r/z1)  0 0 0];
ag = Ag;

x1_plus = Ag*x1;
x2_plus = [T1 + (T2-T1)*rand(1,1);
           0];
       
xplus = [x1_plus;
         x2_plus
         1;
         z1;
         z2];
end