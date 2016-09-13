function wImg=v_mergeImage(img1,img2)

szImg1=size(img1);
szImg2=size(img2);

maxY=max(szImg1(1),szImg2(1));
maxX=max(szImg1(2),szImg2(2));

reSz=[maxY,maxX];

img1=imresize(img1,reSz);
img2=imresize(img2,reSz);

wImg=[img1;img2];


end