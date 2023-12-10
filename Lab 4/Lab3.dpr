program Lab3;

{$APPTYPE CONSOLE}

var
  n, i: integer;
  numbers: array[1..100] of integer;
  product: int64;

begin
  write('������� ���������� ����� n: ');
  readln(n);

  if (n <= 0) or (n > 100) then
  begin
    writeln('���������� ����� ������ ���� ����������� � �� ��������� 100.');
    exit;
  end;

  write('������� ', n, ' ����� �����: ');
  for i := 1 to n do
    read(numbers[i]);

  product := 1; // �������������� ���������� ��� �������� ������������

  asm
    mov rax, 1    // ������������� rax � 1 (�������������� ������������)
    xor rcx, rcx  // �������� rcx (�������)
    xor rdx, rdx  // �������� rdx (������������� ���������)

  @loop_start:
    // ��������� ����� �� ������� numbers � rsi
    mov rsi, qword ptr [numbers + rcx*4] // �������� �� 4, ��� ��� ������ ����� �������� 4 �����
    // �������� ������� ����� (rsi) �� ������� ������������ (rdx)
    imul rdx, rsi
    // ����������� ������� (rcx)
    inc rcx
    // ���������� ������� (rcx) � ����������� ����� (n)
    cmp rcx, n
    // ���� ������� ������ n, ���������� ����
    jl @loop_start

    // ����� ���� ��������, ��������� ��������� � ���������� product
    mov qword ptr [product], rdx
  end;

  writeln('������������ ����� �����: ', product);
end.

