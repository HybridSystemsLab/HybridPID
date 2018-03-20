function xplus = g_PID(x)
global T1 T2 Ag

z  = x(1:2);
u   = x(3);

x1 = [z; u];
x1_plus = Ag*x1;
x2_plus = T1 + (T2-T1)*rand(1,1);
       
xplus = [x1_plus;
         x2_plus;];
end