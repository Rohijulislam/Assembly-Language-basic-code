
.model small
.stack 100h
.data
msgstar		db 0dh,0ah,0dh,0ah,"*******************************************************************************",0dh,0ah,"$"
msgintro	db "                                 PROGRAM FUNCTION",0dh,0ah,
				   "                      
msginput	db  0dh,0ah,"Your HEXADECIMAL INPUT (MAXIMUM FF) :",0dh,0ah,"$"
msgafter	db 	0dh,0ah,"Your INPUT AFTER CONVERT INTO BINARY : ",0dh,0ah,"$"
msgagain	db	0dh,0ah,0dh,0ah,"DO YOU WANT TO TRY AGAIN ?",0dh,0ah,"PRESS (y OR Y) TO TRY AGAIN,PRESS OTHER KEY TO TERMINATE:",0dh,0ah,"$"
msgmax		db	0dh,0ah,0dh,0ah,"YOUR INPUT HAD REACH MAXIMUM 8 DIGITS / BIT , CALCULATION WILL START NOW",0dh,0ah,"$"
blank		db	0dh,0ah,"$"
error		db  0dh,0ah,"INVALID INPUT, ONLY 1 AND 0 IS ALLOW. PROGRAM WILL TERMINATE NOW.",0dh,0ah,"$"
print		dw	0
count		dw	0
num		dw	0
.code
main	proc
		mov ax,@data
		mov ds,ax
		
		mov ax,0
		mov bx,0
		mov cx,0
		mov dx,0
		mov print,0	; reset evrything used in program to makesure the calculation will be correct
		mov count,0	; after user request repeat
		mov num,0
		
		mov dx,offset msgstar ;display start (decoration)
		mov ah,9
		int 21h
		
		mov dx,offset msgintro ;display intro message
		mov ah,9
		int 21h
		
		mov dx,offset msgstar ;display start (decoration)
		mov ah,9
		int 21h
		
		
		mov	dx,offset msginput ;display input message
		mov ah,9
		int 21h
		
		mov cx,-1 ; assign -1 into cx to act as counter
		
	
input:	mov ah, 00h
		int 16h
		cmp ah, 1ch
		je exit
number: cmp al, '0'
		jb input
		cmp al, '9'
		ja uppercase
		sub al, 30h
		call process
		jmp input
uppercase: 	cmp al, 'A'
	   		 jb input
		    cmp al, 'F'
			ja lowercase
			sub al, 37h
			call process
			jmp input
lowercase: 	cmp al, 'a'
			jb input
			cmp al, 'f'
			ja input
			sub al, 57h
			call process
			jmp input
			loop input
process: 	mov ch, 4
			mov cl, 3
			mov bl, al
convert:	mov al, bl
			ror al, cl
			and al, 01
			add al, 30h
			mov ah, 02h
			mov dl, al
			int 21h
			dec cl
			dec ch
			jnz convert
			mov dl, 20h
			int 21h
ret
exit:
int 20h
	
	
main EndP
end main