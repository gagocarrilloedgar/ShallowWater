function eta = CreateSurfacePerturbation(M,N)

    eta = zeros(M + 4, N + 4);
    eta(4+2, 4+2) = 10;
    % eta = rand(M + 4, N + 4); % Randomize values from 0 to 1 according to a uniform distribution

    eta = haloUpdate(eta);

end