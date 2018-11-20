for t = 1:T
            u_save(:, :, t) = u_t;
            v_save(:, :, t) = v_t;
            eta_save(:, :, t) = eta_t;
            
            %Geometry
            Deltaeta = ComputesH(u_t,v_t,D + eta_t - h,L,DeltaT);
            
            eta_P1 = eta_t + AdamBashforthIntegral(Deltaeta,eta_Time(:,:,2),eta_Time(:,:,3),t);
            
            eta_P1 = HaloUpdate(eta_P1);
            
            %Velocities due to advective terms
            ut_adv = u_adv(u_t,v_t,L,DeltaT);
            vt_adv = v_adv(u_t,v_t,L,DeltaT);
            
            %Velocities due to pressure terms
            [ut_press,vt_press] = PressureTerms(eta_P1,g,L,DeltaT);
            
            Deltau = ut_adv + ut_press;
            Deltav = vt_adv + vt_press;
            
            %Time integration
            deltaUS = AdamBashforthIntegral(Deltau,u_Time(:,:,2),u_Time(:,:,3),t);
            deltaVS= AdamBashforthIntegral(Deltav,v_Time(:,:,2),v_Time(:,:,3),t);
            
            US = u_t + deltaUS;
            VS = v_t + deltaVS;
            
            %Coriolis
            [U_n1,V_n1] = CoriolistTerms(alpha,f,DeltaT,u_t,v_t,US,VS);
            
            %Update velocites
            u_F = HaloUpdate(U_n1);
            v_F = HaloUpdate(V_n1);
            
            %eta_P1 = addDroplets(eta_P1, randi([0 2]), t, 10, 0, 0, 2000);
            
            %Update time integrations fields;
            u_t=u_F;
            u_Time(:,:,1) = u_t;
            u_Time(:,:,3) = u_Time(:,:,2);
            u_Time(:,:,2) = Deltau;
                
            v_t = v_F;
            v_Time(:,:,1) = v_t;
            v_Time(:,:,3) = v_Time(:,:,2);
            v_Time(:,:,2) = Deltav;        
            
            eta_t = eta_P1;
            eta_Time(:,:,1) = eta_t; 
            eta_Time(:,:,3) = eta_Time(:,:,2);
            eta_Time(:,:,2) = Deltaeta;
            
        end