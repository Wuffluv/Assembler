program Calculator;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  x, y, result: Integer;

begin
  // Ввод значений x и y
  Write('X: ');
  Readln(x);
  Write('Y: ');
  Readln(y);

  // Рассчитываем 3x^2y^2
  asm
    // Вычисляем x^2 и сохраняем в EAX
    mov eax, x
    imul eax, x

    // Вычисляем y^2 и сохраняем в EBX
    mov ebx, y
    imul ebx, y

    // Вычисляем 3x^2y^2 и сохраняем результат в EAX
    imul eax, ebx
    shl eax, 1 // Умножаем на 2
    add eax, ebx // Добавляем еще один раз x^2y^2
    add eax, ebx // Добавляем еще один раз x^2y^2

    // Сохраняем результат в переменной result
    mov result, eax
  end;

  // Рассчитываем 2xy^2
  asm
    // Перезагружаем значения x и y
    mov eax, x
    mov ebx, y

    // Умножаем x на y^2 и сохраняем результат в EDX
    imul eax, ebx
    imul eax, ebx
    imul eax, ebx

    // Умножаем результат на 2 и сохраняем в EDX
    shl eax, 1

    // Сохраняем результат в переменной result
    mov result, eax
  end;

  // Рассчитываем 7x^2y
  asm
    // Перезагружаем значения x и y
    mov eax, x
    mov ebx, y

    // Вычисляем x^2 и сохраняем в ECX
    imul ecx, eax
    imul ecx, eax

    // Умножаем x^2 на y и сохраняем результат в ECX
    imul ecx, ebx

    // Умножаем результат на 7 и сохраняем в ECX
    imul ecx, 7

    // Сохраняем результат в переменной result
    mov result, ecx
  end;

  // Вычисляем итоговый результат: 3x^2y^2 - 2xy^2 - 7x^2y+6
  asm
    // Загружаем результаты предыдущих вычислений в регистры
    mov eax, result  // 7x^2y
    mov ebx, result  // 2xy^2
    mov ecx, result  // 3x^2y^2

    // Вычитаем 2xy^2
    sub ecx, ebx

    // Вычитаем 7x^2y
    sub ecx, eax

    // Добавляем 6
    add ecx, 6

    // Сохраняем результат в переменной result
    mov result, ecx
  end;

  // Выводим результат
  Writeln('Result: ', result);

  Readln;
end.
