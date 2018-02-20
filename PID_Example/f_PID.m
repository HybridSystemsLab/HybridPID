function xdot = f_PID(x)

global A B 
z1  = x(1);
z2  = x(2);
zI  = x(3);
u   = x(4);
tau = x(5);
ms  = x(6);
tauI= x(7);
r   = x(8);
time= x(9);

xI = [z1 z2 zI]';
x1 = [xI; u];
x2 = [tau ms tauI]';

Af = [A [0;0] B;zeros(2,4)];
    
C = [1 0];
D = 0;

x1_dot = Af*x1;
x2_dot = [-1;
           0;
           1];
       
xdot = [x1_dot;
        x2_dot;
        0;
        1];

end