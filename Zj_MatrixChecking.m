classdef Zj_MatrixChecking
   properties(Constant)
       cond_thres=1e15;
   end;
   
   methods(Static)
       % check if the matrix is conditional
       function flag= condition(input_mat,thres)
           if nargin<2
              thres= Zj_MatrixChecking.cond_thres;
           end
           if cond(input_mat)>thres
               flag=0;
           else 
               flag=1;
           end
           
       end
       
   end;
   
    
    
    
end