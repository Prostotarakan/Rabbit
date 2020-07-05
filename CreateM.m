function Fig = CreateM(Map, Nfig)
%создание слоя особей
%Map - основная карта
%Nfig - количество особей
%Fig - слой с особями
[n m]=size(Map);
Fig=zeros(n,m); % слой
N=0;
while N~=Nfig %заполнение нужным числом особей 
x=randi(n-2)+1;
y=randi(m-2)+1;
if Map(x,y)==1 && Fig(x,y)==0
    % При отсутствии на клетке такого существа и наличия суши
    Fig(x,y)=1;
    N=N+1;
end
end

end

