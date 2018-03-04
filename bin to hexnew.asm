.MODEL SMALL
.STACK 1000h

.DATA
  title db 'Convert BIN to HEX:.',13,10,'$'
  HEX_Map   DB  '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'
  HEX_Out   DB  "00", 13, 10, '$'   ; string with line feed and '$'-terminator

.CODE

main PROC
    mov ax, @DATA                   ; Initialize DS
    mov ds, ax

    mov ah, 0                                
    mov al, 3                ;clearing                                                 
    int 10h                                                                  

    mov ah, 9                                                                 
    lea dx, title                                                          
    int 21h     ;displays title

    mov dx, 0

loop16:                                                                   
    mov cx, 16  ;loop goes 16 Times because I need 16 bit binary input
    mov bx, 0 

;here I'm checking if input numer is 0 or 1, but it doesn't work as I want      
read:                                                                       
    mov ah, 10h                                                                 
    int 16h                          

    cmp al, '0'                                                                 
    jb read                                                                         

    cmp al, '1'                                                               
    ja read10   



read10:                                                                       
    mov ah, 0eh                                                                 
    int 10h                                                                     
    sub al, 48  ;conversion, sub 48 from ascii since 0 is on 48th place in ascii, but I'm not sure if this part is must to be or not                    

    jmp end_loop 

end_loop:                                                                 
    mov ah, 0       ;ah=0 so we can add ax to bx        
    add bx, ax              

    loop read           
    push bx                         ;here I push bx on stack, bx is as my input number                                          

    mov al, 13
    mov ah, 0eh
    int 10h

    mov al, 10
    mov ah, 0eh
    int 10h 



    mov di, OFFSET HEX_Out          ; First argument: pointer
    pop bx                          ;Here I take input number from stack
    mov ax, bx
    call IntegerToHexFromMap        ; Call with arguments
    mov ah, 09h                     ; Int 21h / 09h: Write string to STDOUT
    mov dx, OFFSET HEX_Out          ; Pointer to '$'-terminated string
    int 21h                         ; Call MS-DOS

    mov ah, 10h                                                                 
    int 16h 

    mov ax, 4C00h                   ; Int 21h / 4Ch: Terminate program (Exit code = 00h)
    int 21h                         ; Call MS-DOS
main ENDP

IntegerToHexFromMap PROC
    mov si, OFFSET Hex_Map          ; Pointer to hex-character table

    mov bx, ax                      ; BX = argument AX
    and bx, 00FFh                   ; Clear BH (just to be on the safe side)
    shr bx, 1
    shr bx, 1
    shr bx, 1
    shr bx, 1                       ; Isolate high nibble (i.e. 4 bits)
    mov dl, [si+bx]                 ; Read hex-character from the table
    mov [di+0], dl                  ; Store character at the first place in the output string

    mov bx, ax                      ; BX = argument AX
    and bx, 00FFh                   ; Clear BH (just to be on the safe side)
    shr bx, 1
    shr bx, 1
    shr bx, 1
    shr bx, 1                       ; Isolate high nibble (i.e. 4 bits)
    mov dl, [si+bx]                 ; Read hex-character from the table
    mov [di+1], dl                  ; Store character at the first place in the output string

    mov bx, ax                      ; BX = argument AX
    and bx, 00FFh                   ; Clear BH (just to be on the safe side)
    shr bx, 1
    shr bx, 1
    shr bx, 1
    shr bx, 1                       ; Isolate high nibble (i.e. 4 bits)
    mov dl, [si+bx]                 ; Read hex-character from the table
    mov [di+2], dl                  ; Store character at the first place in the output string

    mov bx, ax                      ; BX = argument AX (just to be on the safe side)
    and bx, 00FFh                   ; Clear BH (just to be on the safe side)
    and bl, 0Fh                     ; Isolate low nibble (i.e. 4 bits)
    mov dl, [si+bx]                 ; Read hex-character from the table
    mov [di+3], dl                  ; Store character at the second place in the output string

    ret
IntegerToHexFromMap ENDP

IntegerToHexCalculated PROC
    mov si, OFFSET Hex_Map          ; Pointer to hex-character table

    mov bx, ax                      ; BX = argument AX
    shr bl, 1
    shr bl, 1
    shr bl, 1
    shr bl, 1                       ; Isolate high nibble (i.e. 4 bits)
    cmp bl, 10                      ; Hex 'A'-'F'?
    jl .1                           ; No: skip next line
    add bl, 7                       ; Yes: adjust number for ASCII conversion
    .1:
    add bl, 30h                     ; Convert to ASCII character
    mov [di+0], bl                  ; Store character at the first place in the output string

    mov bx, ax                      ; BX = argument AX
    shr bl, 1
    shr bl, 1
    shr bl, 1
    shr bl, 1                       ; Isolate high nibble (i.e. 4 bits)
    cmp bl, 10                      ; Hex 'A'-'F'?
    jl .2                           ; No: skip next line
    add bl, 7                       ; Yes: adjust number for ASCII conversion
    .2:
    add bl, 30h                     ; Convert to ASCII character
    mov [di+1], bl                  ; Store character at the first place in the output string

    mov bx, ax                      ; BX = argument AX
    shr bl, 1
    shr bl, 1
    shr bl, 1
    shr bl, 1                       ; Isolate high nibble (i.e. 4 bits)
    cmp bl, 10                      ; Hex 'A'-'F'?
    jl .3                           ; No: skip next line
    add bl, 7                       ; Yes: adjust number for ASCII conversion
    .3:
    add bl, 30h                     ; Convert to ASCII character
    mov [di+2], bl                  ; Store character at the first place in the output string

    mov bx, ax                      ; BX = argument AX (just to be on the safe side)
    and bl, 0Fh                     ; Isolate low nibble (i.e. 4 bits)
    cmp bl, 10                      ; Hex 'A'-'F'?
    jl .4                           ; No: skip next line
    add bl, 7                       ; Yes: adjust number for ASCII conversion
    .4:
    add bl, 30h                     ; Convert to ASCII character
    mov [di+3], bl                  ; Store character at the second place in the output string

    ret
IntegerToHexCalculated ENDP

END main                            ; End of assembly with entry-procedure