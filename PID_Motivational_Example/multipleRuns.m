clear all
close all
clc
global kp ki kd T1 T2 DynamicGains threshold

DynamicGains = 0;
threshold = .01;
kp =  300;
ki =  200;
kd =  10;

%testingPID
%plot(saved_t,saved_y,'--k');
%hold on


kp =  250;
ki =  350;
kd =  30;

%testingPID
%plot(saved_t,saved_y,'--k');
%hold on


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
            color = 'k';
        case 3
            DynamicGains = 1;
            threshold = .05;
            T1 = .025;
            T2 = 2*T1;
            color = 'b';
        case 4
            DynamicGains = 1;
            threshold = .1;
            T1 = .025;
            T2 = 2*T1;
            color = 'b';
        case 5
            DynamicGains = 1;
            threshold = .1;
            T1 = .025;
            T2 = 2*T1;
            color = 'b';
        otherwise
            DynamicGains = 1;
            threshold = .1;
            T1 = .025;
            T2 = 2*T1;
            color = 'b';
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
legend('K_0 Gains',...
       'K_1 Gains',...
       'Dynamic Gains')

%legend('No Intermittence',...
%           'T_1 = 0.01, T_2 = 0.02',...
%           'T_1 = 0.025, T_2 = 0.05',...
%           'T_1 = 0.05, T_2 = 0.07',...
%           'T_1 = 0.06, T_2 = 0.07',...
%          'r');