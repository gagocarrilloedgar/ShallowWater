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
eta(4+2, 4+2) = 4;

%Update the matrix
eta=HaloUpdate(eta);
h = HaloUpdate(h);
end