function [Err_AB] = AdamBashforthConvergence(Dim,T,DeltaT)

N = Dim;
M = Dim;
M_Halo = M + 4;
N_Halo = N + 4;
T0 = 0;

%Initial Parameters and vectors
Initialization_Study;

%Setting-up the vectors;
GetSourceExpressions;
eta_source_save = zeros(M_Halo,N_Halo,T);

for t=1:T
    u_save(:, :, t) = u_t;
    v_save(:, :, t) = v_t;
    eta_save(:, :, t) = eta_t;
    
    %Eta_source
    for j = 1:N + 4
        for  i = 1:M + 4
            eta_source_save(i, j, t) = f_hs(mesh.cx(i), mesh.cy(j), t0 + DeltaT * t) - D + h(i,j);
        end
    end
    
    %eta (num)
    Deltaeta = ComputesH(u_t,v_t,D + eta_t - h,L,DeltaT);
    
    %eta(source terms)
    Deltaeta_s = addSource(fh, mesh.cx, mesh.cy, DeltaT, t0 + DeltaT * t);
    
    Delta_etat = Deltaeta_s + Deltaeta;
    
    eta_P1 = eta_t + AdamBashforthIntegral(Delta_etat,eta_Time(:,:,2),eta_Time(:,:,3),t);
 
    eta_P1 = HaloUpdate(eta_P1);
    
    %Velocities due to advective terms
    ut_adv = u_adv(u_t,v_t,L,DeltaT);
    vt_adv = v_adv(u_t,v_t,L,DeltaT);
    
    %Velocities due to pressure terms
    [ut_press,vt_press] = PressureTerms(eta_P1,g,L,DeltaT);
    
    % Increment of velocities due to source term
    u_s = addSource(fu, mesh.sx, mesh.cy, DeltaT, t0 + DeltaT * t) + addSource(fpx, mesh.sx, mesh.cy, DeltaT, t0 + DeltaT * t);
    v_s = addSource(fv, mesh.cx, mesh.sy, DeltaT, t0 + DeltaT * t) + addSource(fpy, mesh.cx, mesh.sy, DeltaT, t0 + DeltaT * t);
    
    Deltau = ut_adv + ut_press + u_s;
    Deltav = vt_adv + vt_press + v_s;
    
    %Time integration
    deltaUS = AdamBashforthIntegral(Deltau,u_Time(:,:,2),u_Time(:,:,3),t);
    deltaVS= AdamBashforthIntegral(Deltav,v_Time(:,:,2),v_Time(:,:,3),t);
    
    US = u_t + deltaUS;
    VS = v_t + deltaVS;
    
    %Coriolis
    %[U_n1,V_n1] = CoriolistTerms(alpha,f,DeltaT,u_t,v_t,US,VS);
    
    %Update velocites
    u_F = HaloUpdate(US);
    v_F = HaloUpdate(VS);
    
    err_AB_t=eta_save(:,:,t) - eta_source_save(:,:,t);
    err_AB_tmax(t,1) = max(err_AB_t(:));   
    
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
Err_AB = max(err_AB_tmax(:));
end