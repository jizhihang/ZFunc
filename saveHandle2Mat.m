function  img=saveHandle2Mat(imgHandle,inputImg,varargin)
% img=saveHandle2Mat(inputImg,varargin) converts current image handle to img in matrix format.
% the img has the same size as inputImg,
%varargin:
% dpi: default(100)
% by Zijun Wei zijwei@cs.stonybrook.edu
% first created 09-Jan-2016
% modified 09-Jan-2016

opts.dpi = 100;
opts=vl_argparse(opts,varargin);
dpi=opts.dpi;

[H,W,~]=size(inputImg);

set(imgHandle, 'paperposition', [0 0 W/dpi H/dpi]);
set(imgHandle, 'papersize', [W/dpi H/dpi]);
tmpimgName=sprintf('%s.jpg',ml_randStr(8));
print(imgHandle, '-djpeg', tmpimgName, sprintf('-r%d', dpi));
img=imread(tmpimgName);
%remove tmpimgName:
delete(tmpimgName);

end