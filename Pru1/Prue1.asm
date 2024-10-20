.MODEL TINY
org 100h
;Oswaldo Luna Grados
.DATA
filename  db 'file.txt',0 
filename2 db 'file2.txt',0
leido db 110 dup("$"),'$'
saltolin db 13,10   
string db 110 dup(" "),'$'
contChar db 0
ap dw 0 ;apuntador de palabra de leido
ap1 dw  0 ;apuntador de palabra de string
handle dw 0
.CODE
.STARTUP

 read:
 mov dx, offset filename
 mov ah, 3dh  
 int 21h

 mov handle,ax
 mov bx,handle
  mov cx, 110 ;maximo de caracteres en el archivo
 mov dx, offset leido
 mov ah, 3fh
 int 21h

                ;close file
 mov bx, handle
 mov ah, 3eh
 int 21h    
 
print:
 ;imprimir el contenido de leido
 mov dx, offset leido
 mov ah, 9
 int 21h 
 
 cont: 
 xor dx,dx           ;contar caracteres
 xor ax,ax
 xor bx,bx
 xor cx,cx
 mov cx, 110          ;maximo de caracteres a leer 
 xor si,si
 xor di,di 
 
 mov string[di],'0'
 inc ap1 
 mov di,ap1
 mov string[di],' '
 inc ap1
 recorre:
 mov si,ap 
 mov di,ap1 
 cmp leido[si],'$'
 jz  fin
 cmp leido[si],10
 jz  suma 
 jnz contcarac
 seguir:
 mov al,leido[si]
 mov string[di],al
 seguir2: 
 inc ap
 inc ap1
 loop recorre
 
 contcarac:
 mov bx,ap  
 inc contChar
 call seguir
 
 hex2ascii proc 
    xor ax,ax
    mov al, contChar
    mov bx, 0ah
    div bl
    mov bl, al              ;save result from divition
    add al, 48
    mov di,ap1
    mov string[di],al
    inc ap1
    xor ax,ax
    mov al, bl
    mov bl, 0ah
    mul bl
    mov bx, ax
    mov al, contChar
    sub ax, bx
    add al, 48
    mov di,ap1
    mov string[di],al
    inc ap1
    ret
endp
               
 suma:
 mov di,ap1
 mov string[di],10
 inc ap1
 call hex2ascii            ;agrega la cantidad de caracteres
 mov di,ap1
 mov string[di],' '  
 call seguir2 
 fin:
 ; se sumara el total y terminara 
 mov string[di],13
 inc ap1
 mov di,ap1
 mov string[di],10
 inc ap1
 mov di,ap1
 call hex2ascii
 mov di,ap1
 ; create file 
 create:
    mov	ah,3ch
    mov	cx,00000000b
    lea	dx,filename2
    int	21h
    jc	error
    mov	handle,ax
    
 printf: 
 xor dx,dx              ;print
 mov dx, offset string
 mov ah, 9
 int 21h
       
         
 write:
 mov	ah,40h
 mov	bx,handle
 mov	cx,110
 lea	dx,string
 int	21h
 
 			; close file
 mov	ah,3eh
 mov	bx,handle
 int	21h      
 error:

 int 20h
 end