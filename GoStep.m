function [x y j] = GoStep( All,k )
%выбор направления движения особи
%k=0 - поиск пустой клетки для хода
%k=1 - поиск другой особи.
        if k==0
            [xi yi]=find(~All);
        else
            [xi yi]=find(All);
        end
        
        if length(xi)
            j=randi(length(xi));
            x=xi(j)-2;y=yi(j)-2;
            j=length(xi);
        else
            x=0;y=0;j=[];
end

