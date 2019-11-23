extern printf
extern atoi
SECTION .data
	msg1 : db " Add %d ",10,0
	msg2 : db " Sub %d ",10,0
	msg3 : db " Mul %d ",10,0
	msg4 : db " Div %d ",10,0
	
SECTION .bss
	i RESB 64
        j RESB 64
      	op RESB 64
SECTION .text
	global main



main:
	mov rcx,rdi
	mov r8,8
	mov rdx,qword[rsi + r8]
	
	push rcx
	push rdx
	push rsi
	push r8
	mov rdi,rdx
	call atoi
	mov [i],rax
	pop r8
	pop rsi
	pop rdx
	pop rcx

	add r8,8
	
	push rcx
	push rdx
	push rsi
	push r8
	mov rdx, qword[rsi+r8]
	mov rdi,rdx
	call atoi
	mov [j], rax
	pop r8
	pop rsi
	pop rdx
	pop rcx
	
	add r8,8
	
	push rcx
	push rdx
	push rsi
	push r8
	mov rdx, qword[rsi+r8]
	mov rdi,rdx
	call atoi
	mov [op], rax
	pop r8
	pop rsi
	pop rdx
	pop rcx
	
	mov eax,1
	cmp eax,[op]
	je Add
	
	mov eax,2
	cmp eax,[op]
	je Sub
	
	mov eax,3
	cmp eax,[op]
	je Mul
	
	mov eax,4
	cmp eax,[op]
	je Div
	
Add:
	mov rax,[i]
	add rax,[j]
	mov [op],rax
	mov rdi,msg1
	mov rsi,[op]
	mov rax,0
	call printf
	jmp end

Sub:
	mov rax,[i]
	sub rax,[j]
	mov [op],rax
	mov rdi,msg2
	mov rsi,[op]
	mov rax,0
	call printf
	jmp end

Mul:
	mov eax,[i]
	mov ebx,[j]
	mul ebx
	mov [op],eax
	mov rdi,msg3
	mov rsi,[op]
	mov rax,0
	call printf
	jmp end

Div:
	mov eax,[i]
	mov ebx,[j]
	div ebx
	mov [op],eax
	mov rdi,msg4
	mov rsi,[op]
	mov rax,0
	jmp end
	
	
end:
	mov rbx,0
	int 80h
