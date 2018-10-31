function  MAP = HaloUpdate(MAP)

%Mesh size
[M,N] = size(MAP);

M = M - 4;
N = N - 4;

% Ensure that the variable is periodic throughout the domain
MAP(1, :) = MAP(M + 1, :);
MAP(2, :) = MAP(M + 2, :);
MAP(M + 3, :) = MAP(3, :);
MAP(M + 4, :) = MAP(4, :);
MAP(:, 1) = MAP(:, N + 1);
MAP(:, 2) = MAP(:, N + 2);
MAP(:, N + 3) = MAP(:, 3);
MAP(:, N + 4) = MAP(:, 4);

end
