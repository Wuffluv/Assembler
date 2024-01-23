format mz
org 100h

mov dx,mes1
call output_str


;���� ����� �������
call input_str
call str_to_int
mov [arr_size],ax

call endl_out

mov dx,mes2
call output_str

;���� �������
call input_arr

call endl_out


;call output_arr

mov dx,mes3
call output_str

;���� ����������
call count
mov ax,bx
call int_to_str
call output_str


mov ah, 01h
int 21h


mov ah,4ch
int 21h
;----------------------------------------------------------------
input_str:
    push cx                 ;���������� �X
    mov cx,ax               ;���������� AX � CX
    mov ah,0Ah              ;������� DOS 0Ah - ���� ������ � �����
    mov al,7
    mov [str1],al         ;������ ������������ ����� � ������ ���� ������
    mov byte[str1+1],0    ;��������� ������� ����� (����������� �����)
    mov dx,str1           ;DX = a���� ������
    int 21h                 ;��������� � ������� DOS
    mov al,[str1+1]       ;AL = ����� �������� ������
    add dx,2                ;DX = ����� ������
    mov ah,ch               ;�������������� AH
    pop cx                  ;�������������� CX
    ret

;-----------------------------------------------------------------
;�������������� ������ � ����� ����� ��� �����
;����: dx - ����� ������
;�����:ax - ���������� �����
str_to_int:
        push bx
        push dx

        mov si, dx               ;������������ ��������  si ������ ������

        xor ax, ax               ;��������� �������� ax
        xor bx, bx               ;��������� ������� bx
        tr_start:
                lodsb            ;��������� ������,�����-�� �� ������ � �������� si
                cmp AL, 0Dh      ;���� ��������� ����� ������,
                je tr_end        ;���������� ���������
                sub AL, 30h      ;�������������� ������� � �����
                imul bx,10       ;��������� bx �� 10 ��� �������� � ����. �������
                add bx, ax       ;���������� � ����� ����������� ������
                jmp tr_start     ;������� � ����. ��������
        tr_end:
        mov ax,bx                ;������� ����������� �������� � ax
        pop dx
        pop bx
        ret
;------------------------------------------------------------------
;�������������� ������ ����� � ������
;����: dx - ����� ������
;      ax - �������� �����
int_to_str:
        push ax
        push dx
        push bx
        push cx
        push di
        mov di,dx             ;����������� ������ ������ � ������� di
        mov cx,0              ;��������� cx(�� - ���-�� ����)
        mov bx,10             ;����������� bx ������� 10(��������� ������� ���������)
        int_str:
                mov dx,0      ;��������� dx
                div bx        ;����� ax �� 10, ������� � dx
                add dx,30h    ;������� ����������� � ������
                push dx       ;��������� ������ � ����
                inc cx        ;����������� �� �� 1
                cmp ax,0
                jne int_str

        int_str2:
                pop dx        ;��������� ������ �� �����
                mov [di],dl   ;����������� ������ ���������� � ������
                inc di        ;������� � ����. ������� ������
                loop int_str2 ;������� � ����. ��������

        mov ax,0dh           ;������� � ������ ������ ����� ������
        mov [di],ax
        pop di
        pop cx
        pop bx
        pop dx
        pop ax

        ret
;---------------------------------------------------------------------
;����� ������
;����: dx - ����� ������
output_str:
          push ax
          push cx
          push dx
          mov si, dx
          out_start:
                lodsb            ;��������� ������

                cmp AL, 0dh      ;���� ��������� ����� ������
                je out_end       ;�� ����������� �����

                mov ah, 02h      ;����� ������������ ������� �� �����
                mov dl, al
                int 21h
                jmp out_start    ;������� � ����.��������
          out_end:


          pop dx
          pop cx
          pop ax
ret
;----------------------------------------------------------------------
;���� ������� ����� �����
;����: arr - �������
;      srr_size - ����� ��������� �������
input_arr:
        push ax
        push bx
        push cx
        push dx
        mov bx, arr          ;�������� ����� ������� � bx
        mov cx,[arr_size]    ;�������� ������� ������� �������� � cx
        input:
              call input_str  ;���� ������
              call str_to_int ;�������������� ������ � �����

              mov [bx],ax     ;���������� ����� �������� � ������ ������
              add bx,2        ;������� � ����. ������ �������
              call endl_out   ;������� �� ����� ������
              loop input

        pop dx
        pop cx
        pop bx
        pop ax
        ret
;----------------------------------------------------------------------
;����� �������
;����: arr - ������
;      arr_size - ������ �������
output_arr:
        push ax
        push bx
        push cx
        mov bx, arr              ;�������� ����� ������� � bx
        mov cx,[arr_size]        ;�������� �������� ������� ������� � cx
        output:
                mov ax,[bx]      ;�������� � �� �������� ������

                call int_to_str  ;����������� �� � ������
                call output_str  ;����� ���������� ������
                add bx,2         ;������� � ����. �������� �������
                call endl_out
                loop output
        pop cx
        pop bx
        pop ax
        ret
;----------------------------------------------------------------------
;������� �� ����.������ ��� ������
endl_out:
        push dx
        mov dx,endl
        call output_str
        pop dx
        ret
;----------------------------------------------------------------------
count:
      push ax
      push dx
      push cx

      mov di,arr
      mov cx,1  ;������� �������� ��������
      mov ax,1  ;���������
      mov bx,0  ;�������
      counter:
             mov dx,[di]   ;���������� �������� �� �������
             call check    ;����� ��������� �������� �� ���������� �������
             add di,2      ;������� � ����. �������� �������
             cmp cx,[arr_size] ;���� ������������ ������� ���������
             je end_count      ;�� ������� �� �����
             inc cx           ;������� � ����.�������� �������
             jmp counter
      end_count:
      pop cx
      pop dx
      pop ax

      ret
;-----------------------------------------------------------------------
check:
        push dx
        push cx

        imul ax,cx      ;������� �������� ��� �������� �������
        imul cx,2       ;������� ��������� �������� �������
        cmp dx,cx       ;���������� ������� ������� � ��������� ��������
        jbe end_c       ;���� ������� ������ ��� �����, �� ���������� ��������

        pop cx          ;��������������� �������������� �������� cx
        push cx

        cmp cx,9        ;���� ������ �������� ������ ��� ����� 9
        jae incr        ;�� ����� ��������� � ���������� ��������


        cmp dx,ax       ;���� ����� ������ ��� ����� ���������� ������ ����������� ������
        jae end_c       ;�� ���������� ��������

        incr:
             inc bx     ;���� �������� �� ���� ����������, �� ����������� �������
        end_c:

        pop cx
        pop dx
        ret
;-----------------------------------------------------------------------
arr_size dw 0                         ;������ �������
arr dw 256 dup (?)                    ;������ ����� 16-������ �����
str1 rb 8                             ;����� ��� ����� ������
mes1 db 'Length of array:',10,13,'$'
mes2 db 'Input array:',10,13,'$'
mes3 db 'Result:',10,13,'$'
endl db 10,13,'$'                     ;����� ������