
function mean_value=MEAN(leftImage,k,n,xLeft,y)
	
[width height] = size(leftImage);
mean_value = 0;
for i = -k:k
	for j = -k:k
        if( xLeft+i < width && xLeft+i >= 1 && y+j >= 1 && height < y+j)
            mean_value = mean_value + leftImage(xLeft+i,y+j);
        end
    end
end

mean_value = mean_value / (n*n);
        