.model small
.386
.stack 100h
.data
N dw ?
bf db 15 dup(0)
mas dw 15 dup(?)
count dw 0
message_1 db 13,10,"N(N<=15) = ","$"
message_2 db 13,10,"Value = ","$"
message_4 db 13,10,"Our array: ","$"
result db 13,10,"Result: ","$"
error db "Error ","$"
delimeter db 13,10,"--------------------------------------------","$"
probel db " ", "$"
.code
start:
mov ax, @data
mov ds, ax

;-----------------------------------------------------------------

Clear MACRO ;макрос для очистки регистров
xor ax, ax ;очищаем регистры
xor bx, bx
xor cx, cx
xor dx, dx
ENDM Clear

;-----------------------------------------------------------------

Output MACRO str ;макрос для вывода сообщений на экран
push ax
push bx
push cx
push dx
push si

mov ah, 09h
mov dx, offset str
int 21h

pop si
pop dx
pop cx
pop bx
pop ax
ENDM Output 

;-----------------------------------------------------------------

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

;-----------------------------------------------------------------

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

;-----------------------------------------------------------------

L1:
Clear
Output message_1 
mReadAX bf, 5 ;считывание N
cmp ax, 15
jg L1
cmp ax, 0
jle L1

mov N, ax


;-----------------------------------------------------------------

xor si, si
mov cx, N

input: ;чтение массива
Output message_2
mReadAX bf, 5
mov mas[si], ax
inc si
inc si
loop input

;-----------------------------------------------------------------

Output delimeter
Output message_4
Clear

;-----------------------------------------------------------------

mov ax, 1

Loop_external:
    cmp ax, 1
	  jnz l4
	  mov ax, 0
	  mov cx, N
	  dec cx
	  mov si, offset mas
    Loop_internal:
	    mov bx, word ptr[si]
	    mov dx, word ptr[si+2]
	    cmp bx, dx
	    jng nochange
	    mov word ptr[si+2], bx
	    mov word ptr[si], dx
	    mov ax, 1
  nochange:
	  add si, 2
loop Loop_internal
jmp Loop_external



l4:

mov cx, N
xor si, si


output_cycle: ;вывод массива
mov ax, mas[si]
mWriteAx
Output probel
inc si
inc si
loop output_cycle

;-----------------------------------------------------------------

Output delimeter
Clear

;-----------------------------------------------------------------


Exit:
mov ah, 07h
int 21h

mov ax, 4c00h
int 21h
end start
end
