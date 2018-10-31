function Deltau_adv = u_adv(u,v,L,DeltaT)

% Compute the values of the different parts
    Pu1 = ComputesPU1(u, v, L, DeltaT);
    Pu2 = ComputesPU2(u, v, L) * DeltaT;

    % Sum
    Deltau_adv = Pu1 + Pu2;

end