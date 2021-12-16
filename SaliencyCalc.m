function [sal] = SaliencyCalc(mean_matrix, dim);

%{  
    sal = matrice contenente il valore saliency per ogni patch
    mean_matrix = matrice contenente le patch ( secondo la loro media),
    dim = dimensione della matrice = w/k x w/k
    mean_matrix(:,:,i) con i che rappresenta la dimensione ( L*, a * o b*)

    la matrice sal e mean_matrix(:,:,i) hanno lo stesso numero di elementi,
    essendo mean_matrix la matrice composta dalle patch



%}

sal = zeros(dim, dim);



%{
    row_sal , col_sal = riga, colonna matrice del saliency
    el_row, col_row = riga, colonna che iterano sulla matrice delle medie
    
    ==> 
        Ri: l'elemento Ri è individuato da (row_sal,col_sal)
        Rj: l'elemento Rj è individuato dal (el_row, col_row)

%}
        
for row_sal = 1 : dim
    for col_sal = 1 : dim
        % distance = saliency delll'elemento (row_sal, col_sal);
        distance = 0;
        for el_row = 1:dim  
            for el_col = 1:dim
                if row_sal ~= el_row || col_sal ~= el_col
                    %distance dell'elemento i rispetto l'elemento j
                    euclidean_distance = sqrt((mean_matrix(row_sal,col_sal,1) - mean_matrix(el_row,el_col,1))^2 + ...
                        (mean_matrix(row_sal,col_sal,2) - mean_matrix(el_row,el_col,2))^2 + ...
                        (mean_matrix(row_sal,col_sal,3) - mean_matrix(el_row,el_col,3))^2 );

                    % aggiunta della spacial distance ( tra le patch)
                    spacial_distance = 1 / (1 + sqrt( (row_sal - el_row)^2 + (col_sal - el_col)^2));
                    spacial_distance = spacial_distance * euclidean_distance;

                    distance = distance + spacial_distance;
                end
            end
        end
        sal(row_sal,col_sal) = distance;
    end
end
sal = sal;

end
