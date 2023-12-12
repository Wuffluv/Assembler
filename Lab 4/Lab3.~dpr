program Lab3;

{$APPTYPE CONSOLE}

var
  n, i: integer;
  numbers: array[1..100] of integer;
  product: int64;

begin
  write('Введите количество чисел n: ');
  readln(n);

  if (n <= 0) or (n > 100) then
  begin
    writeln('Количество чисел должно быть натуральным и не превышать 100.');
    exit;
  end;

  write('Введите ', n, ' целых чисел: ');
  for i := 1 to n do
    read(numbers[i]);

  product := 1; // Инициализируем переменную для хранения произведения

  asm
    mov rax, 1    // Устанавливаем rax в 1 (инициализируем произведение)
    xor rcx, rcx  // Обнуляем rcx (счетчик)
    xor rdx, rdx  // Обнуляем rdx (промежуточный результат)

  @loop_start:
    // Загружаем число из массива numbers в rsi
    mov rsi, qword ptr [numbers + rcx*4] // Умножаем на 4, так как каждое число занимает 4 байта
    // Умножаем текущее число (rsi) на текущее произведение (rdx)
    imul rdx, rsi
    // Увеличиваем счетчик (rcx)
    inc rcx
    // Сравниваем счетчик (rcx) с количеством чисел (n)
    cmp rcx, n
    // Если счетчик меньше n, продолжаем цикл
    jl @loop_start

    // Когда цикл завершен, сохраняем результат в переменной product
    mov qword ptr [product], rdx
  end;

  writeln('Произведение чисел равно: ', product);
end.

