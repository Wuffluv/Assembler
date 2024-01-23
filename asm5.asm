format mz
org 100h

mov dx,mes1
call output_str


;ввод длины массива
call input_str
call str_to_int
mov [arr_size],ax

call endl_out

mov dx,mes2
call output_str

;ввод массива
call input_arr

call endl_out


;call output_arr

mov dx,mes3
call output_str

;выод результата
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
    push cx                 ;Сохранение СX
    mov cx,ax               ;Сохранение AX в CX
    mov ah,0Ah              ;Функция DOS 0Ah - ввод строки в буфер
    mov al,7
    mov [str1],al         ;Запись максимальной длины в первый байт буфера
    mov byte[str1+1],0    ;Обнуление второго байта (фактической длины)
    mov dx,str1           ;DX = aдрес буфера
    int 21h                 ;Обращение к функции DOS
    mov al,[str1+1]       ;AL = длина введённой строки
    add dx,2                ;DX = адрес строки
    mov ah,ch               ;Восстановление AH
    pop cx                  ;Восстановление CX
    ret

;-----------------------------------------------------------------
;преобразование строки в целое число без знака
;вход: dx - адрес строки
;выход:ax - полученное число
str_to_int:
        push bx
        push dx

        mov si, dx               ;присваивание регистру  si адреса строки

        xor ax, ax               ;обнуление регистра ax
        xor bx, bx               ;обнуление регстра bx
        tr_start:
                lodsb            ;выгружаем символ,наход-ся по адресу в регистре si
                cmp AL, 0Dh      ;если достигнут конец строки,
                je tr_end        ;прекращаем процедуру
                sub AL, 30h      ;преобразование символа в цифру
                imul bx,10       ;умножение bx на 10 для перехода к след. разряду
                add bx, ax       ;прибавляем к числу извлеченный символ
                jmp tr_start     ;переход к след. итерации
        tr_end:
        mov ax,bx                ;перенос полученного значения в ax
        pop dx
        pop bx
        ret
;------------------------------------------------------------------
;Преобразование целого числа в строку
;вход: dx - адрес строки
;      ax - исходное число
int_to_str:
        push ax
        push dx
        push bx
        push cx
        push di
        mov di,dx             ;копирование адреса строки в регистр di
        mov cx,0              ;обнуление cx(сх - кол-во цифр)
        mov bx,10             ;присваиваем bx начение 10(основание системы счисления)
        int_str:
                mov dx,0      ;обнуление dx
                div bx        ;делим ax на 10, остаток в dx
                add dx,30h    ;остаток преобразуем в символ
                push dx       ;помещеаем символ в стэк
                inc cx        ;увеличиваем сх на 1
                cmp ax,0
                jne int_str

        int_str2:
                pop dx        ;извлекаем символ из стэка
                mov [di],dl   ;извлеченный символ записываем в строку
                inc di        ;переход к след. символу строки
                loop int_str2 ;переход к след. итерации

        mov ax,0dh           ;заносим в строку символ конца строки
        mov [di],ax
        pop di
        pop cx
        pop bx
        pop dx
        pop ax

        ret
;---------------------------------------------------------------------
;вывод строки
;вход: dx - адрес строки
output_str:
          push ax
          push cx
          push dx
          mov si, dx
          out_start:
                lodsb            ;извлекаем символ

                cmp AL, 0dh      ;если достигнут конец строки
                je out_end       ;то заканчиваем вывод

                mov ah, 02h      ;вывод извлеченного символа на экран
                mov dl, al
                int 21h
                jmp out_start    ;переход к след.итерации
          out_end:


          pop dx
          pop cx
          pop ax
ret
;----------------------------------------------------------------------
;Ввод массива целых чисел
;вход: arr - массива
;      srr_size - число элементов массива
input_arr:
        push ax
        push bx
        push cx
        push dx
        mov bx, arr          ;копируем адрес массива в bx
        mov cx,[arr_size]    ;значение размера массива копируем в cx
        input:
              call input_str  ;ввод строки
              call str_to_int ;преобразование строки в число

              mov [bx],ax     ;полученное число копируем в ячейку памяти
              add bx,2        ;переход к след. ячейке массива
              call endl_out   ;переход на новую строку
              loop input

        pop dx
        pop cx
        pop bx
        pop ax
        ret
;----------------------------------------------------------------------
;Вывод массива
;вход: arr - массив
;      arr_size - размер массива
output_arr:
        push ax
        push bx
        push cx
        mov bx, arr              ;копируем адрес массива в bx
        mov cx,[arr_size]        ;копируем значение размера массива в cx
        output:
                mov ax,[bx]      ;копируем в ах значение ячейки

                call int_to_str  ;преобразуем ах в строку
                call output_str  ;вывод полученной строки
                add bx,2         ;переход к след. элементу массива
                call endl_out
                loop output
        pop cx
        pop bx
        pop ax
        ret
;----------------------------------------------------------------------
;переход на след.строку при выводе
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
      mov cx,1  ;порядок текущего элемента
      mov ax,1  ;факториал
      mov bx,0  ;счетчик
      counter:
             mov dx,[di]   ;извлечение элемента из массива
             call check    ;вызов процедуры проверки на выполнения условия
             add di,2      ;переход к след. элементу массива
             cmp cx,[arr_size] ;если обработанный элемент последний
             je end_count      ;то выходим из цикла
             inc cx           ;переход к след.элементу массива
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

        imul ax,cx      ;находим факторил для текущего индекса
        imul cx,2       ;находим удвоенное значение индекса
        cmp dx,cx       ;сравниваем текущий элемент с удвоенным индексом
        jbe end_c       ;если элемент меньше или равен, то прекращаем проверку

        pop cx          ;восстанавливаем первоначальное значение cx
        push cx

        cmp cx,9        ;если индекс элемента больше или равен 9
        jae incr        ;то сразу переходим с увеличению счетчика


        cmp dx,ax       ;если число больше или равно факториалу своего порядкового номера
        jae end_c       ;то прекращаем проверку

        incr:
             inc bx     ;если проверка не была прекращена, то увеличиваем счетчик
        end_c:

        pop cx
        pop dx
        ret
;-----------------------------------------------------------------------
arr_size dw 0                         ;размер массива
arr dw 256 dup (?)                    ;массив целых 16-битных чисел
str1 rb 8                             ;буфер для ввода строки
mes1 db 'Length of array:',10,13,'$'
mes2 db 'Input array:',10,13,'$'
mes3 db 'Result:',10,13,'$'
endl db 10,13,'$'                     ;конец строки