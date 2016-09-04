
function cstr = getCommonStr(cLabel, clustCent,  bandWidth, configuration, ScanMatchInfo)



subdir = configuration.subdir;
subjects = dir(subdir);
subjects = subjects(3:end);
nSubjects = length(subjects);

userFixationFile = configuration.userFixationFile;

subjectScanPath = cell(nSubjects, 1);


for s = 1:nSubjects
    
    fPoint = getFixationPointsFromYork([subdir, subjects(s).name filesep userFixationFile]);
    
    str = '';
    for i = 1:size(fPoint, 2)
        cp = fPoint(:, i); % pick a point
        if ~isInImagePlane(cp, 681, 511)
            continue
        end
        
        distance = sqrt(sum(bsxfun(@minus, clustCent, cp).^2));
        [distance, ix] = sort(distance);
        %current = find( distance <=  bandWidth );
        str = cat(2, str, cLabel{ix(distance <=  bandWidth)});        
    end
    subjectScanPath{s} = str;
end

score = 0;
idx = 0;
for i = 1:nSubjects
    str1 = subjectScanPath{i};
    if isempty(str1); continue; end
    simScore = 0;
    for j = 1:nSubjects        
        if ( i == j ); continue; end
        str2 = subjectScanPath{j};
        if isempty(str2); continue; end
        simScore = simScore + ScanMatch(str1, str2, ScanMatchInfo);
    end
    if simScore >= score
        score = simScore;
        idx = i;
    end
end

cstr = subjectScanPath{idx};