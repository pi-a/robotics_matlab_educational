function output=find_amplitude(type)
syms x t a t_0

types={'polynomial2order','ramp','triangle','other2','other3'};
methodIndex = find(strcmp(type,types));

if (methodIndex==1)
    area_V=int(-a*(x^2-t*x),x,0,t);
    output=area_V/a;
elseif (methodIndex==2)
    
elseif (methodIndex==3)
    area_V=int((a*2/t)*x,x,0,t/2)+int((-a*2/t)*(x-t/2)+a,x,t/2,t);
    output=area_V/a;
end

end