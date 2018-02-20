function xdot = f_PID(x)

global A B cont kp ki kd test


z1  = x(1);
z2  = x(2);
zI  = x(3);
u   = x(4);
tau = x(5);
ms  = x(6);
tauI= x(7);
r   = x(8);
z1t = x(9);
z2t = x(10);


if(cont)
    x1 = [z1;z2;zI;u];
    C = [1 0];
    Kg = inv(1+ kd*C*B);
    K = [[kp 0]+kd*Kg*A(1,:) ki 0];
    u = -K*x1;
end

if(abs(z1t-r) < .04*r && test)
   kp =  250;
   ki =  350;
   kd =  30;
end

%if((abs(z1t-r) < .01*r) && test)
  %zI = 0;
%end


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
zt_dot = A*[z1t;z2t] + B*u;  

xdot = [x1_dot;
        x2_dot;
        0;
        zt_dot];

end