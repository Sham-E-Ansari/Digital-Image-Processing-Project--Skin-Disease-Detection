function [ K ] = findErosion( I )
%FINDDILATION Summary of this function goes here
%   Detailed explanation goes here
    [row,col] = size(I);
    K = zeros(row,col);
    for i=2:row-1
        for j=2:col-1
           if(findFit(I(i-1:i+1 , j-1:j+1))==1) 
               K(i,j) =1;
           else
               K(i,j) = 0;
           end
        end
    end
    K = im2bw(K);
end

