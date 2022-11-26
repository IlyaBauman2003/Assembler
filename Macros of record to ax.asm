mWriteAx macro ;макрос вывода результата
local convert, write
push ax
push bx
push cx
push dx
push di

mov cx, 10
xor di, di

or ax, ax
jns convert

push ax
mov dx, "-"
mov ah, 02h
int 21h

pop ax
neg ax

convert:
xor dx, dx
div cx
add dl, "0"
inc di
push dx
or ax, ax
jnz convert

write:
pop dx
mov ah, 02h
int 21h
dec di
jnz write

pop di
pop dx
pop cx
pop bx
pop ax

endm mWriteAx
