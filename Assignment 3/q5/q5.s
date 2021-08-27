.text
.global solve

s_finder:
    movq $8, %rax       # getting (8n+1)
    mulq %r15
    inc %rax
    movq %rax, %r9
    
    movq $1, %r8        # i = 1

.root_loop:
    movq %r8, %rax      # while (i)*(i) <= (8n+1)
    mulq %r8
    cmp %r9, %rax
    jg .cont_s_finder
    inc %r8
    jmp .root_loop

.cont_s_finder:
    dec %r8             # now i = sqrt(8n+1)
    dec %r8             # now i = sqrt(8n+1)-1
    sar $1, %r8         # now i = floor((sqrt(8n+1)-1)/2)
    movq %r8, %rbx
    ret

toh_4:
    cmp $1, %r15        # base-case toh_4(1)=1
    je .toh_4_base
    push %r8; push %r9; push %r10; push %r11; push %r12; push %r13; push %r14; push %r15;
    call s_finder       # finding s
    pop %r15; pop %r14; pop %r13; pop %r12; pop %r11; pop %r10; pop %r9; pop %r8;
    movq %rbx, %r14

    push %r8; push %r9; push %r10; push %r11; push %r12; push %r13; push %r14; push %r15;
    sub %r14, %r15      # n-s
    call toh_4          # toh_4(n-s)
    pop %r15; pop %r14; pop %r13; pop %r12; pop %r11; pop %r10; pop %r9; pop %r8;

    movq %rbx, %rax
    movq $2, %r13
    mulq %r13
    movq %rax, %r13     # 2*(toh_4(n-s))

    push %r8; push %r9; push %r10; push %r11; push %r12; push %r13; push %r14; push %r15;
    movq %r14, %r15      
    call toh_3           # toh_3(s)
    pop %r15; pop %r14; pop %r13; pop %r12; pop %r11; pop %r10; pop %r9; pop %r8;

    add %r13, %rbx      # 2*(toh_4(n-s)) * toh_3(s)
    ret

.toh_4_base:
    movq $1, %rbx
    ret

toh_3:
    cmp $1, %r15        # base-case toh_3(1)=1
    je .toh_3_base

    push %r8; push %r9; push %r10; push %r11; push %r12; push %r13; push %r14; push %r15;
    dec %r15            # n-1
    call toh_3          # toh_3(n-1)
    pop %r15; pop %r14; pop %r13; pop %r12; pop %r11; pop %r10; pop %r9; pop %r8;

    movq %rbx, %rax
    movq $2, %rbx
    mulq %rbx
    movq %rax, %rbx     # 2*(toh_3(n-1))

    inc %rbx            # 2*(toh_3(n-1))+1
    ret

.toh_3_base:
    movq $1, %rbx
    ret

solve:
    movq %rdi, %r15
    push %r8; push %r9; push %r10; push %r11; push %r12; push %r13; push %r14; push %r15;
    call toh_4          # toh_1(n-1)
    pop %r15; pop %r14; pop %r13; pop %r12; pop %r11; pop %r10; pop %r9; pop %r8;

    movq %rbx, %rax
    ret
