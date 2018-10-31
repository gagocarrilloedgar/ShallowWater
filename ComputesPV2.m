function PV2 = ComputesPV2(u,v,L)
    [M, N] = size(v);

    PV2 = zeros(M, N);
	M = M - 4;
    N = N - 4;

    % ength increments
	Deltax = L / M;
    Deltay = L / N;

    for i = 3:M + 2
        for j = 3:N + 2

            PV2(i, j) = v(i, j) * ( ( u(i, j) + u(i, j + 1) ) / 2 - ( u(i - 1, j) + u(i - 1, j + 1) ) / 2 ) / Deltax + v(i, j) * ( v(i, j + 1) - v(i, j - 1) ) / ( 2 * Deltay );

        end
    end

end