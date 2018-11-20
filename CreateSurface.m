function H = CreateSurface(M,N)

H = zeros(M+4,N+4);

%Ensures periodicity on the domain

H = HaloUpdate(H);

end