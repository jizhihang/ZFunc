function fixationMap=drawFixBMap(img,fix)
% function fixationMap=drawFixBMap(img,fix)
% fix will be n by 2 array where the first column is x/column/width
% use plot(fix(:,1),fix(:,2))
% use fixationMap(fix(:,2),fix(:,1))=1



sz_img=size(img);
fixationMap=zeros(sz_img(1),sz_img(2));

for i=1:1:size(fix,1)
   fixationMap(fix(i,2),fix(i,1))=1; 
end

end