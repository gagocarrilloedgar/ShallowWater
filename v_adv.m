function Deltav_adv = adv_v(u, v, L, DeltaT)

    % Compute the values of the different parts
    Pv1 = ComputesPV1(u, v, L, DeltaT);
    Pv2 = ComputesPV2(u, v, L) * DeltaT;

    % Sum
    Deltav_adv = Pv1 + Pv2;

end