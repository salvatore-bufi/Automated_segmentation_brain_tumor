function [gc] = Morph(tumor)

%foreground
se = strel('sphere',5); %3
fore = imerode(tumor, se);

%background
a = 2;
b = 3; %a = 3, b = 4
se = strel('sphere',a);
b1 = imdilate(tumor, se);

se2 = strel('sphere',b);
b2 = imdilate(tumor, se2);


%prepare for gc
[m,n,z] = size(tumor);
gz = zeros(m,n,z);

gc = fore + b1 + b2;
%back == 1, togrow == 2, fore == 3;
gc(gc == 1) = 0;
gc(gc  == 3) = 1;
gc(gc == 2) = 0.5;
end
