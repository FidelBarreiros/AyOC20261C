;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
 NODO_OFFSET_NEXT EQU 0
 NODO_OFFSET_ARREGLO EQU 16
 NODO_OFFSET_CATEGORIA EQU 8
 NODO_OFFSET_LONGITUD EQU 24
 NODO_SIZE EQU 32
 PACKED_NODO_OFFSET_NEXT EQU 0
 PACKED_NODO_OFFSET_CATEGORIA EQU 8 
 PACKED_NODO_OFFSET_ARREGLO EQU 9
 PACKED_NODO_OFFSET_LONGITUD EQU 17
 PACKED_NODO_SIZE EQU 21
 LISTA_OFFSET_HEAD EQU 0
 LISTA_SIZE EQU 8
 PACKED_LISTA_OFFSET_HEAD EQU 0
 PACKED_LISTA_SIZE EQU 8

;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global cantidad_total_de_elementos
global cantidad_total_de_elementos_packed

;########### DEFINICION DE FUNCIONES
;extern uint32_t cantidad_total_de_elementos(lista_t* lista);
;registros: lista[RDI]
cantidad_total_de_elementos:
	push rbp
	mov rbp, rsp

	XOR EAX, EAX; contador
	mov RDX, [RDI + LISTA_OFFSET_HEAD]

	.ciclo:
		;Saltar cuando next (RDX) sea distinto de 0 (null)
		cmp RDX, 0; nodo actual si == 0, entonces chau
		JZ .fin

		add EAX, DWORD [RDX + NODO_OFFSET_LONGITUD]
		mov RDX, QWORD [RDX + NODO_OFFSET_NEXT]; ubicacion sig nodo
	
		jmp .ciclo
	.fin:

		pop rbp
		ret

;extern uint32_t cantidad_total_de_elementos_packed(packed_lista_t* lista);
;registros: lista[RDI]
cantidad_total_de_elementos_packed:
	push rbp
	mov rbp, rsp

	XOR EAX, EAX; contador
	mov RDX, [RDI + PACKED_LISTA_OFFSET_HEAD]

	.ciclo:
		;Saltar cuando next (RDX) sea distinto de 0 (null)
		cmp RDX, 0; nodo actual si == 0, entonces chau
		JZ .fin

		add EAX, DWORD [RDX + PACKED_NODO_OFFSET_LONGITUD]
		mov RDX, QWORD [RDX + PACKED_NODO_OFFSET_NEXT]; ubicacion sig nodo
	
		jmp .ciclo
	.fin:

		pop rbp
		ret
	