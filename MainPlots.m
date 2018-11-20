% %% Creating the gif
% 
% h=surf(eta_save(:,:,1));
% shading interp
% axis([0 N 0 M 0 10]);
% 
% camlight
% set(gca,'color','k')
% set(gcf,'color','k')
% 
% gif('test.gif')
% gif('test.gif','DelayTime',0.1,'LoopCount',5,'frame',gcf)
% 
% for k = 2:T
%    set(h,'Zdata',eta_save(:,:,k)); 
%    gif
% end

% %% Create gif
% 
% h = figure;
% axis tight manual % this ensures that getframe() returns a consistent size
% filename = 'testSW.gif';
% for n = 1:1:T
%     % Draw plot for y = x.^n
%     s=surf(eta_save(:,:,n));
%     s.EdgeColor = 'none';
%     grid off;
%     title('$\eta(t)$','Interpreter','Latex');
%     ylabel('y','Interpreter','Latex');
%     xlabel('x','Interpreter','Latex');
%     zlabel('$\eta$','Interpreter','Latex');
%     axis([0 N 0 M 0 7]);
%     drawnow
%     % Capture the plot as an image
%     frame = getframe(h);
%     im = frame2im(frame);
%     [imind,cm] = rgb2ind(im,256);
%     % Write to the GIF File
%     if n == 1
%         imwrite(imind,cm,filename,'gif', 'Loopcount',inf, 'DelayTime', 0);
%     else
%         imwrite(imind,cm,filename,'gif','WriteMode','append', 'DelayTime', 0);
%     end
% end


figure;
surf(eta_save(:,:,1));
axis([0 N 0 M 0 7]);
title('$\eta(t=0)$','Interpreter','Latex');
ylabel('y','Interpreter','Latex');
xlabel('x','Interpreter','Latex');
zlabel('$\eta$','Interpreter','Latex');



figure;
surf(eta_save(:,:,200));
axis([0 N 0 M 0 7]);
title('$\eta(t=500)$','Interpreter','Latex');
ylabel('y','Interpreter','Latex');
xlabel('x','Interpreter','Latex');
zlabel('$\eta$','Interpreter','Latex');
axis([0 N 0 M 0 7]);

