function cropedC=z_cropCoordinates(gazePosition,imgSz)
% crop the coordinate in to the valide region
% imgSz should be the same format as gazePosition 
% gazePosition,imgSz should be both  n by [x,y] or both nby [y,x]
% 
% by Zijun Wei
% 2016. someday sunny

gazePosition=round(gazePosition);

xLimit=imgSz(1);
yLimit=imgSz(2);

xPos=gazePosition(:,1);
yPos=gazePosition(:,2);


indxx= (xPos<=0) | (xPos>xLimit) | isnan(xPos) ;
indxy= (yPos<=0) | (yPos>yLimit) | isnan(yPos);

idx=indxx | indxy;

cropedC=gazePosition;
cropedC(idx,:)=[];



end
