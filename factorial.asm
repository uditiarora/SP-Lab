section .text
02
	global factorial
03
	extern rpmult
04
	factorial:
05
	push ebp
06
	mov ebp, esp
07
	sub esp, 4 ;creates memory for local variable at ebp-4
08
	mov esi, [ebp+8] ; put n in esi
09
	cmp esi, 1 ; n <= 1
10
	jbe .done ; if so jump to done
11
	.try:
12
	mov [ebp-4],esi ;adds n temporarily into ebp-4
13
	dec esi ; n - 1
14
	push esi ; push arugment
15
	call factorial ;call factorial again stores result in esi
16
	add esp, 4 ;gets rid of the argument   
17
	mov edi, esi ;copies n - 1 into edi   
18
	mov esi,[ebp+4] ;gets the original value back (n)
19
	call rpmult ;multiply
20
	jmp .done ;once it reaches here, finished the function
21
	.done:
22
	mov esp, ebp ;restores esp
23
	pop ebp
24
	ret ;return the value
