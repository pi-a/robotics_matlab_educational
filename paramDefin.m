function output=paramDefin
global l_1 l_2 r_1 r_2 m_1 m_2 t Ic1_zz Ic2_zz Ic1 Ic2
l_ratio = 1;
l_1 = 2 * (1 / (l_ratio + 1));  %m
l_2 = 2 * (l_ratio / (l_ratio + 1));

% r_1=0.5;
% r_2=0.5;
r_1 = l_1 / 2;
r_2 = l_2 / 2;
m_1=10;  %Kg
m_2=1;

Ic1=[1,0,0;0,1,0;0,0,1];
Ic2=[1,0,0;0,1,0;0,0,1];

output.l_1=l_1;
output.l_2=l_2;

output.r_1=r_1;
output.r_2=r_2;

output.m_1=m_1;
output.m_2=m_2;

output.Ic1=Ic1;
output.Ic2=Ic2;

end