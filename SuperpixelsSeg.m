function [tumor] = SuperpixelsSeg(Smo)

Smo = mat2gray(Smo);


%[L,NumLabels] = superpixels3(A,N) computes 3-D superpixels of the 3-D image A. 
% N specifies the number of superpixels you want to create. 
% The function returns L, a 3-D label matrix, and NumLabels, the actual number of superpixels returned.

[L, N] = superpixels3(Smo, 50);

%Set the color of each pixel in output image to the mean intensity of the superpixel region
%{ 
Example
L = 8×8

     1     1     1     0     0     0     0     0
     1     1     1     0     2     2     0     0
     1     1     1     0     2     2     0     0
     1     1     1     0     0     0     0     0
     1     1     1     0     0     0     3     0
     1     1     1     0     0     0     3     0
     1     1     1     0     0     3     3     0
     1     1     1     0     0     0     0     0


pixelIndexList=1×3 cell array
    {24x1 double}    {4x1 double}    {4x1 double}


%}
pixelIdxList = label2idx(L); %Convert label matrix to cell array of linear indices

meanSmo = zeros(size(Smo),'like',Smo); %

for superpixel = 1:N
     memberPixelIdx = pixelIdxList{superpixel};
     %{ 
      pixelIdxList{superpixel} = indexs of the elements corrisponding to the superpixel
       es:
                     pixelIdxList{2}
                    
                        memberPixelIdx =
                        
                            34
                            35
                            42
                            43
     %}

     
     %meanSmo is the volume segmented by pixel intensity
     meanSmo(memberPixelIdx) = mean(Smo(memberPixelIdx));
end

%Convert in grayscale
meanSmo = mat2gray(meanSmo);

%Isolate tumor: select only the pixels corrisponding to the max pixel
%intensity value in the volume.
maxIntensity = max(meanSmo, [], 'all');
tumor = (meanSmo == maxIntensity);


end