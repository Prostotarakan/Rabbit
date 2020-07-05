%Map - карта острова
%Rabbit - карта кроликов
%Wolf - карта волков 
%Wolffem карта волчиц
n=10; m=20; % размер карты
NRab=15; % число кроликов
NW=2; % число волков
NWf=2; % число волчиц
RabVer=6; %вероятность нового кролика - 1/RabVer (0.2)
Ha=0.1; %потери здоровья от голода
Hf=1; %добавление здоровья от ужина


Map=[zeros(1,m+2); zeros(n,1) ones(n,m) zeros(n,1);zeros(1,m+2)]; %создание "острова", 1 - суша
Map(randi(n*m,[1 n+m]))=0;
Map1=Map;
Map1(randi(n*m,[1 max(n,m)]))=0;
Rabbit=CreateM(Map, NRab); %Создание слоя кроликов 
Wolf=CreateM(Map, NW); %Создание слоя волков 
Wolffem=CreateM(Map, NWf); %Создание слоя волчиц



figure(1);
I=Showme(Map,Rabbit,Wolf,Wolffem); %визуализация
imshow(I)
count=0;
while (NRab>0) && (NW+NWf)>0 
    count=count+1;
    [xR yR]=find(Rabbit); %находит кроликов
    NRab=length(xR);
    for i=1:length(xR) %движение и размножение кроликов
        All=Rabbit+Wolf+Wolffem+1-Map;
        Ri=All((xR(i)-1):(xR(i)+1),(yR(i)-1):(yR(i)+1));
        Ri(2,2)=0;
        [x y j]=GoStep(Ri,0);
        Rabbit(xR(i),yR(i))=0;
        Rabbit(xR(i)+x,yR(i)+y)=1;
        if randi(RabVer)==1 && j>1
            [x y j]=GoStep(Ri,0);
            Rabbit(xR(i)+x,yR(i)+y)=1;
            NRab=NRab+1;
        end
    end
    
    [xW yW]=find(Wolf); %находит волков
    NW=length(xW);
    for i=1:length(xW)
        if Wolf(xW(i),yW(i))<=0
            NW=NW-1;
            Wolf(xW(i),yW(i))=0;
        else
            Food=Rabbit((xW(i)-1):(xW(i)+1),(yW(i)-1):(yW(i)+1));
            [x y j]=GoStep(Food,1);
            if j 
                Rabbit(xW(i)+x,yW(i)+y)=0; NRab=NRab-1;
                HW=Wolf(xW(i),yW(i));
                Wolf(xW(i),yW(i))=0;
                Wolf(xW(i)+x,yW(i)+y)=HW+Hf;
            else
                Wife=Wolffem((xW(i)-1):(xW(i)+1),(yW(i)-1):(yW(i)+1));
                [x y j]=GoStep(Wife,1);
                if j
                    HW=Wolf(xW(i),yW(i)); 
                    Wolf(xW(i),yW(i))=0;
                    Wolf(xW(i)+x,yW(i)+y)=HW/2;
                    Wolffem(xW(i)+x,yW(i)+y)=Wolffem(xW(i)+x,yW(i)+y)/2;
                    %догнал волчицу... сделал дите.
                    if randi(2)==2
                        Wolf(xW(i),yW(i))=(Wolf(xW(i)+x,yW(i)+y)+Wolffem(xW(i)+x,yW(i)+y));
                        NW=NW+1;
                    else
                        Wolffem(xW(i),yW(i))=(Wolf(xW(i)+x,yW(i)+y)+Wolffem(xW(i)+x,yW(i)+y));
                        NWf=NWf+1;
                    end
                    
                else
                    All=Rabbit+Wolf+Wolffem+1-Map1;
                    Wi=All((xW(i)-1):(xW(i)+1),(yW(i)-1):(yW(i)+1));
                    Wi(2,2)=0;
                    [x y j]=GoStep(Wi,0);
                    HW=Wolf(xW(i),yW(i));
                    Wolf(xW(i),yW(i))=0;
                    Wolf(xW(i)+x,yW(i)+y)=HW-Ha;
                    if Wolf(xW(i)+x,yW(i)+y)<=0
                        NW=NW-1;
                        Wolf(xW(i)+x,yW(i)+y)=0;
                    end
                
                end  
            end
        end
    end
    
    [xW yW]=find(Wolffem); %находит волчиц
    NWf=length(xW);
    for i=1:length(xW)
        if Wolffem(xW(i),yW(i))<=0
                NWf=NWf-1;
                Wolffem(xW(i),yW(i))=0;
        else
            Food=Rabbit((xW(i)-1):(xW(i)+1),(yW(i)-1):(yW(i)+1));
            [x y j]=GoStep(Food,1);
            if j
            Rabbit(xW(i)+x,yW(i)+y)=0; NRab=NRab-1;
            HW=Wolffem(xW(i),yW(i));
            Wolffem(xW(i),yW(i))=0;
            Wolffem(xW(i)+x,yW(i)+y)=HW+Hf;
           
            else
                All=Rabbit+Wolf+Wolffem+1-Map1;
                Wi=All((xW(i)-1):(xW(i)+1),(yW(i)-1):(yW(i)+1));
                Wi(2,2)=0;
                [x y j]=GoStep(Wi,0);
                HW=Wolffem(xW(i),yW(i));
                Wolffem(xW(i),yW(i))=0;
                Wolffem(xW(i)+x,yW(i)+y)=HW-Ha;
                if Wolffem(xW(i)+x,yW(i)+y)<=0
                    NWf=NWf-1;
                    Wolffem(xW(i)+x,yW(i)+y)=0;
                end
            end
        end
    end

    figure(2);
    I=Showme(Map,Rabbit,Wolf,Wolffem); %визуализация
    imshow(I)
end
figure(3);
I=Showme(Map,Rabbit,Wolf,Wolffem); %визуализация
imshow(I)