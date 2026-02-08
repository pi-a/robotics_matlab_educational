function [Vxy]=JacobVelocity(q,q_dot)
global l_1 l_2
% l_1 = 1;
% l_2 = 1;

J=[-l_1*sin(q(1))-l_2*sin(q(1)+q(2)), -l_2*sin(q(1)+q(2));...
    l_1*cos(q(1))+l_2*cos(q(1)+q(2)), l_2*cos(q(1)+q(2))];


Vxy=J*q_dot;

end