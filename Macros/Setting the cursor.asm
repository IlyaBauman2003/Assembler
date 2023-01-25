Set_cursor MACRO row, col

push ax
push bx
push cx
push dx

mov ah, 02h
mov bh, 00h
mov dh, row
mov dl, col
int 10h

pop ax
pop bx
pop cx
pop dx

ENDM Set_cursor
