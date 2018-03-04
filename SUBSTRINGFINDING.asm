.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'ENTER SUB_STRING : ',0DH,0AH,'$'
    MSG2 DB 0DH,0AH,'ENTER MAIN_STRING : ','$'
    MAINST DB 80 DUP (0)
    SUBST DB 80 DUP (0)
    STOP DW ?
    START DW ?
    SUB_LEN DW ?
    YESMSG DB 0DH,0AH,'Yes!!! Present$'
    NOMSG DB 0DH,0AH,'No!!! Not Present$'
    
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX
    
    ;ENTER STRING TO FIND MSG
    MOV AH, 9
    LEA DX, MSG1
    INT 21H
    
    ;ENTER STRING
    LEA DI, SUBST
    CALL READ_STR
    MOV SUB_LEN, BX
    
    ;ENTER MAIN TEXT MSG
    LEA DX, MSG2
    INT 21H
    
    ;ENTER TEXT
    LEA DI, MAINST
    CALL READ_STR
    
    ;SEE IF STRING IS NULL OR SUBSET LONGER THAN MAINST
    OR BX, BX
    JE NO
    CMP SUB_LEN, 0
    JE NO
    CMP SUB_LEN, BX
    JG NO
    
    ;SEE IF SUBST IS A SUBSTRING OF MAINST
    LEA SI, SUBST
    LEA DI, MAINST
    CLD
    
    ;COMPUTE STOP
    MOV STOP, DI
    ADD STOP, BX
    MOV CX, SUB_LEN
    SUB STOP, CX
    
    ;INITIALIZE START
    MOV START, DI
    
REPEAT:
    ;COMPARE CHARECTERS
    MOV CX, SUB_LEN
    MOV DI, START
    LEA SI, SUBST
    REPE CMPSB
    JE YES
    
    ;SUBSTRING NOT FOUND YET
    INC START
    
    ;SEE IF START <= STOP
    MOV AX, START
    CMP AX, STOP
    JNLE NO
    JMP REPEAT
    
;DISPLAY RESULT
YES:
    LEA DX, YESMSG
    JMP DISPLAY
    
NO:
    LEA DX, NOMSG
    
DISPLAY:
    MOV AH, 9
    INT 21H
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP
READ_STR PROC NEAR
    PUSH AX
    PUSH DI
    CLD
    XOR BX, BX
    MOV AH, 1
    INT 21H
    
WHILE1:
    CMP AL, 0DH
    JE END_WHILE1
    
    CMP AL, 8H
    JNE ELSE1
    
    DEC DI
    DEC BX
    JMP READ
    
ELSE1:
    STOSB
    INC BX
    
READ:
    INT 21H
    JMP WHILE1
    
END_WHILE1:
    POP DI
    POP AX
    RET
READ_STR ENDP
    
    
END MAIN