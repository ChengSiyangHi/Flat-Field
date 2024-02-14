%% Z_Compression_Direct_Ellipse_Fitting
% Detect the edge of a bead in xz view
% Ellipse fitting on the edge
% Author: Siyang Cheng 2024/02/01

clear
close all 

img = imread('560nm_nd1.2_50ms_FFEPI_1um(4)Bead1XZisometricscales.tif');
img = im2double(img);
img = mat2gray(img);


%% Edge extraction
threshold = 0.2; % adjust this threshold to properly extract the edges
img_contour = edge(img,'Canny',0.1);
img_contour = double(img_contour);

% Crop the image for seperate scales
% img_contour = img_contour(9:70,:);

figure(1); subplot(1,3,1); imagesc(img); axis image;
subplot(1,3,2); imagesc(img_contour); axis image;

nPoints = sum(sum(img_contour));

% contour = bwboundaries(img_contour);
% contour = contour{1,1};
[h,w] = size(img_contour);
contour = zeros(nPoints,2);
m = 0;
for i=1:h
    for j=1:w
        if img_contour(i,j)~=0
            m = m+1;
            contour(m,1) = i;
            contour(m,2) = j;
        end

    end
end

%% Manually selecting the contour
% Not necessary

%% Fit a ellipse shape
subplot(1,3,3); imagesc(img_contour); xlim([1 h]); ylim([1 w]); axis image; hold on;
scatter(contour(:,2),contour(:,1)); axis off; hold on;
conEllip = fit_ellipse(contour(:,2),contour(:,1),subplot(1,3,3));axis off

longAxis = conEllip.long_axis
shortAxis = conEllip.short_axis
ratio = shortAxis/longAxis
