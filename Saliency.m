function [sal4,sal8,sal16,sal32] = Saliency(Flair, T1, T2, w)

% Dimension of the original image
[dimX, dimY, dimZ] = size(Flair);

% Create a 3d matrix - dimension = DimX x DimY x DimZ
saliency = zeros(dimX, dimY, dimZ);

%BackEdit
%{
[Flair, medF] = BackEdit(Flair);
[T1, medT1] = BackEdit(T1);
[T2, medT2] = BackEdit(T2);
%}

% Calculate Saliency Map
fprintf("Start of saliency map calculation \n");
h = waitbar(0,'1', 'Name', 'Calculating saliency map');
for i = 1:dimZ
    waitbar(i/dimZ, h, sprintf(" Slice no = %d / %d", i, dimZ))
    %fprintf(" \t\t Slice no = %d / %d \n",i, dimZ)
    %Extract 1 slice at time
    Vf = Flair(:,:,i);
    Vt1 = T1(:,:,i);
    Vt2 = T2(:,:,i);

    %Resize
    %{
        Resize each slice from (dimX x  dimY) to (W x W)
        Example:
        Vf = 
     
         1     1     1
         1     1     1
         1     1     1
    
    
    Vf = 
         1     1     1     0     0
         1     1     1     0     0
         1     1     1     0     0
         0     0     0     0     0
         0     0     0     0     0
    
    %}

    Vf(w,w) = 0;
    Vt1(w,w) = 0;
    Vt2(w,w) = 0;

    

    %Replace Background pixel by their mean image intensity
    [Vf, Vt1, Vt2] = background_edit(Vf, Vt1, Vt2);    

   
    

    %Pseudocoloring RGB
    %{
       RedChannel = Flair;
       GreenChannel = T1C
       BlueChannel = T2
    %}
    %Vabc = cat(3, Vf, Vt1, Vt2);
    Vabc = cat(3, Vt2, Vf, Vt1);

    % RGB --> CIE-L*a*b*
    Vabc = rgb2lab(Vabc);

    % Calculate Patches for each of the 3 channels (L*,a*,b*)
    % Patch = W/K x W/K * 3(lab) * dimZ
    % Patch(:,:,1,i) = canale a dello slice i-esimo
    [Patch4(:,:,:,i), Patch8(:,:,:,i), Patch16(:,:,:,i), Patch32(:,:,:,i)] = CalculatePatches(Vabc, w);



    % Calculate Saliency Map
    [sal4(:,:,i)] = SaliencyCalc(Patch4(:,:,:,i), w/4);

    [sal8(:,:,i)] = SaliencyCalc(Patch8(:,:,:,i), w/8);

    [sal16(:,:,i)] = SaliencyCalc(Patch16(:,:,:,i), w/16);
    
    [sal32(:,:,i)] = SaliencyCalc(Patch32(:,:,:,i), w/32);
    


end

fprintf("End of saliency map calculation \n");
close(h);
end





