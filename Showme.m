function [I] = Showme(Map,Rabbit,Wolf,Wolffem)
%создание изображения в соответствии с слоями карты
%элементы визуализации: кролики, волки, волчицы, вода и трава
R=imread('Rab.jpg'); 
W=imread('W.jpg');
Wf=imread('Wf.jpg');
Water=imread('Mw.jpg');
Empty=imread('Emp.jpg');

[n m]=size(Map);
Istr=[];
I=[];
%создание цельного изображения
%по степени важности (при наложении) Вода, Волчица, Волк, Кролик, Трава
for i=1:n
    Istr=[];
    for j=1:m
        if Map(i,j)==0
            Istr=[Istr Water];
        else if Wolffem(i,j)>0.025
                Istr=[Istr Wf];
            else if Wolf(i,j)>0.025
                    Istr=[Istr W];
                else if Rabbit(i,j)>0.025
                    Istr=[Istr R];
                    else Istr=[Istr Empty];
                    end
                end
            end
        end
    end
    I=[I;imresize(Istr,0.5)];
end

end

