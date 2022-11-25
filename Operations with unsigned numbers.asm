.model small
.stack 100h
.data
a db 2d
b db 1d
x db 5d
coef1 db 2h
.code
start:
mov ax, @data
mov ds, ax

mov ah, 00
mov al, a
mov bx, ax
mul bx
mul bx
mul coef1
mul x

mov cx, ax

mov al, a
add ax, 4

mov bx, ax

mov ah,00
mov al, b
mul coef1
add al, 1

xchg bx, ax

div bl
mov bl, al

sub cx, bx
mov ax, cx
end start
end
