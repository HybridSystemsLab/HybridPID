clear all
close all
clc
global kp ki kd T1 T2 test

test = 0;
kp =  300;
ki =  200;
kd =  10;

testingPID
plot(saved_t,saved_y,'--k');
hold on


kp =  250;
ki =  350;
kd =  30;

testingPID
plot(saved_t,saved_y,'--k');
hold on


for index = 1:3
    %clear all
    %clc

    kp =  300;
    ki =  200;
    kd =  10;

    color = 'k';
    switch index
        case 1
            T1 = .025;
            T2 = 2*T1;
            color = 'r';
        case 2
            kp =  250;
            ki =  350;
            kd =  30;
            T1 = .025;
            T2 = 2*T1;
            color = 'r';
        case 3
            test = 1;
            T1 = .025;
            T2 = 2*T1;
            color = 'g';
        case 4
            T1 = .06;
            T2 = .07;
            color = 'm';
        case 5
            T1 = .05;
            T2 = 2*T1;
            color = 'r';
        otherwise
            T1 = .01;
            T2 = 2*T1;
            color = 'k';
    end
    
    run_PID
    
    
    
    
    figure(1)
    %subplot(2,1,1), 
    plot(t,z1,color);
    grid on
    hold on
    ylabel('$y(t)$','Interpreter','latex','FontSize', 18);
    xlabel('t (s)','Interpreter','latex','FontSize', 18);
    axis([0 3 0 2]);
    
    %subplot(2,1,2); plot(t,u);
    %grid on
    %ylabel('$u(t)$','Interpreter','latex','FontSize', 18);
    %xlabel('time (s)','Interpreter','latex','FontSize', 18);
    %legend('u(t)');
    %axis([0 inf -5 5]);
    

end

plot(t,r,'r');

%legend('No Intermittence',...
%           'T_1 = 0.01, T_2 = 0.02',...
%           'T_1 = 0.025, T_2 = 0.05',...
%           'T_1 = 0.05, T_2 = 0.07',...
%           'T_1 = 0.06, T_2 = 0.07',...
%          'r');