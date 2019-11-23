section .data
	numb1 dd '80'
	numb2 dd '99'
	numb3 dd '90'
	msg1: db "the greatest number is:"
	len1 equ $-msg1

section .bss
	lrgst resb 2
section .text 
	global _start
_start:
	mov ecx,[numb1]
	cmp ecx,[numb2]
	jg thirdnum
	mov ecx,[numb2]
	
	thirdnum:
		cmp ecx,[numb3]
		jg _exit
		mov ecx,[numb3]
	_exit:
		mov [lrgst],ecx
		mov eax,4
		mov ebx,1
		mov ecx,msg1	
		mov edx,len1
		int 80h
		
		mov eax,4
		mov ebx,1
		mov ecx,lrgst
		mov edx,2
		int 80h
		
		mov eax,1
		mov ebx,0
		int 80h 
		
