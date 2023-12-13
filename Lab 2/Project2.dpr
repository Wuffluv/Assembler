program lab2;


//������ imul � �� mul
{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  x, y, s: integer;

begin
  // ���� �������� x � y � �������
  readln(x);
  readln(y);


  asm
    mov eax, x        // �������� x � ������� eax
    mov ecx, y        // �������� y � ������� ecx
    mov ebx, 0        // ��������� �������� ebx

    mov edx, eax      // ����������� �������� x � ������� edx
    imul edx, ecx     // ��������� edx �� �������� y
    imul edx, ecx     // ��������� edx �� �������� y
    imul edx, eax     // ��������� edx �� �������� x
    imul edx, 3       // ��������� edx �� 3

    mov ebx, edx      // ����������� �������� edx � ������� ebx

    imul edx, ecx, 2  // ��������� edx �� �������� y, ���������� �� 2
    imul edx, ecx     // ��������� edx �� �������� y
    imul edx, eax     // ��������� edx �� �������� x

    sub ebx, edx      // ��������� �������� edx �� �������� ebx

    imul edx, ecx, 7  // ��������� edx �� �������� y, ���������� �� 7
    imul edx, eax     // ��������� edx �� �������� x
    imul edx, eax     // ��������� edx �� �������� x

    sub ebx, edx      // ��������� �������� edx �� �������� ebx

    add ebx, 6        // ����������� � �������� ebx 6

    mov s, ebx        // ���������� �������� ebx � ���������� s
  end;


  
  writeln(s);
  readln;
end.

