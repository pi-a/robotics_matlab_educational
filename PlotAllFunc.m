function PlotAllFunc(input_vec)

lHandle = input_vec.lHandle;
num_columns = input_vec.num_columns;
fig = input_vec.fig;
steps = input_vec.steps;
q = input_vec.q;
q_dot = input_vec.q_dot;
XY_2 = input_vec.XY_2;
derived_Vxy = input_vec.derived_Vxy;
XarmX_all = input_vec.XarmX_all;
YarmY_all = input_vec.YarmY_all;
armX_plot = input_vec.armX_plot;
armY_plot = input_vec.armY_plot;
X_link1 = input_vec.X_link1;
X_link2 = input_vec.X_link2;
Y_link1 = input_vec.Y_link1;
Y_link2 = input_vec.Y_link2;
Fx_link1 = input_vec.Fx_link1;
Fx_link2 = input_vec.Fx_link2;
Fy_link1 = input_vec.Fy_link1;
Fy_link2 = input_vec.Fy_link2;

color_str={'red','blue', 'green'};
color_vec = {[0.6350, 0.0780, 0.1840], [0, 0.4470, 0.7410], [0.4660, 0.6740, 0.1880], [0.4940, 0.1840, 0.5560], [0.3010, 0.7450, 0.9330]};


for count = 1:1
    set(0,'CurrentFigure',fig);
    for stepNum=1:steps
        
        jj=1;
        for ii=1:2
            %         subplot(3,2,2*(jj-1)+1)
            figure(fig.Number);
            subplot(2, num_columns, 1)
            tt = get(lHandle(2*(jj-1)+1), 'XData');
            qq = get(lHandle(2*(jj-1)+1), 'YData');
            
            tt = [tt stepNum];
            qq = [qq q(ii,stepNum)*180/pi];
            
            set(lHandle(2*(jj-1)+1),'Color',color_vec{jj},'LineWidth',3);
            set(lHandle(2*(jj-1)+1), 'XData', tt, 'YData', qq);
            
            %         subplot(3,2,2*(jj-1)+1)
            figure(fig.Number);
            subplot(2, num_columns, 1 + 1)
            
            TT = get(lHandle(2*jj), 'XData');
            qqdot = get(lHandle(2*jj), 'YData');
            
            TT = [TT stepNum];
            qqdot = [qqdot q_dot(ii,stepNum)*180/pi];
            set(lHandle(2*jj),'Color',color_vec{jj},'LineWidth',3);
            set(lHandle(2*jj), 'XData', TT, 'YData', qqdot);
            jj=jj+1;
            
        end
        
        figure(fig.Number);
        subplot(2, num_columns, 2 + 1)
        ttVxx = get(lHandle(5), 'XData');
        Vxx = get(lHandle(5), 'YData');
        
        ttVxx = [ttVxx stepNum];
        Vxx = [Vxx derived_Vxy(1, stepNum)];
        
        set(lHandle(5),'Color',color_vec{1},'LineWidth',3);
        set(lHandle(5), 'XData', ttVxx, 'YData', Vxx);
        
        
        ttVyy = get(lHandle(6), 'XData');
        Vyy = get(lHandle(6), 'YData');
        
        ttVyy = [ttVyy stepNum];
        Vyy = [Vyy derived_Vxy(2, stepNum)];
        
        set(lHandle(6),'Color',color_vec{2},'LineWidth',3);
        set(lHandle(6), 'XData', ttVyy, 'YData', Vyy);
        %%
        figure(fig.Number);
        subplot(2, num_columns, num_columns + 1)
        if (stepNum > 1)
            xF1 = get(lHandle(7), 'XData');
            yF1 = get(lHandle(7), 'YData');
            
            xF1 = [xF1 Fx_link1(stepNum-1)];
            yF1 = [yF1 Fy_link1(stepNum-1)];
            
            set(lHandle(7),'Color',color_vec{1},'LineWidth',3);
            set(lHandle(7), 'XData', xF1, 'YData', yF1);
            
            
            xF2 = get(lHandle(8), 'XData');
            yF2 = get(lHandle(8), 'YData');
            
            xF2 = [xF2 Fx_link2(stepNum-1)];
            yF2 = [yF2 Fy_link2(stepNum-1)];
            
            set(lHandle(8),'Color',color_vec{2},'LineWidth',3);
            set(lHandle(8), 'XData', xF2, 'YData', yF2);
        end
        %%
        figure(fig.Number);
        subplot(2, num_columns, num_columns + 2)
        plot(XarmX_all(:,1:3:stepNum), YarmY_all(:,1:3:stepNum), 'Color','black', 'LineWidth', 1.5);
        hold on;
        plot(XarmX_all(3,1:stepNum), YarmY_all(3,1:stepNum), 'Color',color_vec{3}, 'LineWidth', 3);
        axis equal;
        hold off;
        box on;
        title('Arm Position & EndEffector','FontSize',15);
        set(gca,'FontSize',10,'fontWeight','bold');
        %%
        figure(fig.Number);
        subplot(2, num_columns, num_columns + 3)
        if (stepNum > 1)
            plot(armX_plot(:,stepNum-1),armY_plot(:,stepNum-1),'Color','black', 'LineWidth', 1.5);
            axis equal;
            hold on;
            plot(XarmX_all(3,1:stepNum), YarmY_all(3,1:stepNum), 'Color',color_vec{3}, 'LineWidth', 3);
            
            quiver(X_link1(stepNum-1)/2,Y_link1(stepNum-1)/2,Fx_link1(stepNum-1),Fy_link1(stepNum-1), 'LineWidth',2.0);
            quiver((X_link1(stepNum-1)+X_link2(stepNum-1))/2,(Y_link1(stepNum-1)+Y_link2(stepNum-1))/2,Fx_link2(stepNum-1),Fy_link2(stepNum-1), 'LineWidth',2.0);
            
            axis equal;
            xlim([-3 3]);
            ylim([-3 3]);
            hold off;
            title('Forces','FontSize',15);
            set(gca,'FontSize',10,'fontWeight','bold');
        end
        %     drawnow;
        %%
        pause(.0000001);
    end
    
    for i=1:2
        figure(fig.Number);
        subplot(2, num_columns, num_columns*(1-1)+i)
        legend(lHandle([i, 2+i]), {'\theta_{1}', '\theta_{2}'}, 'Location','northwest');
    end
    figure(fig.Number);
    subplot(2, num_columns, num_columns*(1-1)+3)
    legend(lHandle([5, 6]), {'V_{x}', 'V_{y}'}, 'Location','northwest');
    figure(fig.Number);
    subplot(2, num_columns, num_columns + 1)
    legend(lHandle([7, 8]), {'\tau_{1}', '\tau_{2}'}, 'Location','northwest');
    
    pause(1);
    %     for i=1:2
    %         figure(fig.Number);
    %         subplot(2, num_columns, num_columns*(1-1)+i)
    %         delete(findobj('type','legend'));
    %     end
    %     figure(fig.Number);
    %     subplot(2, num_columns, num_columns*(1-1)+3)
    %     delete(findobj('type','legend'));
    %     for i = 1:length(lHandle)
    %         delete(lHandle(i));
    %     end
    %     for i = 1:2*num_columns
    %         subplot(2, num_columns, i)
    % %         cla(get(gca, 'parent'),'type','axes');
    %         delete(gca);
    %     end
    %     clf(fig);
    %     [lHandle, num_columns, fig] = FigureHandlerFunc(fig);
end
end
