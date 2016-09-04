classdef Zj_DataAnalysis
    properties(Constant)
        
    end;
    
    methods(Static)
        % k: number of principle components
        % A: p by n matrix while n is the number of smaples p is the number
        % of feature dimension in our case p=100K
        % output: k by n matrix
        function [output,er]  =fpca(A, k)
            
            A=A'; % convert 
            AMean = mean(A);
            [n, ~] = size(A);
            Ac= (A - repmat(AMean,[n 1]));
            [~,~,v]=svds(Ac,k);
            output= Ac * v ;%not sure i'm doing projection right
            output=output';
            if nargout>1
                reconstructedA = output * v';
                er=norm( reconstructedA- Ac);
            end
        end
        
        
    end
    
    
    
end