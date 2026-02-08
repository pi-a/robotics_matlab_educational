function [XY_2,XY_1]=forwKin(q)
global l_1 l_2
% l_1 = 1;
% l_2 = 1;

XY_2 = [l_1*cos(q(1))+l_2*cos(q(1)+q(2));...
    l_1*sin(q(1))+l_2*sin(q(1)+q(2))];

XY_1 = [l_1*cos(q(1));...
    l_1*sin(q(1))];

end