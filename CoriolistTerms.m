function [u_cor,v_cor] = CoriolistTerms(alpha,f,dt,u_n,v_n,u_s,v_s)

k=( alpha * f * dt );

% Get matrix size
[M_halo, N_halo] = size(u_n);

u_cor = zeros(M_halo,N_halo);
v_cor = zeros(M_halo,N_halo);

M = M_halo - 4;
N = N_halo - 4;

for i = 3:M + 2
    for j = 3:N + 2
        
        v_cor(i, j) = ( v_s(i, j) -(k^2) * v_n(i, j) - 2 * k * 0.25 * ( u_n(i, j) + u_n(i + 1, j) + u_n(i, j - 1) + u_n(i + 1, j - 1) ) ) / ( 1 + k^2 );
        u_cor(i, j) = ( u_s(i, j) - (k^2) * u_n(i, j) + 2 *k* 0.25 * ( v_n(i, j) + v_n(i + 1, j) + v_n(i, j - 1) + v_n(i + 1, j - 1) ) ) / ( 1 + k^2 );

    end
end

end