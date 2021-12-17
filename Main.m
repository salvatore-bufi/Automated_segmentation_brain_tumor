% Clear command window and Workspace
clc;
clear;

%               Acquire Flair T1c and T2
fprintf("Insert Flair\n")
[file, path] = uigetfile('*.nii;*.nii.gz');
Flair = niftiread(fullfile(path,file));

fprintf("Insert T1c \n")
[file, path] = uigetfile('*.nii;*.nii.gz');
T1 = niftiread(fullfile(path,file));

fprintf("Insert T2 \n")
[file, path] = uigetfile('*.nii;*.nii.gz');
T2 = niftiread(fullfile(path,file));

fprintf("Insert seg\n")
[file, path] = uigetfile('*.nii;*.nii.gz');
seg = niftiread(fullfile(path,file));


% Rotate the images and convert in grayscale
Flair = rot90(Flair);
Flair = mat2gray(Flair);

T1 = rot90(T1);
T1 = mat2gray(T1);

T2 = rot90(T2);
T2 = mat2gray(T2);

seg = rot90(seg);
segg = mat2gray(seg);

% Display Images and apply pseudocolor
Preview(Flair(:,:,80), T1(:,:,80), T2(:,:,80));





% Calculate Saliency Map over different scales
w = 256; % first resize the image into dim WxW
[sal4,sal8,sal16,sal32] = Saliency(Flair, T1, T2, w);


% Weighted Saliency Map
[dimX,dimY,dimZ] = size(Flair);
[Sal] = CombineSalMaps(sal4,sal8,sal16,sal32, dimX, dimY, dimZ);

% Smoothen the saliency map
Smo = zeros(dimX, dimY, dimZ);
for i = 1 : dimZ
    Smo(:,:,i) = medfilt2(Sal(:,:,i), [25, 25]);
    imshow(Smo(:,:,i),[]);
end
close all;



%Use superpixels to extract tumor region
fprintf(" \n Running superpixels \n");
tumor = SuperpixelsSeg(Smo);


%Display the tumor inside the MRI-Image vs the one segmented by the expert
mriTumor = zeros(dimX, dimY, dimZ);
for i = 1 : dimZ
    mriTumor(:,:,i) = Flair(:,:,i) + tumor(:,:,i);
end
fprintf(" \t Display : tumor expert deliniation(left side)  - tumor result(right side) \n \n")
implay([segg mriTumor ], 5);
pause();


% Improve results of superpixels using region-growing algorithm
fprintf("Running active contours \n") 
tumor2 = activecontour(Smo , tumor, 50);
mriTumor2 = zeros(dimX, dimY, dimZ);
for i = 1 : dimZ
    mriTumor2(:,:,i) = Flair(:,:,i) + tumor(:,:,i);
end

% Display : tumor expert deliniation  - tumor
% from activecontour
fprintf(" \t Display : tumor expert deliniation(left side)  - tumor result(right side) \n \n")
implay([segg mriTumor2],5);
pause();
close all;

fprintf(" Display the 3d volume - tumor is highlighted in white \n ")
volshow(mriTumor2);
pause();
close all;




