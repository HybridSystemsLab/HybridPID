function inside = D_PID(x) 

tau = x(5);

if tau <= 0
    inside = 1;
else
    inside = 0;
end

end