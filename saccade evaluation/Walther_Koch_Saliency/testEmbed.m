
clear

 inputFolder = 'P:\ALLSTIMULI\';
% inputFolder = 'P:\DataLeMeur\images\';
% resultFolder = 'P:\DataLeMeur\result\Harrel_noborder\';
%resultFolder = 'P:\DataLeMeur\result\SCIA\';
% resultFolder = 'p:\lemuer_scia_gabor\';
f = {'Y:\results\results\Itti\', 'Y:\Results\results\SeoMilanfar\', 'Y:\Results\results\Sun\'};
% f = {'Y:\results\results\Harrel\', 'Y:\Results\results\Goferman\'};
% f = {'F:\results\Bruce\'};
% f = { 'P:\DataLeMeur\result\Goferman\' 'P:\DataLeMeur\result\harrel_noborder\' 'P:\DataLeMeur\result\sun\' ...
%     'P:\DataLeMeur\result\SeoMilanfar\' 'P:\DataLeMeur\result\Bruce\'};
for k = 1%:3
    fList = [];
    resultFolder = f{k};
    fList = dir([inputFolder '*.jpeg']);
    
    for i = 1:numel(fList)
        tmp = [];
        fixations = [];
        fname = [inputFolder, fList(i).name];
        images = {fname};
        MyImage = [resultFolder, fList(i).name(1:end-4), '.mat'];
        params = defaultSaliencyParams;
        img = imread(fname);
        [x y ~] = size(fname);
        params.foaSize = round(min(x,y)/6);
        [salMaps,fixations] = batchSaliency2(images,10, params, MyImage);
        tmp = fixations{1};
        Xf = tmp(:,1);
        Yf = tmp(:,2);
%         save(MyImage, 'Xf', 'Yf', '-append');
    end
end