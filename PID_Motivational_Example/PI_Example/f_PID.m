function xdot = f_PID(x)

global Af cont K t_ u_ counter
z1  = x(1);
z2  = x(2);
zI  = x(3);
u   = x(4);
ms  = x(5);
tau = x(6);
r   = x(7);
time = x(8);

x1 = [z1; z2; zI; u; ms];

if(cont)
    x1 = [z1-r; z2; zI; u; ms];
    u = -K*x1;
    ms = z1-r;
    t_(counter) = time;
    u_(counter) = u;
    counter = counter + 1;
end

x1 = [z1; z2; zI; u; ms];
x2 = tau;

x1_dot = Af*x1;
x2_dot = -1;
       
xdot = [x1_dot;
        x2_dot;
        0;
        1];

end