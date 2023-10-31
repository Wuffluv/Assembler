program Lab3;

{$APPTYPE CONSOLE}

var
  n, i: Integer;
  result: Double;
  numbers: array[1..100] of Double;

asm
  mov eax, [numbers]    // Загрузка адреса массива numbers в eax
  mov ecx, [n]          // Загрузка n в ecx (количество чисел)
  fld1                  // Загрузка 1.0 во вещественный регистр FPU (ST0)
  @@multiplyLoop:
    fld qword ptr [eax] // Загрузка числа из массива в стек FPU
    fmul                // Умножение числа из стека FPU на ST0, результат в ST0
    fstp qword ptr [eax] // Сохранение результата обратно в массив
    add eax, 8          // Переход к следующему элементу в массиве (Double - 8 байт)
    loop @@multiplyLoop  // Повторение цикла до тех пор, пока ecx не станет равным нулю
  fstp [result]          // Сохранение конечного результата в result
end;

begin
  writeln('Введите количество чисел (n): ');
  readln(n);

  writeln('Введите ', n, ' чисел: ');
  for i := 1 to n do
    readln(numbers[i]);

  writeln;
  
  writeln('Произведение чисел: ', result:0:2); // Вывод результата с двумя знаками после запятой
end.

