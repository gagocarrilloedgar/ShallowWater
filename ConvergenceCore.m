LS_err_du = zeros(length(Dim),1);
LS_err_dv = zeros(length(Dim),1);
LS_err_dh = zeros(length(Dim),1);

Selection =  3 ;
%%UnComment to get all the results

for k=1:3
    Selection = k;
    
    switch(Selection)
        
        % Checking P2
        case (Options(1))
            %Computing error vector
            
            for i=1:length(Dim)
                [LS_err_du(i), LS_err_dv(i)] = adv_ConvergenceP2(Dim(i));
            end
            
            
            %Checking P1
        case (Options(2))
            
            %Computing error vector
            
            for i=1:length(Dim)
                [LS_err_du(i),LS_err_dv(i)] = adv_ConvergenceP1(Dim(i),DeltaT);
            end
                
        case (Options(3))
            
            %Computing error vector
            
            for i=1:length(Dim)
                [LS_err_dh(i)] = ConvergenceOfH(Dim(i), DeltaT);
            end
            
            %Creating the plots
            
        case (Options(4))
            for i=1:length(Dim)
                %[AdamBashforthInt(i)] = AdamBashforthConvergence(Dim(i), DeltaT);
            end
            
        otherwise
            fprintf('Not an available option');
            
    end
          
end
