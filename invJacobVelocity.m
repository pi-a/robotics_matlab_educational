function q_dot=invJacobVelocity(Vxy,q)
global l_1 l_2
% l_1 = 1;
% l_2 = 1;
q_dot=[0;0];
% J=[-l_1*sin(q(1))-l_2*sin(q(1)+q(2)), -l_2*sin(q(1)+q(2));...
%     l_1*cos(q(1))+l_2*cos(q(1)+q(2)), l_2*cos(q(1)+q(2))];
V_x=Vxy(1);
V_y=Vxy(2);

if (q(2)~=0 || q(2)~=pi)
    %    q_dot=inv(J)*V_xy;
    
    q_dot(1)=(V_x*l_2*cos(q(1)+q(2))+V_y*l_2*sin(q(1)+q(2)))/(l_1*l_2*sin(q(2)));
    
    q_dot(2)=(V_x*(-l_1*cos(q(1))-l_2*cos(q(1)+q(2)))+V_y*(-l_1*sin(q(1))-l_2*sin(q(1)+q(2))))/(l_1*l_2*sin(q(2)));
    
end


end