program Calculator;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  x, y, result: Integer;

begin
  // ���� �������� x � y
  Write('X: ');
  Readln(x);
  Write('Y: ');
  Readln(y);

  // ������������ 3x^2y^2
  asm
    // ��������� x^2 � ��������� � EAX
    mov eax, x
    imul eax, x

    // ��������� y^2 � ��������� � EBX
    mov ebx, y
    imul ebx, y

    // ��������� 3x^2y^2 � ��������� ��������� � EAX
    imul eax, ebx
    shl eax, 1 // �������� �� 2
    add eax, ebx // ��������� ��� ���� ��� x^2y^2
    add eax, ebx // ��������� ��� ���� ��� x^2y^2

    // ��������� ��������� � ���������� result
    mov result, eax
  end;

  // ������������ 2xy^2
  asm
    // ������������� �������� x � y
    mov eax, x
    mov ebx, y

    // �������� x �� y^2 � ��������� ��������� � EDX
    imul eax, ebx
    imul eax, ebx
    imul eax, ebx

    // �������� ��������� �� 2 � ��������� � EDX
    shl eax, 1

    // ��������� ��������� � ���������� result
    mov result, eax
  end;

  // ������������ 7x^2y
  asm
    // ������������� �������� x � y
    mov eax, x
    mov ebx, y

    // ��������� x^2 � ��������� � ECX
    imul ecx, eax
    imul ecx, eax

    // �������� x^2 �� y � ��������� ��������� � ECX
    imul ecx, ebx

    // �������� ��������� �� 7 � ��������� � ECX
    imul ecx, 7

    // ��������� ��������� � ���������� result
    mov result, ecx
  end;

  // ��������� �������� ���������: 3x^2y^2 - 2xy^2 - 7x^2y+6
  asm
    // ��������� ���������� ���������� ���������� � ��������
    mov eax, result  // 7x^2y
    mov ebx, result  // 2xy^2
    mov ecx, result  // 3x^2y^2

    // �������� 2xy^2
    sub ecx, ebx

    // �������� 7x^2y
    sub ecx, eax

    // ��������� 6
    add ecx, 6

    // ��������� ��������� � ���������� result
    mov result, ecx
  end;

  // ������� ���������
  Writeln('Result: ', result);

  Readln;
end.
