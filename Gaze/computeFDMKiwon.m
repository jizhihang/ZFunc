function     fdm=computeFDMKiwon(inputImg,fixLocation, fixDuration, varargin)
%fdm=computeFDMKiwon(inputImg,fixLocation,fixduration,  varargin) : compute fixation density map
%from gaze information
%varagin:
% sigma: determines the size of blur 0.5 default
% useWeights: if weighted by duration
%
%By Zijun Wei zijwei@cs.stonybrook.edu
%-- Created: 09-Jan-2016
%-- Last modified: 6-Feb-2016:bugfix on fix_weights's duration

opts.sigma=0.5; % 1 degree ~ 0.5 sigma. Of course you can set whatever sigma you want
opts.useWeights=false;
opts=vl_argparse(opts,varargin);
im_size=size(inputImg);


if opts.useWeights
    assert(size(fixLocation,1)==size(fixDuration,1),'#fixation location is not coherent with #fixation duration\n')
    fix_weights=fixDuration;
else
    fix_weights=ones(size(fixLocation,1),1);
end




fdm = zeros(im_size(1), im_size(2));

scaleSigma=max(im_size);
covariance = [opts.sigma^2*scaleSigma 0; 0 opts.sigma^2*scaleSigma];

[X1,X2] = meshgrid(1:im_size(2), 1:im_size(1));
X = [X1(:) X2(:)];


for N=1:size(fixLocation,1)
    Y = mvnpdf(X, fixLocation(N,:), covariance);
    Y = (reshape(Y, im_size(1), im_size(2)));
    fdm = fdm + Y*fix_weights(N);
end

fdm = fdm / max(fdm(:));

if nargout==0
   figure
   imshow(fdm)
end

end
