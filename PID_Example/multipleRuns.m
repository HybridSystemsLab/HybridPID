clear all
clc
global kp ki kd



for index = 1:100
    close all
    clear all
    clc

    rand_p = 100;
    rand_i = 100;
    rand_d = 20;

    kp =  155;
    ki =  140;
    kd =  28;
    %kp =  30;
    %ki =  .3;
    %kd =  3;
    %kp = rand_p*rand(1,1) + 100;
    %ki = rand_i*rand(1,1) + 100;
    %kd = rand_d*rand(1,1) + 10;
    run_PID

    if(~isnan(P(1,1)))% || ~isnan(P3(1,1)))
        display('Found One !!!!!!');
        [kp ki kd]
        return
    end
end

%% T1 = T2 = .01
%% Successful P values [kp ki kd] 

% [52.7435 108.1113 56.637]
% 167.7552  195.5035   21.2807      r=0
% 181.0618  120.8545   23.6339


% 154.9554  137.8394  27.9283
% P =
% 
%    1.0e+16 *
% 
%     1.3746    0.0714   -1.2442   -0.2024
%     0.0714    0.5430   -0.4492   -0.1707
%    -1.2442   -0.4492    1.8831   -0.1851
%    -0.2024   -0.1707   -0.1851    0.5600

%% Successful P3 values [kp ki kd]

% [28.3092  130.2015    1.1778]
% [58.1188    5.8383    3.0877]
% [43.2453  101.2547    2.7103]
% [57.1506  157.8487    1.5739]
% [50.0256  143.4244    3.4767]
% [14.2570  116.7311    2.3459]

%% Successful P AND P3 values [kp ki kd]

% 62.2065    0.2846    3.6548
% 1.4894     0.3546    0.1752       r=0