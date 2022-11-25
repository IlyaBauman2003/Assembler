.model small
.stack 100h
.data
a dw 20d
b dw -10d
x dw 2d
buffer db ?
coef1 dw 2d
.code
start:

mov ax, @data
mov ds, ax

mov ax, a
cwd
imul a;
imul a;
cwd
imul x
imul coef1;

mov cx, ax

mov ax,a
add ax, 4

mov bx, ax

mov ax, b
imul coef1
add ax,1

xchg ax,bx
neg ax
idiv bx
neg ax
mov bx,ax

sub cx, bx

mov ax,cx

mov ax, 4c00h
int 21h

end start
end

