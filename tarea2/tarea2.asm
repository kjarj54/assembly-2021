imprime macro cadena
mov ah,09
mov dx,offset cadena
int 21h
endm

.MODEL SMALL
.STACK 100H

.DATA

ARCH DB 'C:\tarea.txt', 0
VEC DB 512 DUP('$'), '$'
MSTOTPAL DB 10D, 'PALABRAS TOTALES: ','$'

.CODE

MAIN PROC FAR
    MOV AX, @DATA
    MOV DS, AX
    
    ; Abrir
    MOV AH, 3DH
    MOV AL, 0H
    MOV DX, OFFSET ARCH
    INT 21H
    
    MOV BX, AX
    
    ; Leer archivo
    MOV AH, 3FH
    
    MOV CX, 200
    MOV SI, OFFSET VEC
    
    INT 21H
    MOV AH, 09H
    INT 21H
    
    
    CALL CONTCARACTER
        
    ; Cerrar
    MOV AH, 3EH
    INT 21H
    
    MOV AH, 4CH
    INT 21H
MAIN ENDP

CONTCARACTER PROC
    MOV CX, 00
P10:
    MOV AL, [SI]
    CMP AL, 24H
    JE P50
    CMP AL, 32D
    JZ P40
P30:
    INC SI
    JMP P10
P40:
    INC CX
    INC SI
    ;imprime MS10
    JMP P10
P50:
    imprime MSTOTPAL
    add CX,3D
    mov bl,10
    ;imprime MS11
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
    RET
CONTCARACTER ENDP

END