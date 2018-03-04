.MODEL SMALL
.STACK 100H
.DATA
    
    
.CODE
MAIN PROC
    XOR BX, BX
    MOV CL, 4
    MOV AH, 1
    INT 21H
    
WHILE_:
    CMP AL, 0DH
    JE END_WHILE
    
    CMP AL, 39H
    JG LETTER
    
    AND AL, 0FH
    JMP SHIFT
    
LETTER:
    SUB AL, 37H
    
SHIFT:
    SHL BX, CL
    
    OR BL, AL
    
    INT 21H
    JMP WHILE_
    
;AGAIN          
INPUT2:  
    MOV DX, BX   
    XOR BX, BX
    MOV CL, 4
    MOV AH, 1
    INT 21H    
WHILE2_:
    CMP AL, 0DH
    JE END_WHILE2
    
    CMP AL, 39H
    JG LETTER2
    
    AND AL, 0FH
    JMP SHIFT2
    
LETTER2:
    SUB AL, 37H
    
SHIFT2:
    SHL BX, CL
    
    OR BL, AL
    
    INT 21H
    JMP WHILE2_

END_WHILE:
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0DH
    JMP INPUT2         
     
END_WHILE2:
    MOV AX, 0000H
    ADD AX, BX
    ADD AX, DX
    MOV BX, AX

    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
             
MOV CX, 32         
@OUTPUT:                          
       JCXZ EXIT                     
       SHL BX, 1                  
                   
       JNC @ZERO
         MOV DL, 31H
         JMP @DISPLAY            
       JNC @ZERO                  
         MOV DL, 31H              
         JMP @DISPLAY             

       @ZERO:                     
         MOV DL, 30H
         JMP @DISPLAY             
       
       @DISPLAY: 
         DEC CX                   
         INT 21H                  
     LOOP @OUTPUT
EXIT:  

    MAIN ENDP

END MAIN