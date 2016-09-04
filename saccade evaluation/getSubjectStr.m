
function subjectScanPath = getSubjectStr(cLabel, clustCent,  bandWidth, configuration)

subdir = configuration.subdir;
subjects = dir(subdir);
subjects = subjects(3:end);
nSubjects = length(subjects);

iFixation = configuration.iFixation;
if strcmp(configuration.dataBase.name , 'judd')
    [oy ox] = size(iFixation);    
end

userFixationFile = configuration.userFixationFile;

subjectScanPath = cell(nSubjects, 1);


for s = 1:nSubjects
    
    if strcmp(configuration.dataBase.name, 'york')
        fPoint = getFixationPointsFromYork([subdir, subjects(s).name filesep userFixationFile]);
    else
        if (exist([subdir, subjects(s).name], 'dir') == 7)
            fPoint = getFixationPointsFromJudd([subdir, subjects(s).name filesep], userFixationFile);
            fPoint(1, :) = floor((fPoint (1,:) ./ ox) * 1024);
            fPoint(2, :) = floor((fPoint (2,:) ./ oy) * 768);            
        else
            continue;
        end
    end
    
    str = '';
    for i = 1:size(fPoint, 2)
        cp = fPoint(:, i); % pick a point
        if strcmp(configuration.dataBase.name, 'york')
            if ~isInImagePlane(cp, 681, 511)
                continue
            end
        else
            if  ~isInImagePlane(cp, 1024, 768)
                continue
            end
        end
        
        distance = sqrt(sum(bsxfun(@minus, clustCent, cp).^2));
        [distance, ix] = sort(distance);
        %current = find( distance <=  bandWidth );
        str = cat(2, str, cLabel{ix(distance <=  bandWidth)});        
    end
    subjectScanPath{s} = str;
end

