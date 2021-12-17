function [Vf_fin, Vt1_fin, Vt2_fin] = background_edit(Vft, Vt1t, Vt2t)

 %                   BACKGROUND MOD - MEAN GREYSCALE
    % VFLAIR BACK MOD
    summedValue = sum(Vft,'all'); %somma tutti i val della matrice
    nonZeros = nnz(Vft); %nnz(matrix) = numero elementi != da zero
    if nonZeros == 0
        temp = 0;
    else
        temp = summedValue  / nonZeros; 
    end
    Vf_fin = Vft;
    Vf_fin(Vft == 0) = temp;
    
    
    % VT1 BACK MOD
    summedValue = sum(Vt1t,'all'); %somma tutti i val della matrice
    nonZeros = nnz(Vt1t); %nnz(matrix) = numero elementi != da zero
    if nonZeros == 0
        temp = 0;
    else
        temp = summedValue  / nonZeros; 
    end
    Vt1_fin = Vt1t;
    Vt1_fin(Vt1t == 0) = temp;
    
    % VT2 BACK MOD
    summedValue = sum(Vt2t,'all'); %somma tutti i val della matrice
    nonZeros = nnz(Vt2t); %nnz(matrix) = numero elementi != da zero
    if nonZeros == 0
        temp = 0;
    else
        temp = summedValue  / nonZeros; 
    end
    Vt2_fin = Vt2t;
    Vt2_fin(Vt2t == 0) = temp;
end
