function  PU1= ComputesP1(u,v,L,DeltaT)

    % Mesh size
    [M, N] = size(u);

    % Initialize output array
    PU1 = zeros(M, N);

    % Deletes the extra halo cells in order to compute the matrix correctly
	M = M - 4;
    N = N - 4;

    Deltax = L / M; % [m] - length in x direction
    Deltay = L / N; % [m] - length in y direction

    % Compute for the domain
    for i = 3:M + 2
        for j = 3:N + 2

            % Compute the Courant numbers
            CwP = 0.5 * ( 0.5 * ( u(i - 1, j) + abs(u(i - 1, j)) ) + 0.5 * ( u(i, j) + abs(u(i, j)) ) ) * DeltaT / Deltax;
            CwM = 0.5 * ( 0.5 * ( u(i - 1, j) - abs(u(i - 1, j)) ) + 0.5 * ( u(i, j) - abs(u(i, j)) ) ) * DeltaT / Deltax;
            CeP = 0.5 * ( 0.5 * ( u(i, j) + abs(u(i, j)) ) + 0.5 * ( u(i + 1, j) + abs(u(i + 1, j)) ) ) * DeltaT / Deltax;
            CeM = 0.5 * ( 0.5 * ( u(i, j) - abs(u(i, j)) ) + 0.5 * ( u(i + 1, j) - abs(u(i + 1, j)) ) ) * DeltaT / Deltax;
            CsP = 0.5 * ( 0.5 * ( v(i, j - 1) + abs(v(i, j - 1)) ) + 0.5 * ( v(i + 1, j - 1) + abs(v(i + 1, j - 1)) ) ) * DeltaT / Deltay;
            CsM = 0.5 * ( 0.5 * ( v(i, j - 1) - abs(v(i, j - 1)) ) + 0.5 * ( v(i + 1, j - 1) - abs(v(i + 1, j - 1)) ) ) * DeltaT / Deltay;
            CnP = 0.5 * ( 0.5 * ( v(i, j) + abs(v(i, j)) ) + 0.5 * ( v(i + 1, j) + abs(v(i + 1, j)) ) ) * DeltaT / Deltay;
            CnM = 0.5 * ( 0.5 * ( v(i, j) - abs(v(i, j)) ) + 0.5 * ( v(i + 1, j) - abs(v(i + 1, j)) ) ) * DeltaT / Deltay;

            % Compute the values of rXP, rXM, rYP and rYM
            rxPprev = r_Plus(u(i-2,j), u(i-1,j), u(i,j));
            rxMprev = r_Minus(u(i-1,j), u(i,j), u(i+1,j));
            rxP = r_Plus(u(i-1,j), u(i,j), u(i+1,j));
            rxM = r_Minus(u(i,j), u(i+1,j), u(i+2,j));
            ryPprev = r_Plus(u(i,j-2), u(i,j-1), u(i,j));
            ryMprev = r_Minus(u(i,j-1), u(i,j), u(i,j+1));
            ryP = r_Plus(u(i,j-1), u(i,j), u(i,j+1));
            ryM = r_Minus(u(i,j), u(i,j+1), u(i,j+2));

            % Compute the values of the components of Bw, Be, Bs and Bn
            UwP = U_Plus(u(i-1,j),u(i,j),rxPprev,CwP);
            UwM = U_Minus(u(i-1,j),u(i,j),rxMprev,CwM);
            UeP = U_Plus(u(i,j),u(i+1,j),rxP,CeP);
            UeM = U_Minus(u(i,j),u(i+1,j),rxM,CeM);
            UsP = U_Plus(u(i,j-1),u(i,j),ryPprev,CsP);
            UsM = U_Minus(u(i,j-1),u(i,j),ryMprev,CsM);
            UnP = U_Plus(u(i,j),u(i,j+1),ryP,CnP);
            UnM = U_Minus(u(i,j),u(i,j+1),ryM,CnM);

            % Set result
            PU1(i, j) = CwP * UwP + CwM * UwM - CeP * UeP - CeM * UeM + CsP * UsP + CsM * UsM - CnP * UnP - CnM * UnM;
        end
    end

end

