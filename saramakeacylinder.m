function [ cylX, cylY, cylZ ] = saramakeacylinder( circle, zLevels )
% Now make many circles in the z-plane
for ind = 1:length(zLevels)
    cylX(:,ind) = circle(:,1);
    cylY(:,ind) = circle(:,2);
    cylZ(:,ind) = zLevels(ind)*ones(size(circle,1),1);
end


end

