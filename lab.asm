extern printf
extern atoi

SECTION .data
	msg1 : db "Odd = %d",10,0
	msg2 : db "Even = %d",10,0

SECTION .bss
	n RESB 64
	count RESB 64
	odd RESB 64
	
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
	pop rdx
	pop rdx
	
	
	mov rax,[n]
	mov rdx,0
	mov [count],rdx
	mov [odd],rdx	
	
	loop:
		mov rax,[n]
		
		cmp rax,0
		je end
		
		mov r9,10
		mov rdx,0
		div r9
		mov [n],rax
		mov rax,rdx
		mov rdx,0
		mov r9,2
		div r9
		mov rax,rdx
		add rax,[odd]
		mov [odd],rax
		mov r9,[count]
		add r9,1
		mov [count],r9
		mov rax,[n]
		jmp loop
	
	
		
	end:	
		push rdx
		push rdi
		push rsi
		push r8
		mov rdi,msg1
		mov rsi,[odd]
		mov rax,0
		call printf
		pop r8
		pop rsi
		pop rdi
		pop rdx
		
		
		mov rax,[count]
		mov rbx,[odd]
		sub rax,rbx
		
		
		push rdx
		push rdi
		push rsi
		push r8
		mov rdi,msg2
		mov rsi,rax
		mov rax,0
		call printf
		pop r8
		pop rsi
		pop rdi
		pop rdx
			
		
		
	
	
	mov rax,1
	mov eax,0
	int 80h
		
			
	
	
