.MODEL SMALL
.STACK 100H
.DATA

MSG1 DB 'SACHIN TENDULKAR $'
MSG2 DB 'LIONEL MESSI $'
.CODE  
  
MAIN PROC
    
      MOV AX,@DATA  ; INITIALIZATION OF DATA SEGMENT
      MOV DS,AX        
    
      LEA DX,MSG1   ;Load Effective Address
      MOV AH,9
      INT 21H
    
    MOV AH,2
    MOV DL, 0DH
    INT 21H       ;NEWLINE
    MOV DL, 0AH
    INT 21H
    
    LEA DX,MSG2
      MOV AH,9
      INT 21H
    
    EXIT:
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP
END MAIN
    