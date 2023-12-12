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
    // ������������� ����������
    mov result, 1

    // ���� �� ������� a
    mov ecx, n        // ������� ecx ��� �������� ���������� ��������� �������
    mov esi, 1        // ������� esi��� ���������� �������
    @multiplyLoop:
      // �������� �������� �������� � ������� ebx
      mov ebx, dword ptr [a + esi * 4]

      // ��������� �������� �������� ������ �� ����
      imul ebx, ebx

      // ��������� �������� ���������� �� ������� �������
      imul ebx, result

      // ���������� ���������� � ����������
      mov result, ebx

      // ���������� ��������
      inc esi

      // �������� �� ���������� �����
      loop @multiplyLoop
  end;


  writeln('Result: ', result);

  readln;
end.

