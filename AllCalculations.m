function output_vec = AllCalculations(profiles, XYProfile_indx, VelocProfile_indx)
global l_1 l_2 r_1 r_2 m_1 m_2 Ic1_zz Ic2_zz Ic1 Ic2

[tau_sym,M_sym,B_sym,C_sym,theta,d_theta,d2_theta]=DynamicEq;

[~]=paramDefin;
%%
k = XYProfile_indx;
x_0=profiles(1,2*(k-1)+1);
x_end=profiles(1,2*(k-1)+2);
y_0=profiles(2,2*(k-1)+1);
y_end=profiles(2,2*(k-1)+2);


X=[x_0,x_end];
Y=[y_0,y_end];
XY=[X;Y];


t=10;

steps=100;

% VelocityProfiles: 'polynomial2order','ramp','triangle','circle'
V_xy=VelocityProfile(XY,t,steps, VelocProfile_indx);

time = (0:(t-0)/(steps-1):t);
dt = time(2:end) - time(1:end-1);
% V_xy=(XY(:,2)-XY(:,1))/t;
X_traj=linspace(x_0,x_end,steps);
Y_traj=linspace(y_0,y_end,steps);

XY_traj=[x_0;y_0];
for ii=2:steps
    %     if ii==1
    %         xy_temp=[x_0;y_0];
    %     else
    %         xy_temp=XY_traj(:,ii-1);
    %     end
    xy_temp=XY_traj(:,ii-1);
    XY_traj(:,ii)=xy_temp+(1/2)*(V_xy(:,ii-1) + V_xy(:, ii))*dt(ii-1);
    
end

%%
for stepNum=1:steps
    
    q(:,stepNum)=invKin(XY_traj(1,stepNum),XY_traj(2,stepNum));
    %     q(:,stepNum)=invKin(X_traj(stepNum),Y_traj(stepNum));
    q_dot(:,stepNum)=invJacobVelocity(V_xy(:,stepNum),q(:,stepNum));
end
%%
ddq = q_dot(:,2:end) - q_dot(:,1:end-1);
dt = time(2:end) - time(1:end-1);

ddQ(1,:) = ddq(1,:)./dt;
ddQ(2,:) = ddq(2,:)./dt;

q_desired=q;
qdot_desired=q_dot;
qdot2_desired=ddQ;
%%
for ii=1:length(dt)
    tau_desired(:,ii)=subs(tau_sym,theta,q_desired(:,ii));
    tau_desired(:,ii)=subs(tau_desired(:,ii),d_theta,qdot_desired(:,ii));
    tau_desired(:,ii)=subs(tau_desired(:,ii),d2_theta,qdot2_desired(:,ii));
end
%%
tau_desired=double(tau_desired);
%%
Fx_link1=[];Fx_link2=[];Fy_link1=[];Fy_link2=[];X_link1=[];X_link2=[];Y_link1=[];Y_link2=[];
Fxy=[];
linkXY=[];
for ii=1:size(tau_desired,2)
    [armXY,Fxy_component]=perpendicularToVector(q(:,ii+1),tau_desired(:,ii));
    Fx_link1=[Fx_link1,Fxy_component(1,1)];
    Fx_link2=[Fx_link2,Fxy_component(1,2)];
    
    Fy_link1=[Fy_link1,Fxy_component(2,1)];
    Fy_link2=[Fy_link2,Fxy_component(2,2)];
    
    X_link1=[X_link1,armXY(1,2)];
    X_link2=[X_link2,armXY(1,3)];
    
    Y_link1=[Y_link1,armXY(2,2)];
    Y_link2=[Y_link2,armXY(2,3)];
    
    Fxy=[Fxy,Fxy_component];
    linkXY=[linkXY,armXY(:,2:3)];
end
%%
YarmY_all=[];
XarmX_all=[];
armX_plot=[zeros(size(X_link1));X_link1;X_link2];
armY_plot=[zeros(size(Y_link1));Y_link1;Y_link2];

%% RECALCULATIONS (ONLY NEEDS TO BE DONE IF THERE IS FRICTION OR OTHER REAL WORLD PROPERTIES)
derived_Vxy = zeros(2, steps);
XY_1 = zeros(2, steps);
XY_2 = zeros(2, steps);
for stepNum=1:steps
    derived_Vxy(:, stepNum) = JacobVelocity(q(:,stepNum),q_dot(:,stepNum));
    [XY_2(:,stepNum),XY_1(:,stepNum)]=forwKin(q(:,stepNum));
    armX = [0, XY_1(1,stepNum), XY_2(1,stepNum)];
    armY = [0, XY_1(2,stepNum), XY_2(2,stepNum)];
    
    XarmX_all = [XarmX_all, armX'];
    YarmY_all = [YarmY_all, armY'];
end

output_vec.steps = steps;
output_vec.q = q;
output_vec.q_dot = q_dot;
output_vec.XY_2 = XY_2;
output_vec.derived_Vxy = derived_Vxy;
output_vec.XarmX_all = XarmX_all;
output_vec.YarmY_all = YarmY_all;
output_vec.armX_plot = armX_plot;
output_vec.armY_plot = armY_plot;
output_vec.X_link1 = X_link1;
output_vec.X_link2 = X_link2;
output_vec.Y_link1 = Y_link1;
output_vec.Y_link2 = Y_link2;
output_vec.Fx_link1 = Fx_link1;
output_vec.Fx_link2 = Fx_link2;
output_vec.Fy_link1 = Fy_link1;
output_vec.Fy_link2 = Fy_link2;

end