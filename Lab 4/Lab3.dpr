program ProductOfSquares;

{$APPTYPE CONSOLE}

var
  n, i: integer;
  a: array[1..100] of integer; // Массив целых чисел
  result: integer; // Результат вычислений

begin
  // Ввод количества элементов
  writeln('Enter the value of n: ');
  readln(n);

  // Ввод элементов массива
  writeln('Enter ', n, ' integers:');
  for i := 1 to n do
  begin
    write('a', i, ': ');
    readln(a[i]);
  end;

  // Вычисление произведения квадратов с использованием ассемблерного кода
  asm
    // Инициализация результата
    mov result, 1

    // Цикл по массиву a
    mov ecx, n        // Регистр ecx используется для хранения количества элементов массива
    mov esi, 1        // Регистр esi используется для индексации массива
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

  // Вывод результата
  writeln('Product of squares: ', result);

  readln;
end.

