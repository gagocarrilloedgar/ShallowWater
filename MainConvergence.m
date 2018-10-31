clear;
close all;
clc;

format shortE;
format compact;

%Main file to validate the error of the created functions

%% Systm Inputs
Initialization;

LS_err_du = zeros(length(Dim),1);
LS_err_dv = zeros(length(Dim),1);
LS_err_dh = zeros(length(Dim),1);

%% Select the option to evaluate
Selection =  3 ;
%%UnComment to get all the results

%%for k=1:3
    %Selection = k;
    
switch(Selection)
    
    % Checking P2
    case (Options(1))
        %Computing error vector
        
        for i=1:length(Dim)
            [LS_err_du(i), LS_err_dv(i)] = adv_ConvergenceP2(Dim(i));
        end
        
        %Creating the plots
        figure;
        loglog(1./Dim, LS_err_dv,'or');
        hold on;
        title('Convergence of P2 with Ls fitting');
        ylabel('Absolute Error');
        xlabel('\Deltax');
        y=745*(1./Dim).^(4.052);
        loglog(1./Dim,y,'g');
       
        
    %Checking P1
    case (Options(2))
        
        %Computing error vector
        
        for i=1:length(Dim)
            [LS_err_du(i),LS_err_dv(i)] = adv_ConvergenceP1(Dim(i),DeltaT);
        end
        
        %Creating the plots
        figure;
        loglog(1./Dim, LS_err_dv,'or-');
        title('Convergence of P1 with Ls fitting');
        ylabel('Absolute Error');
        xlabel('\Deltax'); 
        y=(1.507e-7)*(1./Dim).^(3.2);
        loglog(1./Dim,y,'g');
   
        
    case (Options(3))
        
        %Computing error vector
        
        for i=1:length(Dim)
            [LS_err_dh(i)] = ConvergenceOfH(Dim(i), DeltaT);
        end
        
        %Creating the plots
        figure;
        loglog(1./Dim, LS_err_dh, 'or');
        hold on
        y=(0.02869)*(1./Dim).^(4.082);
        loglog(1./Dim,y,'g');
        title('Convergence of h with Ls fitting');
        ylabel('Absolute Error');
        xlabel('\Deltax');
       
        
    case (Options(4))
        fprintf('Not implemented yet');
        
    otherwise
        fprintf('Not an available option');
        
%%end

end
