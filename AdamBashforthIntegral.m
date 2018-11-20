function DeltaU = AdamBashforthIntegral(Deltau_t, Deltau_t1, Deltau_t2, t)
    % The first two cases we cant apply adam bashforth beause we don't have
    % n-1 and n-2, 
    if t < 2
        DeltaU = Deltau_t;
    elseif t < 3
        DeltaU =  3 / 2 * Deltau_t - 1 / 2 * Deltau_t1;
    else
        DeltaU =  23 / 12 * Deltau_t - 4 / 3 * Deltau_t1 + 5 / 12 * Deltau_t2;
    end
end