.MODEL SMALL
.STACK 100H

.DATA
    PROMPT_1 DB 'Number in HEX: $'
    PROMPT_2 DB 0DH, 0AH,'Number in Binary: $'
    ILLEGAL DB 0DH, 0AH,'Illegal hex number. Try again.$', 0DH, 0AH
    COUNT DB ?
    
.CODE
    MAIN PROC
        
        MOV AX, @DATA
        MOV DS, AX
        JMP @INPUT
        
@ERROR:
        MOV AH, 09H
        LEA DX, ILLEGAL
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
        MOV BX, 00H
        MOV AH, 01H
        MOV CX, 04H
        MOV COUNT, 00H

@L1:    INT 21H 

        CMP AL, 0DH
        JE @OUTPUT
        
        CMP AL, 30H
        JL @ERROR 
        
        CMP AL, 39H
        JLE @DIGIT
        
        CMP AL, 41H
        JL @ERROR 
        
        CMP AL, 46H
        JLE @UPPERLETTER 
        
        CMP AL, 61H
        JL @ERROR  
        
        CMP AL, 66H
        JG @ERROR
        
@LOWERLETTER: 
        SUB AL, 57H
        PUSH CX
        MOV CL, 04H
        SHL BX, CL
        OR BL, AL
        MOV CL, COUNT
        INC CL
        MOV COUNT, CL
        POP CX
        LOOP @L1
        JMP @OUTPUT
        

@UPPERLETTER: 
        SUB AL, 37H
        PUSH CX
        MOV CL, 04H
        SHL BX, CL
        OR BL, AL
        MOV CL, COUNT
        INC CL
        MOV COUNT, CL
        POP CX
        LOOP @L1
        JMP @OUTPUT

@DIGIT:
        SUB AL, 30H
        PUSH CX
        MOV CL, 04H
        SHL BX, CL
        OR BL, AL
        MOV CL, COUNT
        INC CL
        MOV COUNT, CL
        POP CX
        LOOP @L1
        
        
@OUTPUT: 
       MOV AH, 09H
       LEA DX, PROMPT_2
       INT 21H
       MOV AH, 02H
       MOV DH, COUNT
       SHL DH, 01H
       SHL DH, 01H
       MOV DL, 10H
       SUB DL, DH
       MOV CL, DL
       SHL BX, CL
       MOV DL, COUNT
       SHL DL, 01H
       SHL DL, 01H
       MOV CL, DL
       MOV CH, 00H
           
       
@P1:   SHL BX, 01H
       JC @ONE
       MOV DL, '0'
       INT 21H 
       LOOP @P1
       JMP @END
       
@ONE:  MOV DL, '1'
       INT 21H
       LOOP @P1
       
               
@END:  MOV AH, 4CH
       INT 21H
       
   MAIN ENDP
END MAIN        