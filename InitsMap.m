M = 20; % Number of points in x direction
N = 20; % Number of points in y direction
M_halo = M + 4; %
N_halo= N + 4; 
t0 = 0; % Starting time
DeltaT = 1e-4; % [s]
T = 1000; % [s] the time integration last;
T_steps=3; % time integration steps
D = 0.1; % [m] - Depth of the fluid layer
L = 1; % [m] - Length of the sides
g = 9.81;
Omega = 2*pi/24/3600; % [rad/s] - Angular velocity
varphi = deg2rad(45); % [rad] - Latitude
f = 2 * Omega * sin(varphi); % [rad/s] - Coriolis parameter
alpha=0.5;

% Get colormaps
custom_colormaps;