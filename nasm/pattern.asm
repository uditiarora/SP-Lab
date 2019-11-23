extern printf
extern atoi

SECTION .data
	msg : db "%d ",0
	msg1 : db " ",10,0
	
SECTION .bss
	n RESB 64
	
SECTION .text
	global main
	
	
	
main:
	mov rcx,rdi
	mov r8,8
	mov rdx,qword[rsi + r8]
	
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
	
	mov rdx,[n]
	mov rbx,1
	mov rbx,1
		push rdx
		push rdi
		push rsi
		push r8
		mov rdi,msg
		mov rsi,[n]
		mov eax,0
		call printf
		pop r8
		pop rsi
		pop rdi
		pop rdx
	loop1 :
		mov rbx,1
		push rdx
		push rdi
		push rsi
		push r8
		mov rdi,msg1
		mov eax,0
		call printf
		pop r8
		pop rsi
		pop rdi
		pop rdx
		
		loop:	
			push rdx
			push rdi
			push rsi
			push r8
			mov rdi,msg
			mov rsi,rbx
			mov eax,0
			call printf
			pop r8
			pop rsi
			pop rdi
			pop rdx
		
			add rbx,1
			cmp rbx,[n]
			jng loop
		
	 	sub rdx,1
	 	mov [n],rdx
		cmp rdx,0
		jg loop1
		jmp end
	
	
	end:	
		mov eax,1
		mov rax,0
		int 80h
	
		
		
