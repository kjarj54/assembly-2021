.MODEL SMALL
.STACK

.DATA
ARCHIVOMANEJADOR DW ?
ARCHIVO DB "C:\tarea.txt", 0
VEC DB 200 DUP ('$')
 
.CODE

MOV AX, @DATA
MOV DS,AX

MOV DX, OFFSET ARCHIVO;

MOV AL, 2
MOV AH, 3DH
INT 21H

MOV ARCHIVOMANEJADOR, AX

MOV DX, OFFSET VEC
MOV BX, ARCHIVOMANEJADOR  

MOV CX, 500
MOV AH, 3FH
INT 21H

MOV BX, ARCHIVOMANEJADOR
MOV AH, 3EH
INT 21H

MOV CX, 200
MOV SI, OFFSET VEC

XOR BH,BH
XOR AL,AL
MOV AH, 0EH

CALL CONTCARACTER

P20:
    INC CX
    mov bl,10
    mov ax,cx
    div bl
    mov dx,ax
    or dx,3030h
    mov ah,02h
    int 21h
    xchg dl,dh
    mov ah,02h
    int 21h
    mov ax, 4C00h
    int 21h
      
    MOV AX,4C02H
    INT 21H
    
CONTCARACTER PROC
    MOV CX, 00
X10:
    MOV AL, [SI]
    CMP AL, 24H
    JE P20
    CMP AL, 32D
    JE X40
    cmp AL, 0DH
    JE X40
X30:
    INC SI
    JMP X10
X40:
    INC CX
    INC SI
    JMP X10
    
CONTCARACTER ENDP

END