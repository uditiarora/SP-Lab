section .data
	numb1 db "enter first number:" ,0xA
	len1 equ $-numb1
	numb2 db "enter second number:", 0xA
	len2 equ $-numb2
	msg1 db "the sum:", 0xA,0xD
	len3 equ $-msg1
	msg2 db "the difference:", 0xA,0xD
	len4 equ $-msg2
	msg3 db "the product:", 0xA,0xD
	len5 equ $-msg3
	msg4 db "the quotient:", 0xA,0xD
	len6 equ $-msg4
	msg5 db "the remainder:", 0xA,0xD
	len7 equ $-msg5
section .bss
	num1 resb 4
	num2 resb 4
	res1 resb 4
	res2 resb 4
	res3 resb 4
	res4 resb 4
	res5 resb 4
section .text
	global _start
_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, numb1
	mov edx, len1
	int 80h
	
	mov eax, 3
	mov ebx, 0
	mov ecx, num1
	mov edx, 4
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, numb2
	mov edx, len2
	int 80h
	
	mov eax, 3
	mov ebx, 0
	mov ecx, num2
	mov edx, 4
	int 80h
	
	;for addition
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, len3
	int 80h
	
	mov eax,[num1] 
	sub eax,'0'
	mov ebx,[num2]
	sub ebx,'0'
	add eax,ebx
	add eax,'0'
	mov [res1],eax
	
	mov eax, 4
	mov ebx, 1
	mov ecx, res1
	mov edx, 1
	int 80h
	
	;for subtraction
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, len4
	int 80h
	
	mov eax,[num1] 
	mov ebx,[num2]
	sub eax,'0'
	sub ebx,'0'
	sub eax,ebx
	add eax,'0'
	mov [res2],eax
	
	mov eax, 4
	mov ebx, 1
	mov ecx, res2
	mov edx, 4
	int 80h
	 
	;for multiplication
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, len5
	int 80h
	
	mov al,[num1] 
	sub al,'0'
	mov bl,[num2]
	sub bl,'0'
	mul bl
	add al,'0'
	mov [res3],al
	
	mov eax, 4
	mov ebx, 1
	mov ecx, res3
	mov edx, 4
	int 80h
	
	;for division
	mov eax, 4
	mov ebx, 1
	mov ecx, msg4
	mov edx, len6
	int 80h
	
	mov al,[num1] 
	sub al,'0'
	mov bl,[num2]
	sub bl,'0'
	div bl
	add al,'0'
	mov [res4],al
	add ah,'0'
	mov [res5],ah
	
	mov eax, 4
	mov ebx, 1
	mov ecx, res4
	mov edx, 4
	int 80h
	
	;for mod
	mov eax, 4
	mov ebx, 1
	mov ecx, msg5
	mov edx, len7
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, res5
	mov edx, 4
	int 80h
	
	mov eax,1
	mov ebx,0
	int 80h 
	
