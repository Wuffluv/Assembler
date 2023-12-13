program EvenCheck;

{$APPTYPE CONSOLE}


//как тест сравнивает логическую 1 и как на основании этого делается вывод число четное или нечетное
var
  num, isEven: integer;

begin
  writeln('Enter number: ');
  readln(num);

  asm
    // Загрузка числа в регистр AX
    mov ax, word ptr num
    // Проверка на четность
    test ax, 1  // логическое И между 'ax' и '1'
    jnz @notEven    // Проверка на 0, переходит к @notEven. jnz - переход по "не нуль"
    // Если младший бит установлен - число четное
    mov isEven, 1
    jmp @done //Переходим к завершению
  @notEven:
    // Если число нечетное
    mov isEven, 0
  @done:
  end;

  if isEven = 1 then
    writeln('Number is even')
  else
    writeln('Number is not even');

  readln;
end.

