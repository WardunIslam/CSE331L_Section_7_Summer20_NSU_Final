.MODEL SMALL
.STACK 100H

.DATA
    PROMPT_1 DB 'Enter int 1: $'
    PROMPT_2 DB 'Enter int 2: $'
    PROMPT_3 DB 'Smallest int: $'
    
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
        LEA BX, VALUE_1
        MOV [BX], AL
        
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
        LEA BX, VALUE_2
        SUB AL, 30H
        MOV [BX], AL
         
        MOV AH, 02H
        MOV DL, 0DH
        INT 21H 
        MOV DL, 0AH
        INT 21H
        
        MOV AH, 09H
        LEA DX, PROMPT_3
        INT 21H
        
        MOV BL, VALUE_1
        MOV BH, VALUE_2
        CMP BL, BH
        JLE @SMALL

        MOV AH, 02H
        MOV DL, BH
        ADD DL, 30H
        INT 21H 
        JMP @END
        
@SMALL:
        MOV AH, 02H
        MOV DL, BL
        ADD DL, 30H
        INT 21H
        

@END:        
        MOV AH, 4CH
        INT 21H
        
    MAIN ENDP
END MAIN
        
         