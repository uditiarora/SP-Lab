 global main
        extern printf
	extern atoi
        section .bss
d:      resq    1               ; temp  unused, kept in register rdx
c RESB 64
        section .data
a:      dq      1               ; current number, becomes next
b:      dq      2               ; next number, becomes sum a+b


format: db '%15ld', 10, 0
title:  db 'fibinacci numbers', 10, 0
        
        section .text
main:
	mov rcx,rdi
	mov r8,8
	mov rdx, qword[rsi+r8]
														; mov to i
	push rcx
	push rdx
	push rsi
	push r8
	mov rdi,rdx
	call atoi
	mov [c],rax
	pop r8
	pop rsi
	pop rdx
	pop rcx

        push rbp                ; set up stack
        mov rdi, title          ; arg 1 is a pointer
        mov rax, 0              ; no vector registers in use
        call printf
	
	
	
print:
        ;  We need to call printf, but we are using rax, rbx, and rcx.
        mov rdi, format         ; arg 1 is a pointer
        mov rsi,[a]             ; arg 2 is the current number
        mov rax, 0              ; no vector registers in use
        call printf

        mov rdx,[a]             ; save the current number, in register
        mov rbx,[b]             ;
        mov [a],rbx             ; next number is now current, in ram
        add rbx, rdx            ; get the new next number
        mov [b],rbx             ; store in ram
        mov rcx,[c]             ; get loop count
        dec rcx                 ; count down
        mov [c],rcx             ; save in ram
        jnz print               ; if not done counting, do some more

        pop rbp                 ; restore stack
        mov rax, 0              ; normal exit
        ret                     ; return to operating system


