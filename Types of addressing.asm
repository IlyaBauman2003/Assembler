.model small
.stack 100h
.data
B_TAB db 1Ah, 2Bh, 3Ch, 4Dh, 5Eh,6Fh, 7Ah,8Bh
W_TAB dw 1A2Bh, 3C4Dh, 5E6Fh, 7A8Bh
B_TAB1 db 0Ah, 8 dup(1)
W_TAB1 dw 8 dup(1)
W_TAB2 dw 12h, 13h, 14h, 15h, 16h, 17h, 18h
.code
start:

mov ax, @data
mov ds, ax

mov ax, 0600h ;очищаем экран
mov bh, 02h ;черный фон и зелёный текст
mov cx, 0000
mov dx, 184fh
int 10h

; Непосредственная (операнд источник) адресация

mov al, -3
mov ax, 3
mov B_TAB, -3
mov W_TAB, -3
mov ax, 2A1Bh

; Регистровая адресация

mov bl, al
mov bh, al
sub ax, bx
sub ax, ax

; прямая адресация

mov ax, W_TAB
mov ax, W_TAB+3
mov ax, W_TAB+5
mov al, byte ptr W_TAB+6
mov al, B_TAB
mov al, B_TAB+2
mov ax, word ptr B_TAB
mov es:W_TAB2+4, ax

; Косвенная адресация

mov bx, offset B_TAB
mov si, offset B_TAB+1
mov di, offset B_TAB+2
mov dl, [bx]
mov dl, [si]
mov dl, [di]
mov ax, [di]
mov bp, bx
mov al, [bp]
mov al, ds:[bp]
mov al, es:[bx]
mov ax, cs:[bx]

; базовая адресация

mov ax, [bx]+2
mov ax, [bx]+4
mov ax, [bx+2]
mov ax, [4+bx]
mov ax, 2+[bx]
mov ax, 4+[bx]
mov al, [bx]+2
mov bp, bx
mov ax, [bp+2]
mov ax, ds:[bp]+2
mov ax, ss:[bx+2]

; индексная адресация

mov si, 2
mov ah, B_TAB[si]
mov al, [B_TAB+si]
mov bh, [si+B_TAB]
mov bl, [si] + B_TAB
mov bx, es:W_TAB2[si]
mov di, 4
mov bl, byte ptr es:W_TAB2[di]
mov bl, B_TAB[si]

; Базовая индексная адресация

mov bx, offset B_TAB
mov al, 3[bx][si]
mov ah, [bx+3][si]
mov al, [bx][si+2]
mov ah, 3[bx+si+2]
mov bp, bx
mov ah, 3[bp][si]
mov ax, ds:3[bp][si]
mov ax, word ptr ds:2[bp][si]


mov ah, 7h ;заморозка экрана
int 21h

mov ax, 4c00h ;завершение программы
int 21h

end start



























