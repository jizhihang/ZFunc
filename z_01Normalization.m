function [input, max_v, min_v]=z_01Normalization(input,max_v,min_v)
%[input, max_v, min_v]=z_01Normalization(input,max_v,min_v)
%normalize a n by m matrix input along each column, if max_v and min_v are
%given, just use them
% for example input:
%  2  3
%  1  5
%  3  8
% output:
%  0.5000         0
%        0    0.4000
%   1.0000    1.0000
% max_v
%    3;8
% min_v
%    1;3
% by Zijun Wei  zijwei@cs.stonybrook.edu
% All rights reserved.
% created:       13-Jan-2016
% last modified  13-Jan-2016
if nargin<3
    newMaxMin=1;
else
    newMaxMin=0;
end

if newMaxMin
    [max_v,min_v]=deal(zeros( size(input,2),1 ));
end

assert(length(max_v)==length(min_v),'Max_v and Min_v are not of the same size: max_v - %d; max_v - %d \n', length(max_v),length(min_v));
assert(length(max_v)==size(input,2),'max_v min_v are not coherent with input size: max(min)_v - %d; input column: - %d \n',length(max_v),size(input,2));
for i = 1: size(input,2)
    if newMaxMin
        max_v(i) = max(input(:,i));
        min_v(i) = min(input(:,i));
    end
    
    if max_v(i)==min_v(i)
        warning('At %d colum they are all the same %f, just make them all zeros',i,max_v(i));
        input(:,i) = (input(:,i)-max_v(i));
        
    else
        input(:,i) = (input(:,i)-min_v(i))/(max_v(i)-min_v(i));
    end
end

end