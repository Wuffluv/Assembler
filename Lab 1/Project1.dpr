program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
a: word;  //Беззнаковое 16-битное число
b: longword; //Беззнаковое 32-битное число
begin
readln(a);
  asm
  mov ecx, 0; //Инициализируем регистр для работы
  mov cx, a;  //Загружаем значение в младшие 16 бит регистра
  mov b, ecx;  //Сохраняем 16-битное значение из 'a' в 'b', преобразованного в 32-битное значение
  end;
writeln(b);
readln;
end.
 