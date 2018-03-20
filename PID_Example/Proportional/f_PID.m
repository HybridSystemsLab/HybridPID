function xdot = f_PID(x)

global Af 
z  = x(1:2);
u   = x(3);
tau = x(4);


x1_dot = Af*[z; u];
x2_dot = -1;
       
xdot = [x1_dot;
        -1];

end