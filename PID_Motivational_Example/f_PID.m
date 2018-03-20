function xdot = f_PID(x)

global A B kp ki kd DynamicGains threshold cont t_switch


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
time= x(11);

C = [1 0];
D = 0;

if(abs(z1t-r) < threshold*r && DynamicGains && t_switch == 0)
   kp =  250;
   ki =  350;
   kd =  30;
   t_switch = time
end

if(cont)
    x1 = [z1; z2; zI; u; ms];
    Kg = inv(1+ kd*C*bf);
    K = [[kp*(1-r/z1) 0]+kd*Kg*A(1,:) ki 0 0];
    u = -K*x1;
    ms = z1-r;
end


x1 = [z1; z2; zI; u; ms];
x2 = [tau; tauI];

Af = [A [0;0] B [0;0];...
     0 0  0   0   1;...
     zeros(2,5)];
    

x1_dot = Af*x1;
x2_dot = [-1;
           0];
zt_dot = A*[z1t;z2t] + B*u;  

xdot = [x1_dot;
        x2_dot;
        0;
        zt_dot;
        1];

end