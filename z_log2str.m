function str=z_log2str(a)
% str=z_log2str(a) : convert a logic value to string
% 0: 'false'
% 1: 'true'
%By Zijun Wei zijwei@cs.stonybrook.edu
%-- Created: 09-Jan-2016
%-- Last modified: 12-Jan-2016
if a
    str='true';
else
    str='false';
end