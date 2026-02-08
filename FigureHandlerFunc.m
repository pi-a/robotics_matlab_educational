function [lHandle, num_columns, fig] = FigureHandlerFunc(fig)
figure(fig);
TextArr={'Joint values','Joint velocity','Joint acceleration'};
TextLabel={'in degree','degree/sec','degree/sec^2'};
font_size = 15;
num_columns = 3;
for i=1:2
    subplot(2, num_columns, num_columns*(1-1)+i)
    box on;
    title(TextArr(i),'FontSize',font_size);
    ylabel(TextLabel(i),'FontSize',font_size);
    lHandle(i) = line(nan, nan); %# Generate a blank line and return the line handle
    lHandle(2+i) = line(nan, nan);
    set(gca,'FontSize',10,'fontWeight','bold');

end
i = 3;
subplot(2, num_columns, num_columns*(1-1)+i)
box on;
title('Vx/Vy (red and blue)','FontSize',font_size);
ylabel('m/s','FontSize',font_size);
lHandle(5) = line(nan, nan);
lHandle(6) = line(nan, nan);
set(gca,'FontSize',10,'fontWeight','bold');


subplot(2, num_columns, num_columns + 1)
box on;
title('Torques','FontSize',font_size);
ylabel('N.m','FontSize',font_size);
set(gca,'FontSize',10,'fontWeight','bold');

lHandle(7)=line(nan,nan);
lHandle(8)=line(nan,nan);

subplot(2, num_columns, num_columns + 2)
box on;
title('Arm Position & EndEffector','FontSize',font_size);
axis equal;
xlim([-3 3]);
ylim([-3 3]);
set(gca,'FontSize',10,'fontWeight','bold');

subplot(2, num_columns, num_columns + 3)
box on;
title('Forces','FontSize',font_size);
axis equal;
xlim([-3 3]);
ylim([-3 3]);
set(gca,'FontSize',10,'fontWeight','bold');

end
