program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
a: word;  //����������� 16-������ �����
b: longword; //����������� 32-������ �����
begin
readln(a);
  asm
  mov ecx, 0; //�������������� ������� ��� ������
  mov cx, a;  //��������� �������� � ������� 16 ��� ��������
  mov b, ecx;  //��������� 16-������ �������� �� 'a' � 'b', ���������������� � 32-������ ��������
  end;
writeln(b);
readln;
end.
 