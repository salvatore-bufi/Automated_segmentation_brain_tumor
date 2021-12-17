function [saliency] = CombineSalMaps(sal4,sal8,sal16,sal32, m, n, dimZ)


for i = 1 : dimZ
    % Rescaling to the original image size MxN
    interpol4 = imresize(sal4(:,:,i), [m n], 'bilinear');
    interpol8 = imresize(sal8(:,:,i), [m n], 'bilinear');
    interpol16 = imresize(sal16(:,:,i), [m n], 'bilinear');
    interpol32 = imresize(sal32(:,:,i), [m n], 'bilinear');
    

    interpol = cat(3, interpol4, interpol8, interpol16, interpol32);
    
    % Calculate weighted saliency map
    saliency(:,:,i) = zeros(m,n);
    for j = 1 : 4
        weight = 1 / 4;
        temp = weight * interpol(:,:, j);
        saliency(:,:,i) = saliency(:,:,i) + temp;
    end
end


end
