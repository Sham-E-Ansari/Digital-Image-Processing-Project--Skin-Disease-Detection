function [ flag ] = findFit( I )

se =[1 1 1;
     1 1 1;
     1 1 1];
    

    
    [row,col] = size(I);
    for i = 1:row
        for j = 1:col
            if(se(i,j)==1 && I(i,j) ==0)
                flag = 0;
                break;
            else
                flag = 1;
            end
        end
    end


end

