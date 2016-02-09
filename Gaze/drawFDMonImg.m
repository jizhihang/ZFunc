function outputImg=drawFDMonImg(inputImg,fdmData)
h = figure('visible', 'off');
image(inputImg);
axis off
set(gca,'position',[0 0 1 1],'units','normalized');
hold on;

imshow(inputImg);
imgHandler=imshow(fdmData);
set(imgHandler, 'AlphaData', 0.5);
colormap jet
outputImg=saveHandle2Mat(h,inputImg);
close(h)
clearvars imgHandler
end % end of function drawFDMPerimg