function [BF, gf]= computeFDMBlur(inputImage, fixation, sigma)
% input should be a density map where there is a fixation it is 1, all else
% will be 0
[sn, sm, ~]=size(inputImage);
n=max([sn sm]);

FDMbinary=zeros(sn,sm);
FDMbinary(fixation(:,1),fixation(:,2))=1;

fc = n*sqrt(log(2)/(2*(pi^2)*(sigma^2)));

[BF, gf]=antonioGaussian(FDMbinary, fc);
end
