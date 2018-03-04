.MODEL SMALL
.STACK 100H 
.DATA
NUM1 DW ?
NUM2 DW ?

.CODE
MAIN PROC
    ;including the data segment
    
    MOV AX, @DATA
    MOV DS, AX
    
    ;taking first input
    
    XOR BX, BX
    MOV CL, 4
    MOV AH, 1
    INT 21H
    
    WHILE_:
    CMP AL, 0DH
    JE CONT1
    
    CMP AL, 39H
    JG LETTER
    
    AND AL, 0FH
    JMP SHIFT
    
    LETTER:
    SUB AL, 37H
    
    SHIFT:
    SHL BX,CL
    OR BL, AL
    
    INT 21H
    JMP WHILE_
             
    CONT1:
    MOV NUM1, BX     ;setting 1st input to num1
    
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    ;taking second input
    
    XOR BX, BX
    MOV CL, 4
    MOV AH, 1
    INT 21H
    
    WHILE1_:
    CMP AL, 0DH
    JE CONT2
    
    CMP AL, 39H
    JG LETTER1
    
    AND AL, 0FH
    JMP SHIFT1
    
    LETTER1:
    SUB AL, 37H
    
    SHIFT1:
    SHL BX,CL
    OR BL, AL
    
    INT 21H
    JMP WHILE1_
             
    CONT2:
    MOV NUM2, BX       ;setting 2nd input to num2
    
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    MOV AX, NUM1
    ADD AX, NUM2       ;adding the numbers
    
    MOV BX, AX         ;moving the sum to BX
    
    
    MOV CX, 4          ;setting counter register to 4
    
    TOP:
     
    MOV DL, BH        ;moving BH(high part of result) to DL(output register)
    SHR DL, 4        ;shifting DL 4 times to right
    
    CMP DL, 1001B
    JG ELSE_
            
    MOV AL, DL
    ADD AL, 30H
    MOV DL, AL
            
    JMP DISPLAY
    
    ELSE_:
    MOV AL, DL
    ADD AL, 37H
    MOV DL, AL
    
    DISPLAY:
    MOV AH, 2          
    INT 21H
    
    SHL BX, 4
    
    LOOP TOP                                               
          
    MAIN ENDP
END MAIN