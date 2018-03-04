.MODEL SMALL
.STACK 100H
.DATA
.CODE
data segment
    LIST DB 05H, 31H, 34H, 30H, 38H, 37H
    MINIMUM DB ?
    MAXIMUM DB ?
    AVARAGE DB ?
    **SIZE=$-OFFSET LIST**
ends

stack segment       **

    DW 128 DUP(0)   **

ends                **

code segment
start proc far



    MOV AX,DATA      **
    MOV DS,AX        **
    MOV ES,AX        **



**                                    
MOV CX,SIZE  


AGAIN1:


 LEA SI,LIST
 LEA DI,MINIMUM
 MOV AL,[SI]
 CMP AL,[SI+1]
 If carry flag=1:{I got no idea}

LOOP AGAIN1

AGAIN2:


 LEA SI,LIST
 LEA DI,MINIMUM
 MOV AL,[SI]
 CMP AL,[SI-1]        



LOOP AGAIN2


**


    MOV AX,4C00H
    INT 21H

start endp

ends

end start 

ret