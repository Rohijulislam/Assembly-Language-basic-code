.MODEL SMALL
.STACK 100H
.DATA
    STR1 DB 'WE ARE CSE14'
    STR2 DB 12 DUP (?), '$'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES,AX
    LEA SI,STR1+11
    LEA DI,STR2
    STD
    
    MOV CX,12
MOVE:
    MOVSB
    ADD DI, 2 
    LOOP MOVE
    
    LEA DX, STR2
    MOV AH,9
    INT 21H
    
    MAIN ENDP
END MAIN
