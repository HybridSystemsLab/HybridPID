function inside = D_PID(x) 

% If continuous - never jump.
global cont
if(cont) inside = 0; return; end

% Timer
tau = x(6);

if tau <= 0
    inside = 1;
else
    inside = 0;
end
end