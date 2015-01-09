classdef Zj_Normalization
    properties(Constant)
        
    end;
    
    methods(Static)
        function checkRow(A)
             if size(A,2)==1
               error('function l2: Input has to be a row vector!'); 
            end
        end
        function output_data=l2(A)
            Zj_Normalization.checkRow(A);
            output_data=bsxfun(@times, A, 1./max( sqrt(sum(A.^2, 2)),eps));
        end
        function output_data=l1(A)
            Zj_Normalization.checkRow(A);
            output_data=bsxfun(@times, A, 1./(max(sum(A, 2), eps)));
        end
        

    end
    
end