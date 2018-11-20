function eta = addDroplets(eta, number_of_drops, t, t_period, t_offset, t_start, t_end)

    % Get matrix size
    [M, N] = size(eta);

    % Initialize droplet matrix
    droplets = zeros(M, N);

    % Ensure notation consistency between files
    M = M - 4;
    N = N - 4;

    if t_start<= t <= t_end

        % Store the new perturbation in a random place
        droplets(randperm(M*N, number_of_drops) + 2 * ( M + 4 ) + 2) = (mod(t, t_period) == mod(t_offset, t_period)) * randi([0, 10], 1, number_of_drops);

    end

    % Set result
    eta = eta + droplets;

end