.MODEL SMALL
.STACK 100H

.DATA      
    PROMPT_1 DB 'Enter int 1:$'
    PROMPT_2 DB 'Enter int 2:$'
    PROMPT_3 DB 'SUB: $' 
    
    VALUE_1 DB ?
    VALUE_2 DB ?   

.CODE
    MAIN PROC
        
        MOV AX, @DATA
        MOV DS, AX
        
        MOV AH, 09H
        LEA DX, PROMPT_1
        INT 21H
        
        MOV AH, 01H
        INT 21H
        SUB AL, 30H
        
        MOV VALUE_1, AL
        
        MOV AH, 02H
        MOV DL, 0DH
        INT 21H  
        MOV DL, 0AH
        INT 21H
        
        MOV AH, 09H
        LEA DX, PROMPT_2
        INT 21H
        
        MOV AH, 01H
        INT 21H
        SUB AL, 30H
        
        MOV VALUE_2, AL
        
        MOV AH, 02H
        MOV DL, 0DH
        INT 21H  
        MOV DL, 0AH
        INT 21H
        
        MOV AH, 09H
        LEA DX, PROMPT_3
        INT 21H
        
        MOV AL, VALUE_1
        SUB AL, VALUE_2
        AAS
              
        MOV CL, 04H
        MOV BL, AL
        SHR AL, CL
        MOV BH, AL
        MOV AL, BL
        AND AL, 0FH
        MOV BL, AL
        
        MOV AH, 02H
        MOV DL, BH
        ADD DL, 30H
        INT 21H
        MOV DL, BL
        ADD DL, 30H
        INT 21H
        
        MOV AH, 4CH
        INT 21H
        
    MAIN ENDP
END MAIN
        
    