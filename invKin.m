function q=invKin(X,Y)
global l_1 l_2
% l_1 = 1;
% l_2 = 1;

c2 = (X^2+Y^2-l_1^2-l_2^2)/(2*l_1*l_2);
s2 = -real(sqrt(1-c2^2));
q_2 = atan2(s2,c2);
q_1 = atan2(Y,X)-atan2(l_2*s2,l_1+l_2*c2);

q = [q_1;q_2];

end