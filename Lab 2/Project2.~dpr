program EvenCheck;

{$APPTYPE CONSOLE}

var
  num, isEven: integer;

begin
  writeln('Enter number: ');
  readln(num);

  asm
    // Загрузка числа в регистр AX
    mov ax, word ptr num
    // Проверка на четность
    test ax, 1  // логическое И между 'ax' и '1', для проверки младшего бита числа
    jz @even    // Проверка на 0, то переходит к @even
    // Если младший бит не ноль (число нечетное)
    mov isEven, 0
  @even:
    // Если число четное
    mov isEven, 1

  end;

  if isEven = 1 then
    writeln('Number is even')
  else
    writeln('Number is not even');

  readln;
end.

