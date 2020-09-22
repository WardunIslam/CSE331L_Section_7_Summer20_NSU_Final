.MODEL SMALL
.STACK 100H

.DATA
    PROMPT_1 DB 'AL: $'
    PROMPT_2 DB 0DH,0AH,'Divide SHR by 4: $'
    ERROR DB 0DH,0AH,'Error in input. Try again.$'
     
    
.CODE
    MAIN PROC
    
        MOV AX, @DATA
        MOV DS, AX
        JMP @INPUT
        
@ERROR:
        MOV AH, 09H
        LEA DX, ERROR
        INT 21H
        MOV AH, 02H
        MOV DL, 0DH
        INT 21H
        MOV DL, 0AH
        INT 21H
        
        
@INPUT:
        MOV AH, 09H
        LEA DX, PROMPT_1
        INT 21H
        
        MOV AH, 01H
        MOV CX, 03H
        
@INP:   
        INT 21H
        CMP AL, 0DH
        JE @CHECKCOUNT
        JMP @L1
        
@CHECKCOUNT:
        CMP CX, 0003H
        JE @ERROR
        JMP @CALC
        
@L1:    CMP AL, '0'
        JL @ERROR
        CMP AL, '9'
        JG @ERROR
            
@L2:    SUB AL, 30H
        MOV BH, AL
        MOV AL, 0AH
        MUL BL
        MOV BL, AL
        ADD BL, BH
        MOV AH, 01H
        LOOP @INP
        
@CALC:
        MOV CL, 02H
        MOV BH, 00H
        SHR BX, CL
        
@OUTPUT:
        MOV AH, 09H
        LEA DX, PROMPT_2
        INT 21H
        
        MOV CX, 03E8H
        MOV DX, 0000H
        MOV AX, BX
        DIV CX
        MOV BX, DX
        ADD AL, 30H
        MOV DL, AL
        MOV AH, 02H
        INT 21H 
        
        MOV CX, 0064H
        MOV DX, 0000H
        MOV AX, BX
        DIV CX
        MOV BX, DX
        ADD AL, 30H
        MOV DL, AL
        MOV AH, 02H
        INT 21H
        
        MOV CX, 000AH
        MOV DX, 0000H
        MOV AX, BX
        DIV CX 
        MOV BL, DL
        ADD BL, 30H
        ADD AL, 30H
        MOV DL, AL
        MOV AH, 02H
        INT 21H
        MOV DL, BL
        INT 21H
        
        
    MAIN ENDP
END MAIN