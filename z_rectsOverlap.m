function  ol_scores  = z_rectsOverlap( rects,a_rects )
%ol_scores  = rectsOverlap( rects,a_rects )
%extending ML_Rects.rectOverlap to multiple rects overlap
%input: rects: n by 4  a_rects: m by 4
% ouput n by m indicating the overlap scores between rects and a_rects

if isempty(rects)
    ol_scores=[];
elseif isempty(a_rects)
    ol_scores=zeros(size(rects,1),1);
else
    ol_scores=zeros(size(rects,1),size(a_rects,1));
    for i=1:1:size(a_rects,1)
        ol_scores(:,i)=Z_RectUtils.rectOverlap(rects(:,1:4),a_rects(i,1:4));
    end
end

end

