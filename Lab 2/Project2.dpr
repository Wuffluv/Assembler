program EvenCheck;

{$APPTYPE CONSOLE}

var
  num, isEven: integer;

begin
  writeln('Enter number: ');
  readln(num);

  asm
    // �������� ����� � ������� AX
    mov ax, word ptr num

    // �������� �� ��������
    test ax, 1
    jz @even
    
    // ���� ������� ��� �� ���� (����� ��������)
    mov isEven, 0
    jmp @done
    
  @even:
    // ���� ����� ������
    mov isEven, 1
    
  @done:
  end;

  if isEven = 1 then
    writeln('Number is even')
  else
    writeln('Number is not even');

  readln;
end.

