function [value] = C_PID(x) 
global cont

if(cont) value = 1; return; end
tau = x(6);

if tau > 0
    value = 1;
else
    value = 0;
end


end