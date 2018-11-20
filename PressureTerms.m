function [p_u,p_v] = PressureTerms(eta, g, L, DeltaT)

% Get matrix size
[M, N] = size(eta);

p_u = zeros(M, N);
p_v = zeros(M, N);

M = M - 4;
N = N - 4;

Deltax = L /M;
Deltay = L /N;

for i = 3:M + 2
    for j = 3:N + 2
        
        % Set result
        p_u(i, j) = -g * DeltaT * ( eta(i + 1, j) - eta(i, j) ) / Deltax;
        p_v(i, j) = -g * DeltaT * ( eta(i, j + 1) - eta(i, j) ) / Deltay;
        
    end
end

end