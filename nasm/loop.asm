 section .bss
dd1:    resq    100                     ; reserve 100 long int
i:      resq    1                       ; actually unused, kept in register

        section .data                   ; Data section, initialized variables
fmt:    db "dd1[0]=%ld, dd1[1]=%ld, dd1[98]=%ld, dd1[99]=%ld",10,0
        
        extern  printf                  ; the C function, to be called

        section .text
        global  main
main:   push    rbp                     ; set up stack

        mov     qword [dd1],5           ; dd1[0]=5;  memory to memory
        mov     qword [dd1+99*8],9      ; dd1[99]=9; indexed 99 qword

        mov     rdi, 1*8                ; i=1; index, will move by 8 bytes
loop1:  mov     qword [dd1+rdi],7       ; dd1[i]=7;
        add     rdi, 8                  ; i++;  8 bytes 
        cmp     rdi, 8*99               ; i<99
        jne     loop1                   ; loop until incremented i=99
        
        mov     rdi, fmt                ; pass address of format
        mov     rsi, qword [dd1]        ; dd1[0]   first list parameter
        mov     rdx, qword [dd1+1*8]    ; dd1[1]   second list parameter
        mov     rcx, qword [dd1+98*8]   ; dd1[98]  third list parameter
        mov     r8,  qword [dd1+99*8]   ; dd1[99]  fourth list parameter
        mov     rax, 0                  ; no xmm used
        call    printf                  ; Call C function

        pop     rbp                     ; restore stack
        mov     rax,0                   ; normal, no error, return value
        ret                             ; return 0;



