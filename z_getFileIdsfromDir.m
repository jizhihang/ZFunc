function listofFiles= z_getFileIdsfromDir(fileDir,fileExt,keepDirs)
%listofFiles= z_getFileIdsfromDir(fileDir,fileExt,keepDirs) get a list of files
% from directory fileDir in
% cell format without extenions fileExt 
% keepDirs indicates if directories should be included
%By Zijun Wei zijwei@cs.stonybrook.edu
%-- Created: 09-Jan-2016
%-- Last modified: 12-Jan-2016
if nargin<2
   fileExt=[]; 
end
if nargin<3
   keepDirs=false; 
end
listofFiles = dir(sprintf('%s/*%s',fileDir,fileExt));
if keepDirs
    %do nothing
else
 listofFiles = listofFiles( ~ [listofFiles.isdir] ) ;
end
listofFiles={listofFiles.name};
listofFiles=setdiff(listofFiles,{'.','..'});
if ~isempty(fileExt)
ext_length=length(fileExt);
listofFiles=cellfun(@(x)x(1:end-ext_length),listofFiles,'UniformOutput', false);
end


    
end