


function cLabel = cluster2str(ScanMatchInfo, clustCent, numCluster)
% convert clusters into string labels

clustStr = ScanMatch_FixationToSequence(clustCent', ScanMatchInfo);
cLabel = cell(numCluster, 1);

for i = 1:numCluster
    baseIdx = (i-1)*2 + 1;
    cLabel{i} = clustStr(baseIdx:baseIdx+1);
end

