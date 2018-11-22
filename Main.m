clear;
close all;
clc;

format shortE;
format compact;


WhatToEvaluate = 1;
% 1 --> Convergence 
% 2 --> ShallowWater Model

switch WhatToEvaluate
    case 1
        %% Convergence
        % Testing previously the code with symetrichal functoins in order to
        % evaluate the convergence error of the code designed
        MainConvergence;
        
    case 2
        %% Case of Study
        Initialization_Study;
        
        ShallowWaterModel;
        
        %% Plots
        MainPlots;
            
    otherwise
        fprintf('Not found, sorry');
end





