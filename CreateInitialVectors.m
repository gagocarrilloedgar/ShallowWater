function [u,v,eta,h] = CreateInitialVectors(M,N)

% Velocities 
u=ones(M,N);
v=zeros(M,N);

%Update the matrix
u = HaloUpdate(u);
v = HaloUpdate(v);

% Surface 
eta=zeros(M,N);
h = zeros(M,N);

%función gausiana para simular una gota
eta(8+2, 8+2) = 5;

%Update the matrix
eta=HaloUpdate(eta);
h = HaloUpdate(h);
end