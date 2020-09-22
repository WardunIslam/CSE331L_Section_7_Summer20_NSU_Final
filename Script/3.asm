.MODEL SMALL
.STACK 100H

.DATA
    PROMPT_1 DB 'Alphabets: $'
    MSG_1 DB 0AH, 0DH, 'Reverse: $'
    
    STR DB 100 DUP(' ')
    STR2 DB 100 DUP(' ')
    COUNT DW ?
    
.CODE
    MAIN PROC
        
        MOV AX, @DATA
        MOV DS, AX
        
@ERROR: 
        MOV AH, 09H
        LEA DX, PROMPT_1
        INT 21H
        
        MOV AH, 01H
        LEA SI, STR
        MOV CX, 0000H 
        
@INPUT:
        INT 21H        
        CMP AL, 0DH 
        JE @CHECKCOUNT
        JMP @L1
        
@CHECKCOUNT:
        CMP CX, 00H
        JNE @EXIT
        JMP @ERROR
        
@L1:
        MOV [SI], AL
        INC CX 
        INC SI
        JMP @INPUT                                  
        
        
@EXIT:  MOV [SI], '$'

        MOV COUNT, CX
        DEC SI
        LEA DI, STR2
        
        MOV AH, 09H
        LEA DX, MSG_1
        INT 21H
        

        
@LOOP2: 
        MOV AH, 02H
        MOV DL, [SI]
        INT 21H 
        
        MOV AH, 02H
        MOV DL, ' '
        INT 21H
         
        DEC SI
        LOOP @LOOP2 
        
        LEA SI, STR
        LEA DI, STR2
        MOV CX, COUNT
        

@ENDPROG:
        MOV AH, 4CH
        INT 21H
        
        
        
    MAIN ENDP
END MAIN