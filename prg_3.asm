.model small
.stack 100h
.data
num_1 db 22
num_2 db 3
num_3 db 45
num_4 db 6
num_5 db 14
num_6 db 134
num_7 db 7
num_8 db 5
num_9 db 13
num_10 db 2
num_11 db 4
.code
start:
mov ax, @data
mov ds, ax

mov ah, 00
mov al, num_1
mul num_2

mov bl, al
xor ax,ax

mov al, num_3
div num_4

mov cl, al
xor ax,ax

sub bl,cl

mov al, bl
div num_5

mov dl, al
xor ax,ax
xor bx,bx
xor cx,cx

mov al, num_7
mul num_8
mov bl, num_6
sub bl, al
xchg al,bl
div num_9

mov bl, al
mov ah,00
mov al, dl
div bl
mul num_10
add al, num_11

end start
end