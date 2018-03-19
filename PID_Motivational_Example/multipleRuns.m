clear all
close all
clc
global kp ki kd T1 T2 DynamicGains threshold cont

DynamicGains = 0;
threshold = .01;

for index = 1:5
    %clear all
    %clc

    kp =  250;
    ki =  350;
    kd =  30;
    cont = 0;
    
    T1 = .01;
    T2 = 2*T1;
   
    color = 'k';
    switch index
        case 1
            cont = 1;
            color = 'k';
        case 2
            color = 'b';
        case 3
            %DynamicGains = 1;
            %threshold = .2;
            T1 = .025;
            T2 = 2*T1;
            color = 'c';
        case 4
            T1 = .05;
            T2 = .07;
            color = 'g';
        case 5
            T1 = .06;
            T2 = .07;
            color = 'm';
    end
    
    run_PID
    
    figure(1)
    %subplot(2,1,1), 
    plot(t,z1,color);
    grid on
    hold on
    ylabel('$y(t)$','Interpreter','latex','FontSize', 18);
    xlabel('$t (s)$','Interpreter','latex','FontSize', 18);
    axis([0 3 0 1.4]);
end

plot(t,r,'r');
%legend('K_0 Gains',...
%       'K_1 Gains',...
%       'Dynamic Gains')

legend('No Intermittence',...
           'T_1 = 0.01, T_2 = 0.02',...
           'T_1 = 0.025, T_2 = 0.05',...
           'T_1 = 0.05, T_2 = 0.07',...
           'T_1 = 0.06, T_2 = 0.07',...
          'reference (r)');