.MODEL SMALL
.STACK 100H
.CODE

MAIN PROC
    
    MOV AH,1
    INT 21H     ;INPUT   //MULTILINE COMMENT IS NOT POSSIBLE.
    MOV BL,AL    
    
    MOV AH,2     
    MOV DL,BL   ;OUTPUT
    INT 21H
    
    
    EXIT: 
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP     
END MAIN