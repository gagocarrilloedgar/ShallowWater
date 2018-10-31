function PV1 = ComputesPV1(u, v, L, DeltaT)

    [M, N] = size(u);

    PV1 = zeros(M, N);

	M = M - 4;
    N = N - 4;

    % Compute length increments
    Deltax = L / M; % [m] 
    Deltay = L / N; % [m] 

    % Compute for the domain
    for i = 3:M + 2
        for j = 3:N + 2

            % Compute the Courant numbers
            CwP = 0.5 * ( 0.5 * ( u(i - 1, j + 1) + abs(u(i - 1, j + 1)) ) + 0.5 * ( u(i - 1, j) + abs(u(i - 1, j)) ) ) * DeltaT / Deltax;
            CwM = 0.5 * ( 0.5 * ( u(i - 1, j + 1) - abs(u(i - 1, j + 1)) ) + 0.5 * ( u(i - 1, j) - abs(u(i - 1, j)) ) ) * DeltaT / Deltax;
            CeP = 0.5 * ( 0.5 * ( u(i, j + 1) + abs(u(i, j + 1)) ) + 0.5 * ( u(i, j) + abs(u(i, j)) ) ) * DeltaT / Deltax;
            CeM = 0.5 * ( 0.5 * ( u(i, j + 1) - abs(u(i, j + 1)) ) + 0.5 * ( u(i, j) - abs(u(i, j)) ) ) * DeltaT / Deltax;
            CsP = 0.5 * ( 0.5 * ( v(i, j - 1) + abs(v(i, j - 1)) ) + 0.5 * ( v(i, j) + abs(v(i, j)) ) ) * DeltaT / Deltay;
            CsM = 0.5 * ( 0.5 * ( v(i, j - 1) - abs(v(i, j - 1)) ) + 0.5 * ( v(i, j) - abs(v(i, j)) ) ) * DeltaT / Deltay;
            CnP = 0.5 * ( 0.5 * ( v(i, j) + abs(v(i, j)) ) + 0.5 * ( v(i, j + 1) + abs(v(i, j + 1)) ) ) * DeltaT / Deltay;
            CnM = 0.5 * ( 0.5 * ( v(i, j) - abs(v(i, j)) ) + 0.5 * ( v(i, j + 1) - abs(v(i, j + 1)) ) ) * DeltaT / Deltay;

            % Compute the values of rXP, rXM, rYP and rYM
            rxPprev = r_Plus(v(i-2,j), v(i-1,j), v(i,j));
            rxMprev = r_Minus(v(i-1,j), v(i,j), v(i+1,j));
            rxP = r_Plus(v(i-1,j), v(i,j), v(i+1,j));
            rxM = r_Minus(v(i,j), v(i+1,j), v(i+2,j));
            ryPprev = r_Plus(v(i,j-2), v(i,j-1), v(i,j));
            ryMprev = r_Minus(v(i,j-1), v(i,j), v(i,j+1));
            ryP = r_Plus(v(i,j-1), v(i,j), v(i,j+1));
            ryM = r_Minus(v(i,j), v(i,j+1), v(i,j+2));

            % Compute the values of the components of Bw, Be, Bs and Bn
            VwP = U_Plus(v(i-1,j),v(i,j),rxPprev,CwP);
            VwM = U_Minus(v(i-1,j),v(i,j),rxMprev,CwM);
            VeP = U_Plus(v(i,j),v(i+1,j),rxP,CeP);
            VeM = U_Minus(v(i,j),v(i+1,j),rxM,CeM);
            VsP = U_Plus(v(i,j-1),v(i,j),ryPprev,CsP);
            VsM = U_Minus(v(i,j-1),v(i,j),ryMprev,CsM);
            VnP = U_Plus(v(i,j),v(i,j+1),ryP,CnP);
            VnM = U_Minus(v(i,j),v(i,j+1),ryM,CnM);

            % Set result
            PV1(i, j) = CwP * VwP + CwM * VwM - CeP * VeP - CeM * VeM + CsP * VsP + CsM * VsM - CnP * VnP - CnM * VnM;

        end
    end
end