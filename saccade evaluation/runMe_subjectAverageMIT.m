
clc
clear all
close all


load('MIT_saccade_evaluation_normalized');

tScore = zeros(1, 1003);

testImgPath = ' '; % Path to the saliency maps as an

for s = 1:numel(dataBase.image) % for all the images
    
    % replace the following line with the correct loading function for your
    % saliency map
    load([testImgPath dataBase.image(s).name, '.mat']); 
       
    img = imresize(saliencyMapBlur, [768 1024]); % the saliency should be in the normalized size of 768x1024
    
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
