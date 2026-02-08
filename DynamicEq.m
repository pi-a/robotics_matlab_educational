function [tau,M,B,C,theta,d_theta,d2_theta]=DynamicEq()
%% MY CALCULATION
syms l_1 l_2 r_1 r_2 m_1 m_2 t Ic1_zz Ic2_zz theta1 theta2 d_theta1 d_theta2 d2_theta1 d2_theta2%Ixx Ixy Ixz Iyx Iyy Iyz Izx Izy Izz theta_1 theta_2

Ic1=sym('Ic1',[3,3]);
Ic2=sym('Ic2',[3,3]);
% theta1=sym('theta1(t)');%,[2,1]);
% theta2=sym('theta2(t)');
theta=[theta1;theta2];
% d_theta=diff(theta,t);
% d2_theta=diff(theta,t,2);\
d_theta=[d_theta1;d_theta2];
d2_theta=[d2_theta1;d_theta2];
%%
A1=[cos(theta(1)) -sin(theta(1)) 0 l_1*cos(theta(1));...
    sin(theta(1)) cos(theta(1)) 0 l_1*sin(theta(1));...
    0 0 1 0;...
    0 0 0 1];
A2=[cos(theta(2)) -sin(theta(2)) 0 l_2*cos(theta(2));...
    sin(theta(2)) cos(theta(2)) 0 l_2*sin(theta(2));...
    0 0 1 0;...
    0 0 0 1];

A=A1*A2;
A=simplify(A);
%%
% J_w_i=[rho_1*z_0 rho_2*z_1 rho_i*z_i-1 0..0];

% J_w_1=[rho_1*z_0 0];
% J_w_2=[rho_1*z_0 rho_2*z_1];
% rho_1=rho_2=1;
% z_0=[0;0;1];
% z_1=[0;0;1];

J_w_1=[0 0; 0 0; 1 0];
J_w_2=[0 0; 0 0; 1 1];
%%
%{
% only if the center of mass was at joint:
p_c_1=A1(1:3,4);
p_c_2=A(1:3,4);


% J_v_i=[d(p_c_i)/d(theta_1) .. d(p_c_i)/d(theta_i) 0];
% J_v_1=zeros(3,2);
J_v_1(1:3,1)=diff2(p_c_1,theta(1));
% J_v_1(1:3,1)=diff2(p_c_1,theta1);
J_v_1(1:3,2)=[0;0;0];
% J_v_2=zeros(3,2);
J_v_2(1:3,1)=diff2(p_c_2,theta(1));
% J_v_2(1:3,1)=diff2(p_c_2,theta1);
J_v_2(1:3,2)=diff2(p_c_2,theta(2));
% J_v_2(1:3,2)=diff2(p_c_2,theta2);
J_v_2=simplify(J_v_2);
%}
%%
J_v_1=[-r_1*sin(theta(1)) 0;...
    r_1*cos(theta(1)) 0;...
    0 0];
J_v_2=[-l_1*sin(theta(1))-r_2*sin(theta(1)+theta(2)) -r_2*sin(theta(1)+theta(2));...
    l_1*cos(theta(1))+r_2*cos(theta(1)+theta(2)) r_2*cos(theta(1)+theta(2));...
    0 0];
%%
% I_c(1)=[Ixx(1) -Ixy(1) -Ixz(1);...
%     -Iyx(1) Iyy(1) -Iyz(1);...
%     -Izx(1) -Izy(1) Izz(1)];
% 
% I_c(2)=[Ixx(2) -Ixy(2) -Ixz(2);...
%     -Iyx(2) Iyy(2) -Iyz(2);...
%     -Izx(2) -Izy(2) Izz(2)];
M=m_1*transpose(J_v_1)*J_v_1+transpose(J_w_1)*Ic1*J_w_1+...
    m_2*transpose(J_v_2)*J_v_2+transpose(J_w_2)*Ic2*J_w_2;

M=simplify(M);
% M=subs(M,{Ic1(3,3),Ic2(3,3)},{Ic1_zz,Ic2_zz});
%%
for i=1:2
    for j=1:2
        for k=1:2
            b(i,j,k)=(1/2)*(diff2(M(i,j),theta(k))+diff2(M(i,k),theta(j))-diff2(M(j,k),theta(i)));
        end
    end
end

C=[b(1,1,1) b(1,2,2);...
    b(2,1,1) b(2,2,2)];
B=2*[b(1,1,2);b(2,1,2)];
%%
V=C*(d_theta)+B*(d_theta(1)*d_theta(2));
V=simplify(V);
%%
tau=M*d2_theta+V;
tau=simplify(tau);
%%
output=paramDefin;

% M=subs(M,{l_1, l_2},...
%     {output.l_1, output.l_2});
% C=subs(C,{l_1, l_2},...
%     {output.l_1, output.l_2});
% B=subs(B,{l_1, l_2},...
%     {output.l_1, output.l_2});
% tau=subs(tau,{l_1, l_2},...
%     {output.l_1, output.l_2});

M=subs(M,{l_1, l_2, r_1, r_2, m_1, m_2},...
    {output.l_1, output.l_2, output.r_1, output.r_2, output.m_1, output.m_2});
M=subs(M, Ic1, output.Ic1);
M=subs(M, Ic2, output.Ic2);

C=subs(C,{l_1, l_2, r_1, r_2, m_1, m_2},...
    {output.l_1, output.l_2, output.r_1, output.r_2, output.m_1, output.m_2});
C=subs(C, Ic1, output.Ic1);
C=subs(C, Ic2, output.Ic2);

B=subs(B,{l_1, l_2, r_1, r_2, m_1, m_2},...
    {output.l_1, output.l_2, output.r_1, output.r_2, output.m_1, output.m_2});
B=subs(B, Ic1, output.Ic1);
B=subs(B, Ic2, output.Ic2);

tau=subs(tau,{l_1, l_2, r_1, r_2, m_1, m_2},...
    {output.l_1, output.l_2, output.r_1, output.r_2, output.m_1, output.m_2});
tau=subs(tau, Ic1, output.Ic1);
tau=subs(tau, Ic2, output.Ic2);


% C=subs(C,{l_1, l_2, r_1, r_2, m_1, m_2, Ic1, Ic2},...
%     {output.l_1, output.l_2, output.r_1, output.r_2, output.m_1, output.m_2, output.Ic1, output.Ic2});
% B=subs(B,{l_1, l_2, r_1, r_2, m_1, m_2, Ic1, Ic2},...
%     {output.l_1, output.l_2, output.r_1, output.r_2, output.m_1, output.m_2, output.Ic1, output.Ic2});
% tau=subs(tau,{l_1, l_2, r_1, r_2, m_1, m_2, Ic1, Ic2},...
%     {output.l_1, output.l_2, output.r_1, output.r_2, output.m_1, output.m_2, output.Ic1, output.Ic2});

% %%
% subs(tau,diff(theta1(t), t, t),d2theta1);
% subs(tau,diff(theta2(t), t, t),d2theta2);