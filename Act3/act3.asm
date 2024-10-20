.MODEL SMALL
.STACK 100H
;------------------
;SEGMENTO DE DATOS
;------------------

.DATA
OPER DB "4+2-3+9+2-8", '$'

;------------------
;FINAL SEGMENTO DE DATOS
;------------------

;------------------
;SGMENTO CODIGO
;------------------
.CODE
MAIN PROC FAR
	MOV AX, @DATA
	MOV DS, AX

	CALL RECORRER

	MOV AH, 00H
	INT 16H

	MOV AH, 4CH
	INT 21H
MAIN ENDP

RECORRER PROC
	LEA SI, OPER
	MOV AX, 00H
	MOV BX, 00H
	MOV CL, 00H
BUCLE:
	MOV DH, [SI]
	CMP DH, 24H
	JE FIN
	CMP DH, 2DH
	JBE COM1
	CMP CL, 00H
	JNE COMPARAR
	MOV BL, [SI]
	SUB BL, 30H
	JMP COM2
COMPARAR:
	POP DX
	DEC CL
	CMP DH, 2BH
	JE S 
	CMP DH,2DH
	JE R 
S:
	MOV AL, [SI]
	SUB AL, 30H
	ADD BL, AL
	JMP COM2
R:
	MOV AL, [SI]
	SUB AL, 30H
	ADD BL, AL
	JMP COM2
COM1:
	INC CL
	PUSH DX
COM2:
	INC SI
	JMP BUCLE
FIN:
	RET
RECORRER ENDP

END 

;--------------------------
; FINAL SEGMENTO DE CODIGO
;--------------------------

