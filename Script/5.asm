.MODEL SMALL
.STACK 100H

.DATA   
    MSG_1 DB 'Enter the Range: $'
    MSG_2 DB 0AH, 0DH, 'Fib Series: $'

.CODE
    MAIN PROC
        
        MOV AX, @DATA
        MOV DS, AX
        
        MOV AH, 09H
        LEA DX, MSG_1
        INT 21H
        
        MOV AH, 01H
        INT 21H
        SUB AL, 30H
        MOV BL, AL
        
        MOV AH, 02H
        MOV DL, 0DH
        INT 21H
        MOV DL, 0AH
        INT 21H
        
        MOV AH, 09H
        LEA DX, MSG_2
        INT 21H
        MOV CL, BL
        MOV CH, 00H
        MOV BL, 00H
        MOV BH, 01H
        
        
         
        MOV AH, 02H 
        MOV DL, '0'
        INT 21H 
        MOV DL, ' '
        INT 21H
        MOV DL, '1'
        INT 21H 
        MOV DL, ' '
        INT 21H
        
@L1:    
        MOV AH, 02H
        MOV DH, BH
        ADD BH, BL
        MOV BL, DH 
        MOV DL, BH
        ADD DL, 30H
        INT 21H
        MOV DL, ' '
        INT 21H
        LOOP @L1
        
        
        MOV AH, 4CH
        INT 21H
        
    MAIN ENDP
END MAIN