.MODEL SMALL
.STACK 100H

.DATA
CADENA1 DB "  ", "$" ;<----ingresar el texto aquí
CADENA2 DB 80 DUP(' ')
.CODE
MAIN PROC FAR
    MOV AX, @DATA
    MOV DS, AX

    CALL PROCEDIMIENTO
MAIN ENDP

PROCEDIMIENTO PROC
    LEA SI, CADENA1
    LEA DI, CADENA2
    XOR CX, CX
P10:
    MOV AL, [SI]
    CMP AL, 24H
    JE P50
    CMP AL, 73H
    JZ P30
    CMP AL, 83D
    JZ P20
    JMP P40
P20:
    SUB AL, 30D
    JMP P40
P30:
    MOV AL, 00110101B
P40:
    MOV [DI], AL
    INC CX
    INC DI
    INC SI
    JMP P10
P50:
    MOV AL, 24H
    MOV [DI], AL
    RET
PROCEDIMIENTO ENDP
END