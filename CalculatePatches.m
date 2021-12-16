function [Patch4, Patch8, Patch16, Patch32] = CalculatePatches(Vabc, w)

% Calculate patches for each channel of Vabc ( L*,a*,b*)
for i = 1 : 3
    % Patch K=4
    k = 4;
    %[Patch4(:,:,i)
    [Patch4(:,:,i)]= ExtractPatches(Vabc(:,:,i),k,w);
    
    % Patch K=8
    k = 8;
    [Patch8(:,:,i)]= ExtractPatches(Vabc(:,:,i),k,w);
    
    
    % Patch K=16
    k = 16;
    [Patch16(:,:,i)] = ExtractPatches(Vabc(:,:,i),k,w);
    
    
    % Patch K=32
    k = 32;
    [Patch32(:,:,i)] = ExtractPatches(Vabc(:,:,i),k,w);
end

end

function [Patch] = ExtractPatches(matrix, k, w)
%{
K = n° pixel(su 1 dim) in qui viene divisa una patch R -> dim(R) = K x K pixel
    w = n° pixel(su 1 dim) immagine matrix -> dim(matrix) = w x w pixel
    no = n° blocchi (patches) su una dim = w / K
    No = n° blocchi totali -> No = no*no
%}
no = w/k;
n = k * ones(1,no);
patches = mat2cell(matrix,n,n);
%{
    example with:
        - w = 4
        - k = 2
    
    no = numero patch = w/k * w/k = 4
    
    
    a =

    16     2     3    13
     5    11    10     8
     9     7     6    12
     4    14    15     1



    celldisp(patches)
 
patches{1,1} =
 
    16     2
     5    11

 
 
patches{2,1} =
 
     9     7
     4    14

 
 
patches{1,2} =
 
     3    13
    10     8

 
 
patches{2,2} =
 
     6    12
    15     1


%} 

%                Calcolo valore medio per ogni patch
%{
    Considerando l'esempio precendente mean_val e quindi media_patches sarà una matrice 2x2
    
media_patches =

    8.5000    8.5000
    8.5000    8.5000

    
%}

for i = 1:no
    for j = 1:no
        mean_val(i,j) = sum(patches{i,j}, 'all')/k^2;
    end
end

Patch = mean_val;
    
end
