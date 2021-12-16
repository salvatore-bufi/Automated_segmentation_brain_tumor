function [] = Preview(Flair, T1c, T2)
% Flair, T1c, T2 are a single slice of dimension MxN


%           Apply background mod 
[Fmod, T1mod, T2mod] = background_edit(Flair, T1c, T2);

% display grayscale slice
figure;
montage({Flair, T1c, T2, Fmod, T1mod, T2mod},'Size',[2 3]);
title('Flair T2 T1 normal background(1st row) background modification(2nd row)')
pause();
close all;



%           Apply Pseudo-Coloring --> RGB
%{
    Create RGB images
    cat(3, RedChannel, GreenChannel, BlueChannel);
%}

Vabc = cat(3, Flair, T2, T1c);
Vacb = cat(3, Flair, T1c, T2);
Vbac = cat(3, T2, Flair, T1c);
Vbca = cat(3, T2, T1c, Flair);
Vcab = cat(3, T1c, Flair, T2);
Vcba = cat(3, T1c, T2, Flair);

title_RGB = sprintf('RGB  Vabc Vacb Vbac Vbca Vcab Vcba ');
figure;
montage({Vabc, Vacb, Vbac, Vbca, Vcab, Vcba},'Size',[1 6]);
title(title_RGB);


%           Convert RGB to CIE-L*a*b*
Vabc = rgb2lab(Vabc);
Vacb = rgb2lab(Vacb);
Vbac = rgb2lab(Vbac);
Vbca = rgb2lab(Vbca);
Vcab = rgb2lab(Vcab);
Vcba = rgb2lab(Vcba);

title_Lab = sprintf('L*a*b*  Vabc Vacb Vbac Vbca Vcab Vcba');
figure;
montage({Vabc, Vacb, Vbac, Vbca, Vcab, Vcba},'Size',[1 6]);
title(title_Lab);
pause();
close all;

end


