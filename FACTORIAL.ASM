.MODEL SMALL
.STACK 100H 
.DATA
.CODE

MAIN PROC
     
    MOV AX,1
    INT 21H
TOP:
    MUL CX
    LOOP TOP
    MOV BX,AX
    MOV AH,2
    MOV DX,BX
    INT 21H
    ;RET
MAIN ENDP

END MAIN     
