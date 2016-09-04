% runing for TORONTO database
clc
clear all
close all


load('TORONTO_saccade_evaluation');

tScore = zeros(1, 120);

for s = 1%:120
    
    %load salience map replace to suite your format
    testImg = ['E:\DataSets\YORK\DensityMaps\d' num2str(s) '.jpg'];
    %     testImg = ['P:\DataSets\york_dataset\result\Milanfard\' num2str(s) '.jpg'];
    %      testImg = ['P:\DataSets\york_dataset\result\Goferman\' num2str(s) '.jpg'];      
    img = imread(testImg);
    
    
    img = imresize(img, [511, 681]); %make sure the iamges are 511x681.
    
    score = 0;
    cnt = 0;
    subjectStr = dataBase.image(s).subjectStr;
    cLabel = dataBase.image(s).cLabel;
    clustCent = dataBase.image(s).clustCent;
    bandWidth = dataBase.image(s).bandWidth;
    ScanMatchInfo = dataBase.scan.ScanMatchInfo;
    for i = 1:numel(subjectStr)
        cstr = subjectStr{i};
        if ~isempty(cstr)
            len = length(cstr)/2;
            [sm, fix, fstr] = generateFixations(double(img), len, cLabel, clustCent, bandWidth);
            if ~isempty(fstr)
                cnt = cnt + 1;
                score = score + ScanMatch(cstr, fstr, ScanMatchInfo);
            end
        end
    end
    
    score = score / (cnt + eps);
    tScore(s) = score;
    fprintf('\n wellness score is: %f', (score));
end
fprintf('\n');