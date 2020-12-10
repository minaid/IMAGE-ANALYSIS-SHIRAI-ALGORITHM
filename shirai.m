function [CorrespondingPoint] = shirai()
% This sctript demonstrate the basic feature based correspondence points
% matching algorithm.

clc
clear all

% Load and display original images.

LeftImage = imread('left.jpg');
RightImage = imread('right.jpg');

LeftImage = LeftImage([1:100],[1:100],:);
RightImage = RightImage([1:100],[1:100],:);

[LeftHeight,LeftWidth] = size(LeftImage(:,:,1));
[RightHeight,RightWidth] = size(RightImage(:,:,1));
Height = min(LeftHeight,RightHeight);
Width = min(LeftWidth,RightWidth);
%Initialize Corresponding Point Matrix
CorrespondingPoint = zeros(Height,Width);
LeftImage = LeftImage([1:Height],[1:Width],:);
RightImage = RightImage([1:Height],[1:Width],:);
figure('Name','Original Left Image');
imshow(LeftImage);
title('Left RGB Image');
figure('Name','Original Right Image');
imshow(RightImage);
title('Right RGB Image');

% Convert images to grayscale images in order to reduce computational
% effort.
LeftImage = rgb2gray(LeftImage);
LeftImage = double(LeftImage)/255;
RightImage = rgb2gray(RightImage);
RightImage = double(RightImage)/255;
figure('Name','Grayscaled Left Image');
imshow(LeftImage);
title('Left Grayscale Image');
figure('Name','Grayscaled Right Image');
imshow(RightImage);
title('Right Grayscale Image');

% Compute the image corresponding to the lest image.

EdgeImage = im2bw(LeftImage);
EdgeImage = double(EdgeImage);
EdgeImage = edge(EdgeImage,'prewitt');
figure('Name','Thresholded Left Edge Image');
imshow(EdgeImage);

% Main algorithm for the correspondence problem.

% Set the window size.
W = 2;

% For each scan line.
for i = W+1:1:Height-W
    % For each pixel of the left image image within ths scan line.
    for j = W+1:1:Width - W
        [i,j]
        if (EdgeImage(i,j)==1)
            % Get left image window.
            LeftImageWindow = LeftImage([i-W:i+W],[j-W:j+W]);
            % Compute the mean intensity value of the left window.
            LeftWindowMean = mean(mean(LeftImageWindow));
            % Compute some auxiliary variables related to the left image
            % window.
            Mleft = LeftImageWindow - LeftWindowMean;
            Mleft_square = Mleft.^2;
            % Get the search area within the right image.            
            SearchLine = [W+1:j];
            SearchLineWidth = length(SearchLine);
            % Initialize right image windows and corresponding means and
            % costs.
            RightImageWindows = cell(1,SearchLineWidth);
            RightImageMeans = zeros(1,SearchLineWidth);
            Cost = zeros(1,SearchLineWidth);
            % For each point in the search line of the right window compute
            % the corresponding cost.
            for m = 1:1:length(SearchLine)
                %m
                RightImageWindows{m} = RightImage([i-W:i+W],[SearchLine(m)-W:SearchLine(m)+W]);   %pairnei to kathe ena parathiraki
                %SH = [SearchLine(m)-W:SearchLine(m)+W]
                %SW = [j-W:j+W]
                RightImageMeans(m) = mean(mean(RightImageWindows{m}));
                % Compute some auxiliary variables related to the right image
                % window.
                Mright = RightImageWindows{m} - RightImageMeans(m);
                Mright_square = Mright.^2;
                % Compute the cost value associated with the current
                % window.
                Cost(m) = sum(sum(Mleft .* Mright)) / sqrt(sum(sum(Mleft_square))*sum(sum(Mright_square)));
                Cost
                %this also stays the same
                [maximum,maximum_index] = max(Cost);
                CorrespondingPoint(i,j) = maximum_index;
            end;
        end;
    end;
end;
end