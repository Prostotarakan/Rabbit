%%ch = menu('World:','Create world','Step','Run')

function VarUIedit
clc
f=figure('MenuBar','None');
mh = uimenu(f,'Label','XP_menu'); % Создаём меню
uimenu(mh,'Label','1','Callback',@(h,~)N(h));% Делаем в нём подпункты
uimenu(mh,'Label','2','Callback',@(h,~)N(h));
uimenu(mh,'Label','3','Callback',@(h,~)N(h));
uimenu(mh,'Label','4','Callback',@(h,~)N(h));
uimenu(mh,'Label','5','Callback',@(h,~)N(h));
uimenu(mh,'Label','6','Callback',@(h,~)N(h));
uimenu(mh,'Label','7','Callback',@(h,~)N(h));
ik=1;
hvb=uiextras.VBox('Padding',5,'Spacing',5);% Вертикальный ящик
BuildUI
 
  function N(hm) %Функция выполняемая при нажатии на подпункт меню
  ik=str2double(get(hm,'Label')); %узнаём номер выбраного подпункта
  BuildUI
  end
 
  function BuildUI %Изменяет количество полей ввода
  h=get(hvb,'Children');%Указатели на существущие уже поля ввода
  Lenh=length(h);%Вычисляем сколько их, этих полей
  if Lenh>ik % Если полей оказалось больше чем надо,
    delete(h(ik+1:end)) %то удаляем последние поля
  else % если меньше чем надо,
    for n=1:ik-Lenh % то добавляем новые
      uicontrol('Style', 'edit','Parent',hvb,'BackgroundColor','w')
    end
  end
  end
end