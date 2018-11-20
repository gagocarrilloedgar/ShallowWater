function  [u, v ] = CreateVelocities(M,N)

 u = zeros(M + 4, N + 4);
    v = zeros(M + 4, N + 4);

    % Ensure periodicity on the domain
    u = haloUpdate(u);
    v = haloUpdate(v);

end