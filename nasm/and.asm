extern printf
extern atoi

SECTION .data
	msg: db "%d ",0
	msg1: db " ",10,0

SECTION .bss 
	n RESB 64
	i RESB 64
	j RESB 64	

SECTION .text
	global main

main:
	mov rcx,rdi
	mov r8,8
	mov rdx,qword[rsi+r8]
	
	push rdx
	push rcx
	push rsi
	push r8
	mov rdi,rdx
	call atoi
	mov [n],rax
	pop r8
	pop rsi
	pop rcx
	pop rdx
	
	mov rax,[n]
	mov rbx,1
	or rax,rbx
	push rdx
		push rcx
		push rsi
		push r8
		mov rdi,msg
		mov rsi,rax
		
		mov rax,0
		call printf
		pop r8
		pop rsi
		pop rcx
		pop rdx
		
	mov rax,1
	mov eax,0
	int 80h
