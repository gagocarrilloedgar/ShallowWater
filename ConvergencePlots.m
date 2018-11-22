%% Advective terms
%P2
%Creating the plots
figure;
loglog(1./Dim, LS_err_dv_P2,'o',1./Dim, LS_err_du_P2,'r');
title('Convergence of P2','Interpreter','Latex');
ylabel('Absolute Error','Interpreter','Latex');
xlabel('$\Delta$x','Interpreter','Latex');

%P1
%Creating the plots
figure;
loglog(1./Dim, LS_err_dv_P1,'or');
y=0.0003*(1./Dim).^(1.1643);
hold on;
loglog(1./Dim,y,'--r');
title('Convergence of P1 with LS fitting','Interpreter','Latex');
ylabel('Absolute Error','Interpreter','Latex');
xlabel('$\Delta$x','Interpreter','Latex');


%% Mass
figure;
loglog(1./Dim, LS_err_dh, 'or');
yh=0.1832*(1./Dim).^(1.977);
hold on;
loglog(1./Dim,yh,'--r');
title('Convergence of h','Interpreter','Latex');
ylabel('Absolute Error','Interpreter','Latex');
xlabel('$\Delta$x','Interpreter','Latex');

