function [ fixationLocations ] = roundFixationsVis( fixationLocations, imgSz)
% fixationLocations: n by 2 matrix in the form [x,y]
% imgSz: [row, col]
% note this is for visualization only


% get rid of the negative values:

debugFixiations=fixationLocations;

indx=any(fixationLocations<0,2);
fixationLocations(indx,:)=[];

% round:
fixationLocations=round(fixationLocations);


fixationLocations(:,1)=max(fixationLocations(:,1),1);
fixationLocations(:,1)=min(fixationLocations(:,1),imgSz(2));

fixationLocations(:,2)=max(fixationLocations(:,2),1);
fixationLocations(:,2)=min(fixationLocations(:,2),imgSz(1));


end

