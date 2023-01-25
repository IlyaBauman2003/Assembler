mReadAX MACRO buf, sz ;макрос чтения введенных значений
local input, startOfConvert, endofConvert
push bx
push cx
push dx

input:
mov [buf], sz
mov dx, offset [buf]
mov ah, 0ah
int 21h

mov ah, 02h
mov dl, 0Dh
int 21h

mov ah, 02h
mov dl, 0Ah
int 21h

xor ah, ah
cmp ah, [buf][1]
jz input

xor cx, cx
mov cl, [buf][1]

xor ax, ax
xor bx, bx
xor dx, dx
mov bx, offset [buf][2]

cmp [buf][2], "-"
jne startOfConvert
inc bx
dec cl

startOfConvert:
mov dx, 10
mul dx
cmp ax, 8000h
jae input

mov dl, [bx]
sub dl, "0"

add ax, dx
cmp ax, 8000h
jae input

inc bx
loop startOfConvert

cmp [buf][2], "-"
jne endofConvert
neg ax

endofConvert:
pop dx
pop cx
pop bx

endm mReadAX
