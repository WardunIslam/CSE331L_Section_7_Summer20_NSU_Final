.MODEL SMALL
.STACK 100H

.DATA      
    PROMPT_1 DB 'Enter the int: $'
    PROMPT_2 DB ' is an odd number.$'
    PROMPT_3 DB ' is an even number.$'   

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
        MOV CL, AL
        
        
        MOV AH, 02H
        MOV DL, 0DH
        INT 21H  
        MOV DL, 0AH
        INT 21H
        

        
L3:     MOV AH, 0000H
        MOV AL, CL
        MOV BL, 02H
        DIV BL
    
L4:     TEST AH, 00H
        JZ EVEN
    
ODD:    MOV AH, 02
        MOV DL, CL
        ADD DL, 30H
        INT 21H 
        MOV AH, 09H
        LEA DX, PROMPT_2
        INT 21H
        JMP L5
        
EVEN:   MOV AH, 02
        MOV DL, CL
        ADD DL, 30H
        INT 21H 
        MOV AH, 09H
        LEA DX, PROMPT_3
        INT 21H
            
L5:     MOV AH, 4CH
        INT 21H
        
    MAIN ENDP
END MAIN
