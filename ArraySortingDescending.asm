.MODEL SMALL
.STACK 100H
.DATA
A DB 5,2,1,3,4
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    LEA SI,A
    MOV BX,5
    CALL SELECT 
    SUB SI,SI
    LEA BX,A
    
    loop1:
    MOV DX, [BX + SI] 

    ADD DX, 30H 
    MOV AH, 2H
    int 21H    

    INC SI
    CMP SI, 5
    MOV AH,2
    MOV DL,' '
    INT 21H
    JNE loop1
    
   
    MOV AH,4CH
    INT 21H   
    MAIN ENDP
    
SELECT PROC
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    DEC BX;N=N-1
    JE END_SORT
    MOV DX,SI
    
SORT_LOOP:
    MOV SI,DX
    MOV CX,BX
    MOV DI,SI
    MOV AL,[DI]
FIND_BIG:
    INC SI
    CMP [SI],AL
    JNL NEXT                                         
    MOV DI,SI
    MOV AL,[DI]
NEXT:
    LOOP FIND_BIG
    CALL SWAP
    DEC BX
    JNE SORT_LOOP
END_SORT:
    POP SI
    POP DX
    POP CX
    POP BX
    RET
    SELECT ENDP
SWAP PROC
    PUSH AX
    MOV AL,[SI]
    XCHG AL,[DI]
    MOV [SI],AL
    POP AX
    RET
SWAP ENDP    


END MAIN
    