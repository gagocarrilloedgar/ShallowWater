% du/dt+d(uu)/dx+d(uv)/dy = u*(du/dx+dv/dy)-g*dh/dx+fu
% dv/dt+d(vu)/dx+d(vv)/dy = v*(du/dx+dv/dy)-g*dh/dy+fv
% dh/dt+d(hu)/dx+d(hv)/dy = fh

% Define symbolic variables
syms x y t;

% Initialize symbolic fields with arbitrary periodic functions
us = sin(2 * pi * x / L) * cos(2 * pi * y / L) * t;
vs = sin(2 * pi * x / L) * sin(2 * pi * y / L) * t;
hs = cos(2 * pi * x / L) * cos(2 * pi * y / L) * t + D;

f_us = matlabFunction(us, 'Vars', [x y t]);
f_vs = matlabFunction(vs, 'Vars', [x y t]);
f_hs = matlabFunction(hs, 'Vars', [x y t]);

fpx_s = g * diff(hs, x);
fpy_s = g * diff(hs, y);

f_fpx_s = matlabFunction(fpx_s, 'Vars', [x y t]);
f_fpy_s = matlabFunction(fpy_s, 'Vars', [x y t]);

% fu_s = simplify(diff(u_s, t) + diff(u_s*u_s, x) + diff(u_s*v_s, y) - u_s*(diff(u_s, x) + diff(v_s, y)));
% fv_s = simplify(diff(v_s, t) + diff(v_s*u_s, x) + diff(v_s*v_s, y) - v_s*(diff(u_s, x) + diff(v_s, y)));
% fh_s = simplify(diff(h_s, t) + diff(h_s*u_s, x) + diff(h_s*v_s, y));

fu_s = simplify(diff(us, t) + us * diff(us, x) + vs * diff(us, y));
fv_s = simplify(diff(vs, t) + us * diff(vs, x) + vs * diff(vs, y));
fh_s = simplify(diff(hs, t) + diff(hs*us, x) + diff(hs*vs, y));

f_fu_s = matlabFunction(fu_s, 'Vars', [x y t]);
f_fv_s = matlabFunction(fv_s, 'Vars', [x y t]);
f_fh_s = matlabFunction(fh_s, 'Vars', [x y t]);

fpx = f_fpx_s;
fpy = f_fpy_s;
fu = f_fu_s;
fv = f_fv_s;
fh = f_fh_s;

mesh = CreateStaggeredMesh(M, N, L);

% Init matrices
Deltau_f = zeros(M+4,N+4);
Deltav_f = zeros(M+4,N+4);
Deltaeta_f = zeros(M+4,N+4);

for j = 1:N + 4
    for  i = 1:M + 4

        u_t(i, j) = f_us(mesh.sx(i), mesh.cy(j), t0);
        v_t(i, j) = f_vs(mesh.cx(i), mesh.sy(j), t0);
        eta_t(i, j) = f_hs(mesh.cx(i), mesh.cy(j), t0) - D + h(i,j);

    end
end

u_t = HaloUpdate(u_t);
v_t = HaloUpdate(v_t);
eta_t = HaloUpdate(eta_t);