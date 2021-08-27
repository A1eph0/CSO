.text
.global solve 

solve:
    movq $0, %r13       # sum counter (s)
    movq %rdi, %r14     # n
    movq %rsi, %r15     # m
    movq $2, %r8        # counter

.iterator:
    cmp %r14, %r8       # while i<n
    jge .finish
    movq $2, %r10       # first prime (d)
    jmp .prime_checker

.prime_checker:
    cmp %r8, %r10       # while j<i
    jge .loopback_true
    movq %r8, %rax 
    movq $0, %rdx
    divq %r10           # if (i%j) == 0
    cmp $0, %rdx    
    je .loopback_false
    inc %r10            #j++
    jmp .prime_checker

.loopback_false:
    inc %r8             #i++
    jmp .iterator
    
.loopback_true:
    movq %r8, %rax      # (i%m)
    movq $0, %rdx
    divq %r15
    add %r8, %r13       # ((i%m)+s)%m
    movq %r13, %rax
    movq $0, %rdx
    divq %r15           
    movq %rdx, %r13     # s = ((i%m)+s)%m
    inc %r8             # j++
    jmp .iterator

.finish: 
    movq %r13, %rax
    ret
