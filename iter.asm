extern printf
extern atoi

SECTION .data
forS: db '%s',10,0
forD: db '%d',10,0
SECTION .bss
i RESB 64
j RESB 64
n RESB 64
S RESB 64
SECTION .text

global main
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
mov [i],rax
pop r8
pop rsi
pop rdx
pop rcx

add r8,8
									; mov to j
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
mov [n], rax
pop r8
pop rsi
pop rdx
pop rcx

mov rax,0
mov [S],rax

repeat:
mov eax,[n]
inc eax
cmp eax,[i]
jz end
mov eax,[i]
mov ebx,[j]
mul ebx
mov ebx,[S]
add eax,ebx
mov [S],eax
mov eax,[i]
inc eax
mov [i],eax

jmp repeat

end:

push rcx
push rdx
push rsi
push r8
mov rdi,forD
mov rsi, [S]
mov rax,0
call printf
pop r8
pop rsi
pop rdx
pop rcx

mov eax,1
mov rbx,0
int 80h
