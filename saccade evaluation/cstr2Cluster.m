
function cSeqCenter = cstr2Cluster(cstr, cLabel, clustCent, show)

nstr = length(cstr);
cSeqCenter = zeros(2, nstr/2);
cnt = 1;
for i = 1:2:nstr
    chr = cstr(i:i+1);
    for j = 1:size(cLabel, 1)
        if strcmp(chr, cLabel{j}), break; end
    end
    cSeqCenter(:, cnt) = clustCent(:, j);
    cnt = cnt + 1;
end

if show == true
    numCluster = size(cSeqCenter, 2);
    tmpimg = imread(configuration.imgPath);
    figure(10),clf,hold on
    imshow(tmpimg); hold on
    cVec = 'bgrcmybgrcmybgrcmybgrcmy';%, cVec = [cVec cVec];
    for k = 1:min(numCluster,length(cVec))
        myClustCen = cSeqCenter(:,k);
        plot(myClustCen(1),myClustCen(2),'o','MarkerEdgeColor','k','MarkerFaceColor',cVec(k), 'MarkerSize', 10)
        pause(1);
    end
end
