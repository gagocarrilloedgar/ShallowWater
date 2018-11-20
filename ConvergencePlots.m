%% Advective terms
%P2
%Creating the plots
figure;
loglog(1./Dim, LS_err_dv,'or');
title('Convergence of P1','Interpreter','Latex');
ylabel('Absolute Error','Interpreter','Latex');
xlabel('$\Delta$x','Interpreter','Latex');
y=(1.507e-7)*(1./Dim).^(3.2);
%loglog(1./Dim,y,'g');

%P2
%Creating the plots
figure;
loglog(1./Dim, LS_err_dv,'or');
hold on;
title('Convergence of P2 with Ls fitting','Interpreter','Latex');
ylabel('Absolute Error','Interpreter','Latex');
xlabel('$\Delta$x','Interpreter','Latex');
y=745*(1./Dim).^(4.052);
%loglog(1./Dim,y,'g');

%% Mass
figure;
loglog(1./Dim, LS_err_dh, 'or');
hold on
y=(0.02869)*(1./Dim).^(4.082);
%loglog(1./Dim,y,'g');
title('Convergence of h','Interpreter','Latex');
ylabel('Absolute Error','Interpreter','Latex');
xlabel('$\Delta$x','Interpreter','Latex');