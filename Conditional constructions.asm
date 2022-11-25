.model small
.386
.stack 100h
.data
x dw ?
a dw ?
buffer db ?
y_1 dw ?
y_2 dw ?

message_1 db 13,10,"x = ", "$"
message_2 db 13,10,"a = ", "$"
result_1 db 13,10,"y_1 = ","$"
result_2 db 13,10,"y_2 = ","$"
result db 13,10,"y = ","$"
const_1 db 2d
.code
start:
mov ax, @data
mov ds, ax

Clear_screen MACRO ;макрос для очистки регистров
push ax
push bx
push cx
push dx

xor ax, ax ;очищаем регистры
xor bx, bx
xor cx, cx
xor dx, dx

pop ax
pop bx
pop cx
pop dx
ENDM Clear_screen

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

mReadAX MACRO buffer, size ;макрос чтения введенных значений
local input, startOfConvert, endofConvert
push bx
push cx
push dx

input:
mov [buffer], size
mov dx, offset [buffer]
mov ah, 0ah
int 21h

mov ah, 02h
mov dl, 0Dh
int 21h

mov ah, 02h
mov dl, 0Ah
int 21h

xor ah, ah
cmp ah, [buffer][1]
jz input

xor cx, cx
mov cl, [buffer][1]

xor ax, ax
xor bx, bx
xor dx, dx
mov bx, offset [buffer][2]

cmp [buffer][2], "-"
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

cmp [buffer][2], "-"
jne endofConvert
neg ax

endofConvert:
pop dx
pop cx
pop bx

endm mReadAX

;---------------------------------------------------------------------------------------------------------------------------------------------------------

Clear_screen
Output message_1
Clear_screen

mReadAX buffer, 5
mov x, ax
push ax ;временно помещаем значение x в стэк

Clear_screen
Output message_2
Clear_screen

mReadAX buffer, 5
mov a ,ax 
pop ax

;---------------------------------------------------------------------------------------------------------------------------------------------------------
Y1:

mov ax, x
mov bx, a
cmp ax, 7; сравниваем x с 7
JLE L1 ;x<=7

add ax, 15
push ax
Output result_1 
pop ax
mov y_1, ax
mWriteAx
jmp Y2

L1:

cmp bx,0
JL NegativeBx

add bx,9
mov ax, bx

push ax
Output result_1 
pop ax
mWriteAx
mov y_1, ax
jmp Y2

NegativeBx:
neg bx
jmp L1

;---------------------------------------------------------------------------------------------------------------------------------------------------------

Y2:
xor ax,ax
xor bx,bx
mov ax, x
mov bx, a

cmp ax, 2
JLE L2 ;x<=2

mov ax, 3
push ax
Output result_2
pop ax
mov y_2, ax
mWriteAx
jmp Exit_Programm

L2:
cmp ax,0
JL NegativeAx

sub ax, 5
push ax
Output result_2
pop ax
mov y_2, ax
mWriteAx
jmp Exit_Programm

NegativeAx:
neg ax
jmp L2

;---------------------------------------------------------------------------------------------------------------------------------------------------------

Exit_Programm:
xchg ax, y_1
cwd
idiv y_2
push ax
Output result
pop ax
mWriteAx

mov ax, 4c00h
int 21h
end start
end
