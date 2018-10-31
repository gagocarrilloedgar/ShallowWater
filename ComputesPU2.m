function PU2 = ComputesP2(u,v,L)

    %Mesh size
    [M, N] = size(u);

    % Deletes the extra halo cells in order to compute the matrix correctly
    PU2 = zeros(M, N);

    % Ensure notation consistency between files
	M = M - 4;
    N = N - 4;

    % Compute length increments
	Deltax = L / M; % [m] - length in x direction
    Deltay = L / N; % [m] - length in y direction

    % Compute for the domain
    for i = 3:M + 2
        for j = 3:N + 2

            % Set result
            PU2(i, j) = u(i, j) * ( u(i + 1, j) - u(i - 1, j) ) / ( 2 * Deltax ) + u(i, j) * ( ( v(i, j) + v(i + 1, j) ) / 2 - ( v(i, j - 1) + v(i + 1, j - 1) ) / 2 ) / Deltay;

        end
    end

end