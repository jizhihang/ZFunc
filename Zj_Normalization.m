classdef Zj_Normalization
    properties(Constant)
        
    end;
    
    methods(Static)
        function output_data=l2(A)
            output_data=bsxfun(@times, A, 1./max( sqrt(sum(A.^2, 2)),eps));
        end
        
    end
    
end