classdef Zj_MatrixChecking
   properties(Constant)
       cond_thres=1e15;
   end;
   
   methods(Static)
       % check if the matrix is conditional
       function [flag,deg]= iscondition(input_mat,thres)
           if nargin<2
              thres= Zj_MatrixChecking.cond_thres;
           end
           deg=cond(input_mat);
           if deg>thres
               flag=1;
           else 
               flag=0;
           end
           
       end
       function flag=isrow(input_vec,input_matrix)
           flag=ismember(input_vec,input_matrix,'rows');
       end
   end;
   
    
    
    
end