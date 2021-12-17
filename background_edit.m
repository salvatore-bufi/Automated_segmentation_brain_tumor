function [Vf_fin, Vt1_fin, Vt2_fin] = background_edit(Vft, Vt1t, Vt2t)

 %                   BACKGROUND MOD - MEAN GREYSCALE
 %{
        The background pixels are replaced by their mean intensity value.
        - During the averaging, only the pixels that do not belong to the 
          background are considered.
        
 %}

    % VFLAIR BACK MOD
    summedValue = sum(Vft,'all'); 
    nonZeros = nnz(Vft); 
    if nonZeros == 0
        temp = 0;
    else
        temp = summedValue  / nonZeros; 
    end
    Vf_fin = Vft;
    Vf_fin(Vft == 0) = temp;
    
    
    % VT1 BACK MOD
    summedValue = sum(Vt1t,'all'); 
    nonZeros = nnz(Vt1t); 
    if nonZeros == 0
        temp = 0;
    else
        temp = summedValue  / nonZeros; 
    end
    Vt1_fin = Vt1t;
    Vt1_fin(Vt1t == 0) = temp;
    
    % VT2 BACK MOD
    summedValue = sum(Vt2t,'all'); 
    nonZeros = nnz(Vt2t); 
    if nonZeros == 0
        temp = 0;
    else
        temp = summedValue  / nonZeros; 
    end
    Vt2_fin = Vt2t;
    Vt2_fin(Vt2t == 0) = temp;
end
