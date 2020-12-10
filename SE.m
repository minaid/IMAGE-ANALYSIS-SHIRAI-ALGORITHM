function se_val=SE(leftImage, rightImage, k,xLeft,y,xRight)
se_val=0;
[width height] = size(leftImage);
[width2 height2] = size(rightImage);

for i=-k:k
    for j=-k:k
        if( xLeft+i < width && xLeft+i >= 1 && y+j >= 1 && height > y+j)
            if( xRight+i < width2 && xRight+i >= 1 && y+j >= 1 && height2 > y+j)
                se_val = se_val + ( (leftImage(xLeft+i,y+j) - rightImage(xRight+i,y+j))*(leftImage(xLeft+i,y+j) - rightImage(xRight+i,y+j)));
            end
        end 
    end 
end