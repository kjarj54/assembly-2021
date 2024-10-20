.model small
.stack 100h
.data
    msg db 'La cadena es: ','$'
    cadena db 'gg no jg, lasdk.',13,10,'$'
    cadena2 db 'Tiene ','$'
    contador db 0
    cadena3 db ' caracteres',13,10,'$'
.code

cuenta:

    mov ax, @data
    mov ds, ax

    ;imprime cadenas
    mov dx, offset msg
    mov ah, 9h
    int 21h

    mov dx, offset cadena
    mov ah, 9h
    int 21h

    push dx ;pasamos por referencia la variable cadena, lo metemos a la pila

    mov dx, offset cadena2
    mov ah, 9h
    int 21h

    call cuentaCaracteres

    AAM
    mov bx, ax
    mov ah, 2
    mov dl, bh
    add dl, 48 ; convertir de valor numero a valor ASCII
    int 21h

    mov ah, 2
    mov dl, bl
    add dl, 48 ; convertir de valor numero a valor ASCII
    int 21h

    mov dx, offset cadena3
    mov ah, 9h
    int 21h

    mov al, 0
    mov ah, 04ch
    int 21h


cuentaCaracteres proc
    push bp
    mov bp, sp
    ;push es
    mov si, [bp+4] ;guardar en si la palabra a contar caracteres
    mov cl, 0

bucle:  
    mov dl, [si]
    cmp dl, 13 ;compara cuando un caracter de la cadena llega al enter
    je done ;si llega al enter,termina de contar
    cmp dl, 32 ;compara cuando un caracter sea el carcter espacio
    ja sumar ;se va a la etiqueta sumar, cuando no es espacio, donde se incrementa el contador
    inc si ; incrementa al si para que siga sumando los caracteres
    jmp bucle

sumar:
    inc cl ;incrementa en 1 al contador
    inc si ; incrementa al si para que siga sumando los caracteres
    jmp bucle ;regresa al loop

done:   
    ;pop es
    pop bp
    mov ax, cx ;retornamos la variable del contador de caracteres
    ret
    cuentaCaracteres endp   

end cuenta