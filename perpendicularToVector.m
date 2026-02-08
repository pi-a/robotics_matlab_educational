function [armXY,Fxy_component]=perpendicularToVector(q,tau)

[XY_2,XY_1]=forwKin(q);
armX = [0, XY_1(1), XY_2(1)];
armY = [0, XY_1(2), XY_2(2)];
armXY=[armX;armY];
% coeffs_1 = polyfit([armX(1), armX(2)], [armY(1), armY(2)], 1);
% coeffs_2 = polyfit([armX(2), armX(3)], [armY(2), armY(3)], 1);
% perpendic_slope_1= -1/coeffs_1(1);
for ii=1:length(tau)
    
    Fxy_component_temp(:,ii)=((armXY(:,ii+1)-armXY(:,ii))/norm(armXY(:,ii+1)-armXY(:,ii)));
    Fxy_component(:,ii)=[Fxy_component_temp(2,ii);-Fxy_component_temp(1,ii)]*tau(ii);
end

end
