function [label, theta] = GrowCut2(sal, gc)
%{  
    Slice:
        sal = saliency map %intensity pixel map
        fore = foreground region
        back = background region
%}
gc = mat2gray(gc);
gc( gc == 0.5) = NaN;
[m,n] = size(sal);
intensity =  mat2gray(sal); 




label = gc;




theta = label; % Theta = strength
%theta(theta == 0) = 1;

labelnew = label;
thetanew = theta;

%intensity = sal;
%attack force 


% 3 pixel neighborhood
running = 1;
while running == 1
    for i = 2: (m-1)
        for j = 2 : (n-1)
             %consideriamo quadrato 3px X 3px, il pixel corrente è al centro
             % ovvero sarà l'elemento (i,j)
             cellI = intensity(i,j);
             % neighbors try to attack the current cell
             % consider 1 neighbor at atime = (ni,nj)
             % atk = attack force
             for ni = (i-1) : (i+1)
                 for nj = (j-1) : (j+1)
                     if ni ~= i | nj ~= j
                         neighI = intensity(ni,nj);
                         atk = transFunc(neighI, cellI);
    
                         %if theta and label are NaN we assign the value in
                         %auto
                         if isnan(thetanew(i,j))
                             labelnew(i,j)= label(ni,nj);
                             thetanew(i,j) = atk * theta(ni,nj);
                         elseif isnan(theta(ni, nj))
                             % do nothin -> label(i,j) = label(i,j) and so
                             % theta
                         elseif atk * theta(ni,nj) > theta(i,j)
                             labelnew(i,j) = label(ni,nj);
                             thetanew(i,j) = atk * theta(ni,nj);
                         
                         end
                     end
                end
            end
        end
        fprintf("\n NaN = %d \n",sum(isnan(label),'all') )
    if sum(isnan(labelnew),'all') == 0
        running = 0;
    end

    end
    label = labelnew;
    theta = thetanew;

end %while
end %function


function [value] = transFunc(px1, px2)
%{
    trensFunc is a monotonous decreasing function bounded to [0,1]
    px1 and px2 = pixel intensity
%}

% L2norm = ||px1 - px2||2

l2 = sqrt((px1 - px2)^2);
value = 1 - (l2 / max([px1, px2]));
end