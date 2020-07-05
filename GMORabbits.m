function f = GMORabbits(x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%Map - ����� �������
%Rabbit - ����� ��������
%Wolf - ����� ������ 
%Wolffem ����� ������
n=10; m=15; % ������ �����
Map=[zeros(1,m+2); zeros(n,1) ones(n,m) zeros(n,1);zeros(1,m+2)]; %�������� "�������", 1 - ����

Map(randi(n*m,[1 20]))=0;

Map1=Map;
Map1(randi(n*m,[1 max(n,m)]))=0;

NRab=round(x(1));%30; % ����� ��������
NW=round(x(2));%3; % ����� ������
NWf=round(x(3));%3; % ����� ������
RabVer=round(x(4));%4; %����������� ������ ������� - 1/RabVer (0.2)
Ha=x(5);%0.1; %������ �������� �� ������
Hf=x(6);%1; %���������� �������� �� �����



Rabbit=CreateM(Map, NRab); %�������� ���� �������� 
Wolf=CreateM(Map, NW); %�������� ���� ������ 
Wolffem=CreateM(Map, NWf); %�������� ���� ������
% I=Showme(Map,Rabbit,Wolf,Wolffem); %������������
% imshow(I)


count=0;

while (NRab>0) && ((NW+NWf)>0) && (count<100)
    count=count+1;
    [xR yR]=find(Rabbit); %������� ��������
    for i=1:length(xR) %�������� � ����������� ��������
        All=Rabbit+Wolf+Wolffem+1-Map;
        Ri=All((xR(i)-1):(xR(i)+1),(yR(i)-1):(yR(i)+1));
        Ri(2,2)=0;
        [xi yi]=find(~Ri);
        j=randi(length(xi));
        Rabbit(xR(i),yR(i))=0;
        Rabbit(xR(i)-2+xi(j),yR(i)-2+yi(j))=1;
        if randi(RabVer)==1 && length(xi)>1
            if j<length(xi)
                j=j+1;
            else
                j=j-1;
            end
            Rabbit(xR(i)-2+xi(j),yR(i)-2+yi(j))=1;
            NRab=NRab+1;
        end
    end
    
    [xW yW]=find(Wolf); %������� ������
    for i=1:length(xW)
        if Wolf(xW(i),yW(i))<=0
                    NW=NW-1;
        else
        
        Food=Rabbit((xW(i)-1):(xW(i)+1),(yW(i)-1):(yW(i)+1));
        [xR yR]=find(Food);
        if xR
           j=randi(length(xR)); 
           Rabbit(xW(i)-2+xR(j),yW(i)-2+yR(j))=0; NRab=NRab-1;
           HW=Wolf(xW(i),yW(i));
           Wolf(xW(i),yW(i))=0;
           Wolf(xW(i)-2+xR(j),yW(i)-2+yR(j))=HW+Hf;
        else
            Wife=Wolffem((xW(i)-1):(xW(i)+1),(yW(i)-1):(yW(i)+1));
            [xw yw]=find(Wife);
            if xw
                j=randi(length(xw));
                HW=Wolf(xW(i),yW(i)); 
                Wolf(xW(i),yW(i))=0;
                Wolf(xW(i)-2+xw(j),yW(i)-2+yw(j))=HW/2;
                Wolffem(xW(i)-2+xw(j),yW(i)-2+yw(j))=Wolffem(xW(i)-2+xw(j),yW(i)-2+yw(j))/2;
                %������ �������... ������ ����.
                if randi(2)==2
                    Wolf(xW(i),yW(i))=(Wolf(xW(i)-2+xw(j),yW(i)-2+yw(j))+Wolffem(xW(i)-2+xw(j),yW(i)-2+yw(j)));
                    NW=NW+1;
                else
                    Wolffem(xW(i),yW(i))=(Wolf(xW(i)-2+xw(j),yW(i)-2+yw(j))+Wolffem(xW(i)-2+xw(j),yW(i)-2+yw(j)));
                    NWf=NWf+1;
                end
                    
            else
                All=Rabbit+Wolf+Wolffem+1-Map1;
                Wi=All((xW(i)-1):(xW(i)+1),(yW(i)-1):(yW(i)+1));
                %Wi(2,2)=0;
                [xi yi]=find(~Wi);
                if xi
                j=randi(length(xi));
                HW=Wolf(xW(i),yW(i));
                Wolf(xW(i),yW(i))=0;
                Wolf(xW(i)-2+xi(j),yW(i)-2+yi(j))=HW-Ha;
                if Wolf(xW(i)-2+xi(j),yW(i)-2+yi(j))<=0
                    NW=NW-1;
                    %count
                end
                end
            end  
        end
        end
    end
    
    [xW yW]=find(Wolffem); %������� ������
    for i=1:length(xW)
        if Wolffem(xW(i),yW(i))<=0
                NW=NW-1;
                %count
        else
        Food=Rabbit((xW(i)-1):(xW(i)+1),(yW(i)-1):(yW(i)+1));
        [xR yR]=find(Food);
        if xR
           j=randi(length(xR)); 
           Rabbit(xW(i)-2+xR(j),yW(i)-2+yR(j))=0; NRab=NRab-1;
           HW=Wolffem(xW(i),yW(i));
           Wolffem(xW(i),yW(i))=0;
           Wolffem(xW(i)-2+xR(j),yW(i)-2+yR(j))=HW+Hf;
           
        else
           All=Rabbit+Wolf+Wolffem+1-Map1;
           Wi=All((xW(i)-1):(xW(i)+1),(yW(i)-1):(yW(i)+1));
           %Wi(2,2)=0;
           [xi yi]=find(~Wi);
           if xi
            j=randi(length(xi));
            HW=Wolffem(xW(i),yW(i));
            Wolffem(xW(i),yW(i))=0;
            Wolffem(xW(i)-2+xi(j),yW(i)-2+yi(j))=HW-Ha;
            if Wolffem(xW(i)-2+xi(j),yW(i)-2+yi(j))<=0
                NW=NW-1;
                %count
            end
           end
           
        end
    end
end
    
%     I=Showme(Map,Rabbit,Wolf,Wolffem); %������������
%     imshow(I)
end
% figure();
% I=Showme(Map,Rabbit,Wolf,Wolffem); %������������
% imshow(I)
f=-count;
end

