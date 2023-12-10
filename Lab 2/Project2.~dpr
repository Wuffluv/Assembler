program Calculator;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
x, y, s:integer;
begin
readln (x);
readln (y);
asm
mov eax, x
mov ecx, y
mov ebx , 0

mov edx, eax
imul edx, ecx
imul edx, ecx
imul edx, eax
imul edx, 3

mov ebx, edx

imul edx, ecx, 2
imul edx, ecx
imul edx, eax

sub ebx,edx

imul edx, ecx, 7
imul edx, eax
imul edx, eax

sub ebx,edx

add ebx,6

mov s, ebx
end;
writeln (s);
end.
