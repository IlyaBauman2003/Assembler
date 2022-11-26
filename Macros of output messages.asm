Output MACRO string ;макрос для вывода сообщений на экран
push ax
push bx
push cx
push dx

mov ah, 09h
mov dx, offset string
int 21h

pop ax
pop bx
pop cx
pop dx
ENDM Output
