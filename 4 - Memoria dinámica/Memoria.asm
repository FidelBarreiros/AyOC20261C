extern malloc
extern free
extern fprintf

section .data

section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **

; int32_t strCmp(char* a, char* b)
strCmp:
    push rbp
    mov rbp, rsp

    xor RDX, RDX
    xor RAX, RAX

    .ciclo:
        mov al, [RDI + RDX]
        cmp al, [RSI + RDX]
        
        jb .aEsMenor
        ja .aEsMayor
        je .Iguales
        
        
        jmp .fin

    .Iguales
        cmp al, 0
        je .fin;
        inc RDX
        jmp .ciclo

    .aEsMenor
        mov eax, 1
        jmp .fin

    .aEsMayor
        mov eax, -1
    .fin:
        pop rbp
        ret
; char* strClone(char* a)
strClone:    
    push rbp
    mov rbp, rsp
    push R12
      push R13
    
    
    xor RDX, RDX

    mov R12, RDI

    call strLen

    inc rax    
    
    mov RDI, RAX

    call malloc

    .ciclo:
        
        mov DIL, byte [R12 + RDX]
        mov byte [RAX + RDX], DIL
        cmp byte [R12 + RDX], 0
        je .fin
        inc RDX
        jmp .ciclo

    .fin:
        pop R13
        pop R12
        pop rbp
        ret

; void strDelete(char* a)
strDelete:
	push rbp
	mov rbp, rsp
	
	call free

	pop rbp
	ret



; void strPrint(char* a, FILE* pFile)
; a [RDI]
; pFile [RSI]
section .data
	fmt db "%s", 0
	null_str db "NULL", 0

section .text
strPrint:   ;en este ej se usa fprint f q usa 3 paramentros RDI(ubicacion donde escribe) RSI(formato) RDX(valor a imprimir)
	push rbp
	mov rbp, rsp

	mov rdx, rdi            
	cmp byte [rdi], 0 ;veo si esta vacio el string
	jne .armar_llamada
	lea rdx, [null_str]      ;meto en rdx "NULL"

	.armar_llamada:
		mov rdi, rsi           
		lea rsi, [fmt]       ;meto en rsi el formato "%s" (string)   
		call fprintf 

		pop rbp
		ret

; uint32_t strLen(char* a)
;a [RDI]
strLen:
	push rbp
	mov rbp, rsp

	xor EAX, EAX
	
	.ciclo:
		cmp byte [RDI + RAX], 0
		je .fin
		inc RAX
		jmp .ciclo

	.fin:
		pop rbp
		ret


