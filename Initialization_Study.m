
%M = 20; % Number of points in x direction
%N = 20; % Number of points in y direction
M_halo = M + 4; %
N_halo= N + 4; 
t0 = 0; % Starting time
DeltaT = 1e-4; % [s]
T = 10; % [s] the time integration last;
T_steps=3; % time integration steps
D = 0.1; % [m] - Depth of the fluid layer
L = 1; % [m] - Length of the sides
g = 9.81;
Omega = 2*pi/24/3600; % [rad/s] - Angular velocity
varphi = deg2rad(45); % [rad] - Latitude
f = 2 * Omega * sin(varphi); % [rad/s] - Coriolis parameter
alpha=0.5;

Deltax = L/M;
Deltay = L/N;

% Initialize geometrical parameters
eta_save = zeros(M_halo,N_halo,T);
eta_P1 = zeros(M_halo,N_halo);
eta_Time = zeros(M_halo,N_halo,T_steps);

% U time integration variables
u_save = zeros(M_halo,N_halo,T);
ut_adv = zeros(M_halo,N_halo);
ut_press = zeros(M_halo,N_halo);
u_Time = zeros(M_halo,N_halo, T_steps);

% V time integration variables
v_save = zeros(M_halo,N_halo,T);
vt_adv = zeros(M_halo,N_halo);
vt_press = zeros(M_halo,N_halo);
v_Time = zeros(M_halo,N_halo, T_steps);

%Initial Conditions
[u_t,v_t,eta_t,h]=CreateInitialVectors(M_halo,N_halo);

