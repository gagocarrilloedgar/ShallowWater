function [LS_error_dh] = ConvergenceOfH(Dim, DeltaT)

% Set the situation up

[M,N,L,t0] = Geometry(Dim);
D = 1000;

%% Analytic

% Define symbolic variables
syms x y t us vs hs;

% Initialize symbolic fields with arbitrary periodic functions
[us,vs]=SymbolicVelocities(x,y,L,t0);
hs = cos(2 * pi * x/L) * cos(2 * pi * y / L) * t + D;

% Obtain the time derivative
dh_dt = symfun( simplify( diff(hs, t) ), [x y t] );

% Convert symbolic expression to matlab function
f_u_s = matlabFunction(us,'Vars',[x y t]); % u field
f_v_s = matlabFunction(vs,'Vars',[x y t]); % v field
f_h_s = matlabFunction(hs,'Vars',[x y t]); % h field
f_dh_dt_s = matlabFunction(dh_dt,'Vars',[x y t]); % dh/dt field

% Get staggered and centered coordinates
mesh = CreateStaggeredMesh(M, N, L);

% Compute numeric values from the symbolic solution
for j = 1:N + 4
    for  i = 1:M + 4
        
        % Compute the values of velocities according to the initialized fields
        u(i, j) = f_u_s(mesh.sx(i), mesh.cy(j), t0);
        v(i ,j) = f_v_s(mesh.cx(i), mesh.sy(j), t0);
        h(i ,j) = f_h_s(mesh.cx(i), mesh.cy(j), t0);
        
        % Compute h increment using the symbolic expression
        sym_dh(i, j) = f_dh_dt_s(mesh.cx(i), mesh.cy(j), t0) * DeltaT;
        
    end
end

% Ensure periodicity on the domain
u = HaloUpdate(u);
v = HaloUpdate(v);
h = HaloUpdate(h);

%% Numeric

cons_h_s = simplify( diff(hs*us,x)+ diff(hs*vs,y) );

fh_s = symfun( simplify( diff(hs,t)+cons_h_s ) , [x,y,t] );

% Convert symbolic expression to Matlab function
f_fh_s = matlabFunction(fh_s,'Vars',[x y t]);

% Compute numeric values for the symbolic source term
for j = 1:N + 4
    for  i = 1:M + 4
        
        % Compute the source term
        fh(i, j) = f_fh_s(mesh.cx(i), mesh.cy(j), t0);
        
    end
end

% Ensure periodicity on the domain
fh = HaloUpdate(fh);

% Compute the results of the advection using the numeric operations
num_deltah = ComputesH(u, v, h, L, DeltaT)  + fh*DeltaT;

% Ensure periodicity on the domain
num_deltah = HaloUpdate(num_deltah);

%% Comparison

% Compare Analytic and numeric results
error_dh = abs(num_deltah - sym_dh );

Sum_error_dh = 0;

% Get LS errors
for j = 1:N + 4
    for  i = 1:M + 4
        
        Sum_error_dh = Sum_error_dh + error_dh(i,j)^2;
        
    end
end

LS_error_dh = Sum_error_dh/Dim^2;
end