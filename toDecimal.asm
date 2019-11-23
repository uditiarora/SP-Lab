extern printf
extern atoi


SECTION .data
	msg: db "Ans : %d",10,0

SECTION .bss
	n RESB 64
	ans RESB 64
	multi RESB 64


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
	
	mov rdx,1
	mov [multi],rdx
	mov rdx,0
	mov [ans],rdx
	mov rax,[n]
	
	loop:
		mov rax,[n]
		cmp rax,0
		je end
		
		mov rdx,0
		mov r9,10
		div r9
		mov [n],rax
		mov rax,rdx
		mov r9,[multi]
		mul r9
		mov r9,[ans]
		add rax,r9
		mov [ans],rax
		mov rax,[multi]
		mov r9,2
		mul r9
		mov [multi],rax
		jmp loop
		
	end:
		push rdx
		push rcx
		push rsi
		push r8
		mov rdi,msg
		mov rsi,[ans]
		mov rax,0
		call printf
		pop r8
		pop rsi
		pop rcx
		pop rdx
		
		mov rax,1
		mov eax,0
		int 80h
		
		
			
	
		
		
		
		
		
		
		
	
	
