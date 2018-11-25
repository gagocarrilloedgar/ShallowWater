function Delta_f = addSource(function_s, xcoords, ycoords, DeltaT, t)

    % Get matrix size
    [~, M] = size(xcoords);
    [~, N] = size(ycoords);

    % Initialize output array
    Delta_f = zeros(M, N);

    % Ensure notation consistency between files
	M = M - 4;
    N = N - 4;

    for j = 1:N + 4
        for  i = 1:M + 4
            Delta_f(i, j) = function_s(xcoords(i), ycoords(j), t) * DeltaT;
        end
    end
end
