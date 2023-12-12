program ProductOfSquares;

{$APPTYPE CONSOLE}

var
  n, i: integer;
  a: array[1..100] of integer;
  result: integer;

begin

  writeln('n: ');
  readln(n);


  writeln('Enter ', n, ' integers:');
  for i := 1 to n do
  begin
    write('a', i, ': ');
    readln(a[i]);
  end;


  asm
    // Инициализация результата
    mov result, 1

    // Цикл по массиву a
    mov ecx, n        // Регистр ecx для хранения количества элементов массива
    mov esi, 1        // Регистр esiдля индексации массива
    @multiplyLoop:
      // Загрузка текущего элемента в регистр ebx
      mov ebx, dword ptr [a + esi * 4]

      // Умножение текущего элемента самого на себя
      imul ebx, ebx

      // Умножение текущего результата на текущий элемент
      imul ebx, result

      // Сохранение результата в переменную
      mov result, ebx

      // Увеличение счетчика
      inc esi

      // Проверка на завершение цикла
      loop @multiplyLoop
  end;


  writeln('Result: ', result);

  readln;
end.

