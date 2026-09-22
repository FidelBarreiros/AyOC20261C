extern strcpy
extern malloc
extern free

section .rodata
; Acá se pueden poner todas las máscaras y datos que necesiten para el ejercicio

section .text
; Marca un ejercicio como aún no completado (esto hace que no corran sus tests)
FALSE EQU 0
; Marca un ejercicio como hecho
TRUE  EQU 1

ITEM_OFFSET_NOMBRE EQU 0
ITEM_OFFSET_ID EQU 12
ITEM_OFFSET_CANTIDAD EQU 16

POINTER_SIZE EQU 8
UINT32_SIZE EQU 4

; Marcar el ejercicio como hecho (`true`) o pendiente (`false`).

global EJERCICIO_1_HECHO
EJERCICIO_1_HECHO: db FALSE ; Cambiar por `TRUE` para correr los tests.

global EJERCICIO_2_HECHO
EJERCICIO_2_HECHO: db FALSE ; Cambiar por `TRUE` para correr los tests.

global EJERCICIO_3_HECHO
EJERCICIO_3_HECHO: db FALSE ; Cambiar por `TRUE` para correr los tests.

global EJERCICIO_4_HECHO
EJERCICIO_4_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

global ejercicio1
ejercicio1:
	add rdi, rsi
	add rdi, rdx
    add rdi, rcx
    add rdi, r8
	mov rax, rdi
	ret

global ejercicio2
ejercicio2:
	push rbp
	mov rbp, rsp

	mov [rdi+ITEM_OFFSET_ID], esi
	mov [rdi+ITEM_OFFSET_CANTIDAD], edx
	mov rsi, rcx
	call strcpy 

	pop rbp
	ret


global ejercicio3
ejercicio3:
	push rbp
	mov rbp, rsp
	push r12
	push r13
	push r14
	push r15

	cmp esi, 0
	je .vacio
	
	mov r13, rdi ; array
	mov r14, 0 ; sumatoria
	mov r15, 0 ; i
	mov r12d, esi
	mov rbp, rdx
	.loop:
	mov rdi, r14
	mov esi, [r13 + r15*4]

	call rbp

	add r14d, eax
	mov eax, r14d

	inc r15
	cmp r15d, r12d
	je .end

	jmp .loop

	.vacio:
	mov eax, 64

	.end:
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbp
	ret

global ejercicio4
ejercicio4:
	push rbx
	push rbp
	mov rbp, rsp
	push r12
	push r13
	push r14
	push r15
	sub rsp, 8

	mov r12, rdi
	mov r13, rsi
	mov r14, rdx

	xor rdi, rdi
	mov eax, UINT32_SIZE
	mul esi
	mov edi, eax

	call malloc
	mov r15, rax
	
	xor rbx, rbx
	.loop:
	
	cmp rbx, r13
	je .end

	mov r8, [r12+rbx*POINTER_SIZE]
	mov r9d, [r8]
	mov rax, r14
	mul r9d
	mov [r15+rbx*UINT32_SIZE], eax
	
	mov rdi, r8 
	call free
	mov qword [r12+rbx*POINTER_SIZE], 0

	inc rbx
	jmp .loop

	.end:
	
	mov rax, r15

	add rsp, 8
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbp
	pop rbx
	
	ret
