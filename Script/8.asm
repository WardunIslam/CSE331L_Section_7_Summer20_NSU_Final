.MODEL SMALL
.STACK 100H

.DATA
    PROMPT_1 DB 'Enter int 1: $'
    PROMPT_2 DB 0DH, 0AH, 'Enter int 2: $'
    PROMPT_3 DB 0DH, 0AH, 'MUL: $'
    ERROR DB 0DH, 0AH, 'Error in input. Try again.$'
 
.CODE
    MAIN PROC
        
        MOV AX, @DATA
        MOV DS, AX
        JMP @INPUT1
        
@ERROR1:
        MOV AH, 09H
        LEA DX, ERROR
        INT 21H
        MOV AH, 02H
        MOV DL, 0DH
        INT 21H
        MOV DL, 0AH
        INT 21H
        

@INPUT1: 
        MOV AH, 09H
        LEA DX, PROMPT_1
        INT 21H       
        MOV CL, 02H 
        MOV BX, 00H
        MOV AH, 01H
        
@INP1:        
        INT 21H
        CMP AL, 0DH
        JE @CHECKCOUNT1
        CMP AL, '0'
        JL @ERROR1
        CMP AL, '9'
        JG @ERROR1
        SUB AL, 30H
        MOV BL, AL
        DEC CL
        
        INT 21H
        CMP AL, 0DH
        JE @CHECKCOUNT1
        CMP AL, '0'
        JL @ERROR1
        CMP AL, '9'
        JG @ERROR1
        SUB AL, 30H
        MOV DL, AL
        MOV CL, 0AH
        MOV AL, BL
        MUL CL
        MOV BL, AL
        ADD BL, DL
        JMP @INPUT2       
        
@CHECKCOUNT1:
        CMP CL, 02H
        JE @ERROR1
        JMP @INPUT2 
 
        
@ERROR2:
        MOV AH, 09H
        LEA DX, ERROR
        INT 21H
        

@INPUT2: 
        MOV AH, 09H
        LEA DX, PROMPT_2
        INT 21H       
        MOV CL, 02H
        MOV AH, 01H
        
@INP2:        
        INT 21H
        CMP AL, 0DH
        JE @CHECKCOUNT2
        CMP AL, '0'
        JL @ERROR2
        CMP AL, '9'
        JG @ERROR2
        SUB AL, 30H
        MOV BH, AL
        DEC CL
        
        INT 21H
        CMP AL, 0DH
        JE @CHECKCOUNT2
        CMP AL, '0'
        JL @ERROR2
        CMP AL, '9'
        JG @ERROR2
        SUB AL, 30H
        MOV DL, AL
        MOV CL, 0AH
        MOV AL, BH
        MUL CL
        MOV BH, AL
        ADD BH, DL
        JMP @CALC       
        
@CHECKCOUNT2:
        CMP CL, 02H
        JE @ERROR2
        
        
@CALC: 
        MOV AL, BH
        MUL BL
        
        
@OUTPUT: 
        MOV BX, AX
        MOV AH, 09H
        LEA DX, PROMPT_3
        INT 21H
        MOV AX, BX
        MOV DX, 0000H
        MOV CX, 1000
        DIV CX
        MOV BX, DX
        ADD AL, 30H
        MOV DL, AL
        MOV AH, 02H
        INT 21H
        
        MOV AX, BX
        MOV DX, 0000H
        MOV CX, 100
        DIV CX
        MOV BX, DX
        ADD AL, 30H
        MOV DL, AL
        MOV AH, 02H
        INT 21H
        
        MOV AX, BX
        MOV DX, 0000H
        MOV CX, 10
        DIV CX
        MOV BX, DX
        ADD AL, 30H
        MOV DL, AL
        MOV AH, 02H
        INT 21H
        MOV DL, BL
        ADD DL, 30H
        INT 21H
        
        
        
        
    MAIN ENDP
END MAIN
        
        