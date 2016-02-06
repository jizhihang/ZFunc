function stemName=z_getStemName(fullname)
%get file stem name
%example: /zijun/wei.fuck --> wei
%By Zijun Wei zijwei@cs.stonybrook.edu
%-- Created: 09-Jan-2016
%-- Last modified: 12-Jan-2016
[~,stemName,~]=fileparts(fullname);
end