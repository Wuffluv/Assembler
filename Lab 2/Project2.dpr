program lab2;


//почему imul а не mul
{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  x, y, s: integer;

begin
  // Ввод значений x и y с консоли
  readln(x);
  readln(y);


  asm
    mov eax, x        // Загрузка x в регистр eax
    mov ecx, y        // Загрузка y в регистр ecx
    mov ebx, 0        // Обнуление регистра ebx

    mov edx, eax      // Копирование значения x в регистр edx
    imul edx, ecx     // Умножение edx на значение y
    imul edx, ecx     // Умножение edx на значение y
    imul edx, eax     // Умножение edx на значение x
    imul edx, 3       // Умножение edx на 3

    mov ebx, edx      // Копирование значения edx в регистр ebx

    imul edx, ecx, 2  // Умножение edx на значение y, умноженное на 2
    imul edx, ecx     // Умножение edx на значение y
    imul edx, eax     // Умножение edx на значение x

    sub ebx, edx      // Вычитание значения edx из значения ebx

    imul edx, ecx, 7  // Умножение edx на значение y, умноженное на 7
    imul edx, eax     // Умножение edx на значение x
    imul edx, eax     // Умножение edx на значение x

    sub ebx, edx      // Вычитание значения edx из значения ebx

    add ebx, 6        // Прибавление к значению ebx 6

    mov s, ebx        // Сохранение значения ebx в переменную s
  end;


  
  writeln(s);
  readln;
end.

