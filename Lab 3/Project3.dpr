program EvenCheck;

{$APPTYPE CONSOLE}


//��� ���� ���������� ���������� 1 � ��� �� ��������� ����� �������� ����� ����� ������ ��� ��������
var
  num, isEven: integer;

begin
  writeln('Enter number: ');
  readln(num);

  asm
    // �������� ����� � ������� AX
    mov ax, word ptr num
    // �������� �� ��������
    test ax, 1  // ���������� � ����� 'ax' � '1'
    jnz @notEven    // �������� �� 0, ��������� � @notEven. jnz - ������� �� "�� ����"
    // ���� ������� ��� ���������� - ����� ������
    mov isEven, 1
    jmp @done //��������� � ����������
  @notEven:
    // ���� ����� ��������
    mov isEven, 0
  @done:
  end;

  if isEven = 1 then
    writeln('Number is even')
  else
    writeln('Number is not even');

  readln;
end.

