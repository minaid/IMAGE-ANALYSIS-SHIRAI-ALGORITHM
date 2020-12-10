
function variance_val = VARIANCE(leftImage,k, n, xLeft, y)
	 
variance_val=0;
[width height] = size(leftImage);

mean = MEAN(leftImage, k, n, xLeft, y);

for i = -k:k
	for j = -k:k
        if( xLeft+i < width && xLeft+i >= 1 && y+j >= 1 && height > y+j)
            variance_val = variance_val + ((leftImage(xLeft+i,y+j)*leftImage(xLeft+i,y+j)) - (mean*mean));
        end
    end
end

variance_val = variance_val /(n*n);