function [LS_error_du, LS_error_dv] = adv_ConvergenceP2(Dim)

    [M,N,L,t0] = Geometry(Dim);

    %% Analytic

    % Define symbolic variables
    syms x y;

    %Symbolic vectors
    [us,vs]=SymbolicVelocities(x,y,L,t0);

    % Obtain the symbolic expressions for advection
    d_us = simplify(us * ( diff(us, x) + diff(vs, y) ));
    d_vs = simplify(vs* ( diff(us, x) + diff(vs, y) ));

    % Convert symbolic expression to Matlab functions
    f_us = matlabFunction(us,'Vars',[x y]);
    f_vs = matlabFunction(vs,'Vars',[x y]);
    f_dus = matlabFunction(d_us,'Vars',[x y]);
    f_dvs = matlabFunction(d_vs,'Vars',[x y]);

   %Staggered Mesh
    mesh = CreateStaggeredMesh(M,N,L);

    % Compute symbolic
    for j = 1:N + 4
        for  i = 1:M + 4

            % Compute the values of velocities according to the initialized fields
            u(i, j) = f_us(mesh.sx(i), mesh.cy(j));
            v(i ,j) = f_vs(mesh.cx(i), mesh.sy(j));

            % Compute the results of the advection using the symbolic expression
            sym_du_P2(i, j) = f_dus(mesh.sx(i), mesh.cy(j));
            sym_dv_P2(i, j) = f_dvs(mesh.cx(i), mesh.sy(j));

        end
    end

    % Ensure periodicity on the domain
    u = HaloUpdate(u);
    v = HaloUpdate(v);

    %% Numeric

    % Compute the results of the advection using the numeric operations
    num_du_P2 = ComputesPU2(u, v, L);
    num_dv_P2 = ComputesPV2(u, v, L);

    % Update halo
    num_du_P2 = HaloUpdate(num_du_P2);
    num_dv_P2 = HaloUpdate(num_du_P2);

    % Compare symbolic and numeric results
    error_du = abs(num_du_P2 - sym_du_P2);
    error_dv = abs(num_du_P2 - sym_du_P2);

    Sum_error_du=0;
    Sum_error_dv=0;
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
