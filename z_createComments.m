function z_createComments(createDate)
% z_createComments() create header commnet like Minh's 

if nargin<1
   createDate=date; 
end

fprintf('%% by Zijun Wei  zijwei@cs.stonybrook.edu\n')
fprintf('%% All rights reserved.\n')
fprintf('%% created:       %s\n',createDate);
fprintf('%% last modified  %s\n',date);


end