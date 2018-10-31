function DeltaH = ComputesH(u,v,h,L,DeltaT)
    [M, N] = size(u);

    DeltaH = zeros(M, N);

	M = M - 4;
    N = N - 4;

    Deltax = L / M; % [m] - length in x direction
    Deltay = L / N; % [m] - length in y direction

    for i = 3:M + 2
        for j = 3:N + 2

            % Compute the Courant numbers
            CwP = 0.5 * (u(i - 1, j) + abs(u(i - 1, j))) * DeltaT / Deltax;
            CwM = 0.5 * (u(i - 1, j) - abs(u(i - 1, j))) * DeltaT / Deltax;
            CeP = 0.5 * (u(i, j) + abs(u(i, j))) * DeltaT / Deltax;
            CeM = 0.5 * (u(i, j) - abs(u(i, j))) * DeltaT / Deltax;
            CsP = 0.5 * (v(i, j - 1) + abs(v(i, j - 1))) * DeltaT / Deltay;
            CsM = 0.5 * (v(i, j - 1) - abs(v(i, j - 1))) * DeltaT / Deltay;
            CnP = 0.5 * (v(i, j) + abs(v(i, j))) * DeltaT / Deltay;
            CnM = 0.5 * (v(i, j) - abs(v(i, j))) * DeltaT / Deltay;

            % Compute the values of rXP, rXM, rYP and rYM
            rxPprev = r_Plus(h(i-2,j), h(i-1,j), h(i,j));
            rxMprev = r_Minus(h(i-1,j), h(i,j), h(i+1,j));
            rxP = r_Plus(h(i-1,j), h(i,j), h(i+1,j));
            rxM = r_Minus(h(i,j), h(i+1,j), h(i+2,j));
            ryPprev = r_Plus(h(i,j-2), h(i,j-1), h(i,j));
            ryMprev = r_Minus(h(i,j-1), h(i,j), h(i,j+1));
            ryP = r_Plus(h(i,j-1), h(i,j), h(i,j+1));
            ryM = r_Minus(h(i,j), h(i,j+1), h(i,j+2));

            % Compute the values of the components of Bw, Be, Bs and Bn
            UwP = U_Plus(h(i-1,j),h(i,j),rxPprev,CwP);
            UwM = U_Minus(h(i-1,j),h(i,j),rxMprev,CwM);
            UeP = U_Plus(h(i,j),h(i+1,j),rxP,CeP);
            UeM = U_Minus(h(i,j),h(i+1,j),rxM,CeM);
            UsP = U_Plus(h(i,j-1),h(i,j),ryPprev,CsP);
            UsM = U_Minus(h(i,j-1),h(i,j),ryMprev,CsM);
            UnP = U_Plus(h(i,j),h(i,j+1),ryP,CnP);
            UnM = U_Minus(h(i,j),h(i,j+1),ryM,CnM);

            % Set result
            DeltaH(i, j) = CwP * UwP + CwM * UwM - CeP * UeP - CeM * UeM + CsP * UsP + CsM * UsM - CnP * UnP - CnM * UnM;

        end
    end

    end

