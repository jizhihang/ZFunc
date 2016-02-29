function [dims,pve]=z_PCA(input,varargin)
% Do PCA on n by p input
% standardization: 1: normalize columns into 0 mean 1 variance
%Each column of dims contains coefficients for one principal component, and the columns are in descending order of component variance
% Zijun's comment: column is the projection coeffiencts
opts.standardization=true;
opts=vl_argparse(opts,varargin);


if opts.standardization
    input=  zscore(input);
end


[dims,~,~,~,pve,~] = pca(input);

end