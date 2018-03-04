.model small
.stack 100h

.data
msg1 db ' Please Enter a binary to be convert to a hex number. Press e for exit ' ,0dh, 0ah, ' $ '
var1 db ?

.code 

main proc

mov ax, @data
mov ds , ax


loop1:
mov ah,09
mov dx, offset msg1
int 21h

enternumber: ;just a label

mov ah , 01h
int 21h

mov var1,al

mov dx,3dh
mov ah,06
int 21h

cmp var1, 65h
jz fin
cmp var1 , 65h


add var1, 30h
sub var1, 16
mov cl ,16

call display

sub var1, 04
mov cl,08

call display

sub var1, 02
mov cl , 02

call display

add var1, 04
mov cl , 08

call display

jmp loop1

letters:

sub var1, 39h
sub var1, 08
mov cl , 08

call display

sub var1, 04
mov cl, 04

call display

sub var1, 02
mov cl , 02

call display

sub var1, 01
mov cl , 01

call display

jmp loop1


display proc

sub var1, 01
js send0

mov dl , 31h
mov ah, 06
int 21h
ret

send0:
mov dl , 30h
mov ah , 06
add var1 , cl
int 21h
ret

display endp

fin:

mov ax,4c00h
int 21h

MAIN ENDP
MAIN END