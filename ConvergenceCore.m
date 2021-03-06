LS_err_du_P2 = zeros(length(Dim),1);
LS_err_du_P1 = zeros(length(Dim),1);

LS_err_dv_P2 = zeros(length(Dim),1);
LS_err_dv_P1 = zeros(length(Dim),1);

LS_err_dh = zeros(length(Dim),1);
LS_err_AB = zeros(length(Dim),1);

Selection =  3 ;
%%UnComment to get all the results

for k=1:1
    Selection = 4;
    
    switch(Selection)
        
        % Checking P2
        case (Options(1))
            %Computing error vector
            
            for i=1:length(Dim)
                [LS_err_du_P2(i), LS_err_dv_P2(i)] = adv_ConvergenceP2(Dim(i));
            end
            
            
            %Checking P1
        case (Options(2))
            
            %Computing error vector
            
            for i=1:length(Dim)
                [LS_err_du_P1(i),LS_err_dv_P1(i)] = adv_ConvergenceP1(Dim(i),DeltaT);
            end
                
        case (Options(3))
            
            %Computing error vector
            
            for i=1:length(Dim)
                [LS_err_dh(i)] = ConvergenceOfH(Dim(i), DeltaT);
            end
            
            %Creating the plots
            
        case (Options(4))
            for i=1:length(Dim)
                [LS_err_AB(i)] = AdamBashforthConvergence(Dim(i), DeltaT);
            end
            loglog(1./Dim,LS_err_AB,'or');
            
        otherwise
            fprintf('Not an available option');
            
    end
          
end
