function Fig = CreateM(Map, Nfig)
%�������� ���� ������
%Map - �������� �����
%Nfig - ���������� ������
%Fig - ���� � �������
[n m]=size(Map);
Fig=zeros(n,m); % ����
N=0;
while N~=Nfig %���������� ������ ������ ������ 
x=randi(n-2)+1;
y=randi(m-2)+1;
if Map(x,y)==1 && Fig(x,y)==0
    % ��� ���������� �� ������ ������ �������� � ������� ����
    Fig(x,y)=1;
    N=N+1;
end
end

end

