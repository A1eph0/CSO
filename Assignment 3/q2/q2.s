.text
.global transpose

transpose:
    movq %rax, %r8              # copying array address
    movq $0, %r10               # m counter
    movq $0, %r9                # n counter
    movq %rdx, %r15             # m
    movq %rsi, %r14             # n
    movq %rsi, %r13
    imul %rdx, %r13             # (m*n)

.make_array:
    movq $0, %r9                # n counter a set to zero
    cmp %r10, %r15              # checking for end condition
    jz .endgame
    jnz .colfix  

.colfix:
    cmp %r9, %r14               # checking for end condition
    jz .to_make_array
    movq %r9, %rax     
    imulq %r15, %rax 
    add %r10, %rax          
    pushq  (%r8, %rax, 8)       # pushing value into the stack
    inc %r9                     # increasing col counter
    jmp .colfix

.to_make_array:        
    inc %r10                    # increasing col counter
    jmp .make_array

.endgame:
    cmp $0, %r13                # checking for end condition
    jz .finish
    dec %r13
    popq %r12                   # pop the stack     
    movq %r12, (%r8, %r13, 8)   # replacing the array
    jmp .endgame

.finish:
    ret

    
