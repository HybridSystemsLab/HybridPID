function [value] = C_PID(x) 

tau = x(5);

if tau > 0
    value = 1;
else
    value = 0;
end

end