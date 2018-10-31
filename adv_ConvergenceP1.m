% - symfun(..., [x y t]) ensures that the function is dependent on x, y and t.
% - matlabFunction(..., 'Vars', [x y z]) ensures that the function that is created takes the arguments in the [x y z] specified order.

function [LS_error_du,LS_error_dv] = adv_ConvergenceP1(Dim,DeltaT)

[M,N,L,t0] = Geometry(Dim);

%% Analytic

syms x y t us vs;

%Symbolic vectors
[us,vs]=SymbolicVelocities(x,y,L,t0);

%Time derivatives
du_dt = symfun( simplify( diff(us, t) ), [x y t] );
dv_dt = symfun( simplify( diff(vs, t) ), [x y t] );

%Symbolic into MATLAfunctions
f_us = matlabFunction(us,'Vars',[x y t]); % u field
f_vs = matlabFunction(vs,'Vars',[x y t]);
f_dus_dt = matlabFunction(du_dt,'Vars',[x y t]); % du/dt field
f_dvs_dt = matlabFunction(dv_dt,'Vars',[x y t]);

%Staggered Mesh
mesh = CreateStaggeredMesh(M,N,L);

%Fill u and v velociy fields
for j = 1:N + 4
    for  i = 1:M + 4
        
        % Compute the values of velocities according to the initialized fields
        u(i, j) = f_us(mesh.sx(i), mesh.cy(j), t0);
        v(i ,j) = f_vs(mesh.cx(i), mesh.sy(j), t0);
        
        % Compute velocity increment using the symbolic expression
        sym_du_P1(i, j) = f_dus_dt(mesh.sx(i), mesh.cy(j), t0) * DeltaT;
        sym_dv_P1(i, j) = f_dvs_dt(mesh.cx(i), mesh.sy(j), t0) * DeltaT;
        
    end
end

u = HaloUpdate(u);
v = HaloUpdate(v);

%% Numeric

%Source terms
P1u = simplify( diff(us*us,x) + diff(us*vs,y) );
P1v = simplify( diff(us*vs,x) + diff(vs*vs,y) );
nu_ST = symfun( simplify( diff(us,t)+P1u ), [x,y,t] );
nv_ST = symfun( simplify( diff(vs,t)+P1v ), [x,y,t] );

%Symbolic into matlabFunction
f_nu_ST = matlabFunction(nu_ST, 'Vars', [x y t]);
f_nv_ST = matlabFunction(nv_ST, 'Vars', [x y t]);

% Compute numeric values for the symbolic source term
for j = 1:N + 4
    for  i = 1:M + 4
        
        % Compute the source terms
        nu(i, j) = f_nu_ST(mesh.sx(i), mesh.cy(j), t0);
        nv(i ,j) = f_nv_ST(mesh.cx(i), mesh.sy(j), t0);
        
    end
end

nu = HaloUpdate(nu);
nv = HaloUpdate(nv);

% Compute the results of the advection using TVD
num_deltau = ComputesPU1(u, v, L, DeltaT)  + nu*DeltaT;
num_deltav = ComputesPV1(u, v, L, DeltaT)  + nv*DeltaT;

% Ensure periodicity on the domain
num_deltau = HaloUpdate(num_deltau);
num_deltav = HaloUpdate(num_deltav);

%% Comparison
error_du = abs(num_deltau - sym_du_P1);
error_dv = abs(num_deltav - sym_dv_P1);

Sum_error_du = 0;
Sum_error_dv = 0;

% Get LS errors
for j = 1:N + 4
    for  i = 1:M + 4
        
        Sum_error_du = Sum_error_du + error_du(i,j)^2;
        Sum_error_dv = Sum_error_dv + error_dv(i,j)^2;
        
    end
end

LS_error_du = Sum_error_du/Dim^2;
LS_error_dv = Sum_error_dv/Dim^2;

end