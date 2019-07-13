function [ K ] = filterImage( I )
%FILTER Summary of this function goes here
%   Detailed explanation goes here
    [row,col] = size(I);
    K = I;
    mask = [-1 -1 -1;
            -1 8 -1;
            -1 -1 -1];
    for i=1:row-2
        for j=1:col-2
            S = I(i:i+2, j:j+2);
            S1 = mask.* double(S);
            K(i+1,j+1)=sum(S1(:));
            
        end
    end

end

