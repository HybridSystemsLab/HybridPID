function inside = D_PID(x) 
global cont

if(cont) inside = 0; return; end

tau = x(6);

if tau <= 0
    inside = 1;
else
    inside = 0;
end

end