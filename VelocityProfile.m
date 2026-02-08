function [Vxy]=VelocityProfile(XY,t,steps,type)

types={'polynomial2order','ramp','triangle','circle','other1','other2'};

time = (0:(t-0)/(steps-1):t);

% impulse = time==0;
% unitstep = time>=0;
% ramp = time.*unitstep;
% quad = time.^2.*unitstep;

methodIndex = find(strcmp(type,types));


if (methodIndex==1)
    a_pol_coeff=(XY(:,2)-XY(:,1))/((t)^3/6);
    Vxy=-a_pol_coeff*(time.^2-t*time);
elseif (methodIndex==2)
    k=(1/100)*t;
    a_ramp_coeff=(XY(:,2)-XY(:,1))/(t-k);
    temp_zero=zeros(size(time));
    temp_ones=ones(size(time));
    Vxy=(a_ramp_coeff/k)*([time(time<=k),temp_zero(time>k)])+...
        a_ramp_coeff*([temp_zero(time<=k),temp_ones(time>k & time<=t-k),temp_zero(time>t-k)])+...
        (-a_ramp_coeff/k)*([temp_zero(time<=t-k),time(time>t-k)]-(t-k)*([temp_zero(time<=t-k),temp_ones(time>t-k)]))+...
        a_ramp_coeff*[temp_zero(time<=t-k),temp_ones(time>t-k)];
    
    
elseif (methodIndex==3)
    a_tria_coeff=2*(XY(:,2)-XY(:,1))/(t);
    temp_zero=zeros(size(time));
    temp_ones=ones(size(time));
    Vxy=(2*a_tria_coeff/t)*([time(time<=t/2),temp_zero(time>t/2)])+...
        (-2*a_tria_coeff/t)*([temp_zero(time<=t/2),time(time>t/2)]-(t/2)*([temp_zero(time<=t/2),temp_ones(time>t/2)]))+...
        a_tria_coeff*[temp_zero(time<=t/2),temp_ones(time>t/2)];
elseif (methodIndex==4)
    a_circle_coeff=(XY(:,2)-XY(:,1))/(pi*(t^2)/8);
    Vxy=a_circle_coeff*sqrt(abs((time.^2-t*time)));
elseif (methodIndex==5)
else
end



end