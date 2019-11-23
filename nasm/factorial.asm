
	extern	printf

section .bss
	n RESB 64
section .text
	global main
main:
	push	ebx			; we have to save this since we use it
	mov rcx,rdi
	mov r8,8
	mov rdx, qword[rsi+r8]
														
	push rcx
	push rdx
	push rsi
	push r8
	mov rdi,rdx
	call atoi
	mov [n],rax
	pop r8
	pop rsi
	pop rdx
	pop rcx
	
	mov	ecx, [n]		; ecx will countdown from 40 to 0
	xor	eax, eax		; eax will hold the current number
	xor	ebx, ebx		; ebx will hold the next number
	inc	ebx			; ebx is originally 1
print:
	; We need to call printf, but we are using eax, ebx, and ecx.  printf
	; may destroy eax and ecx so we will save these before the call and
	; restore them afterwards.

	push    eax
	push	ecx

	push	eax
	push	format
	call	printf
	add	esp, 8

	pop	ecx
	pop	eax

	mov	edx, eax		; save the current number
	mov	eax, ebx		; next number is now current
	add	ebx, edx		; get the new next number
	dec	ecx			; count down
	jnz	print			; if not done counting, do some more

	pop	ebx			; restore ebx before returning
	ret
format:
	db	'%10d', 0
