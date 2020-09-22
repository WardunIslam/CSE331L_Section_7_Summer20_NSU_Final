.MODEL SMALL
.STACK 100H

.DATA   
    MSG_1 DB 'Lower-Case: $'
    MSG_2 DB 'Upper-Case: $' 
    
    CHAR DB ?

.CODE
    MAIN PROC
        
        MOV AX, @DATA
        MOV DS, AX
        
        MOV AH, 09H
        LEA DX, MSG_1
        INT 21H
        
        MOV AH, 01H
        INT 21H
        
        MOV CHAR, AL
        
        MOV AH, 02H
        MOV DL, 0DH
        INT 21H
        MOV DL, 0AH
        INT 21H
        
        MOV AH, 09H
        LEA DX, MSG_2
        INT 21H
        
        MOV AH, 02H
        MOV DL, CHAR
        SUB DL, 20H
        INT 21H
        
        MOV AH, 4CH
        INT 21H
        
    MAIN ENDP
END MAIN