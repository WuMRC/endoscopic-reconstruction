function [cylX_mod, cylY_mod, cylZ_mod]=make2Dimage(circlesX, circlesY, zLevels, distance)

%% OLD
% To project, note that the size of the circle will be a function of its
% distance from the imaging plane. In this case we will treat the distance
% to the first point in the Z axis as the "distance" variable and the
% zLevels will represent additional distance.

%length(zLevels) is also the number of circles

% for ind = 1:length(zLevels)
%     cylX_mod(:,ind) = circle(:,1)./(distance+zLevels(ind));
%     cylY_mod(:,ind) = circle(:,2)./(distance+zLevels(ind));
%     cylZ_mod(:,ind) = zeros(size(circle,1),1);
% end

%% NEW


end
