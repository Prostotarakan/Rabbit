%%ch = menu('World:','Create world','Step','Run')

function VarUIedit
clc
f=figure('MenuBar','None');
mh = uimenu(f,'Label','XP_menu'); % ������ ����
uimenu(mh,'Label','1','Callback',@(h,~)N(h));% ������ � �� ���������
uimenu(mh,'Label','2','Callback',@(h,~)N(h));
uimenu(mh,'Label','3','Callback',@(h,~)N(h));
uimenu(mh,'Label','4','Callback',@(h,~)N(h));
uimenu(mh,'Label','5','Callback',@(h,~)N(h));
uimenu(mh,'Label','6','Callback',@(h,~)N(h));
uimenu(mh,'Label','7','Callback',@(h,~)N(h));
ik=1;
hvb=uiextras.VBox('Padding',5,'Spacing',5);% ������������ ����
BuildUI
 
  function N(hm) %������� ����������� ��� ������� �� �������� ����
  ik=str2double(get(hm,'Label')); %����� ����� ��������� ���������
  BuildUI
  end
 
  function BuildUI %�������� ���������� ����� �����
  h=get(hvb,'Children');%��������� �� ����������� ��� ���� �����
  Lenh=length(h);%��������� ������� ��, ���� �����
  if Lenh>ik % ���� ����� ��������� ������ ��� ����,
    delete(h(ik+1:end)) %�� ������� ��������� ����
  else % ���� ������ ��� ����,
    for n=1:ik-Lenh % �� ��������� �����
      uicontrol('Style', 'edit','Parent',hvb,'BackgroundColor','w')
    end
  end
  end
end