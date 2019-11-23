extern printf
extern atoi

SECTION .data
	msg: db "%d ",0
	msg1: db " ",10,0

SECTION .bss 
	n RESB 64
	k RESB 64
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
	
	add r8,8
	mov rdx,qword[rsi+r8]
push rdx
	push rcx
	push rsi
	push r8
	mov rdi,rdx
	call atoi
	mov [k],rax
	pop r8
	pop rsi
	pop rcx
	pop rdx

push rdx
			push rcx
			push rsi
			push r8
			mov rdi,msg
			mov rsi,[k]
			mov rax,0
			call printf
			pop r8
			pop rsi
			pop rcx
			pop rdx
	
	mov rdx,1
	mov [i],rdx
	mov rdx,1
	mov [j],rdx
	mov rax,[n]
	add rax,1
	mov [n],rax
	loop1:
		push rdx
		push rcx
		push rsi
		push r8
		mov rdi,msg1
		mov rax,0
		call printf
		pop r8
		pop rsi
		pop rcx
		pop rdx
		
		
		mov rdx,[i]
		mov rax,[n]
		cmp rax,rdx
		je end
		mov rdx,[i]
		add rdx,1
		mov [i],rdx
		
		mov rdx,1
		mov [j],rdx 
		loop2:
			mov rdx,[j]
			mov rax,[i]
			cmp rdx,rax
			je loop1
			push rdx
			push rcx
			push rsi
			push r8
			mov rdi,msg
			mov rsi,[j]
			mov rax,0
			call printf
			pop r8
			pop rsi
			pop rcx
			pop rdx
			
			mov rdx,[j]
			add rdx,1
			mov [j],rdx
			jmp loop2
			
		jmp loop1	
			
		
	end:
		mov rax,1
		mov eax,0
		int 80h	
			
			
			
			
			
