.text
.global solve

isSafe:             # bool isSafe(board, row, col)
    movq $0, %r8    # i=0

.col_iterator:
    cmp %r15, %r8       # while i < col
    jge .to_ud_iterator
    movq %r12, %rax     # needed index [row][i] (row*n+i)
    mulq %r14
    add %r8, %rax
    cmp $1, (%r13, %rax, 8)
    je .isSafeFalse     # return false if occupied
    inc %r8             # i++
    jmp .col_iterator

.to_ud_iterator:
    movq %r14, %r8    # i = row
    movq %r15, %r9    # j = col
    jmp .ud_iterator

.ud_iterator:
    cmp $0, %r8       # while i >= 0
    jl .to_ld_iterator
    cmp $0, %r9       # while j >= 0
    jl .to_ld_iterator
    movq %r12, %rax     # needed index [i][j] (i*n+j)
    mulq %r8
    add %r9, %rax
    cmp $1, (%r13, %rax, 8)
    je .isSafeFalse     # return false if occupied
    dec %r8             # i--
    dec %r9             # j--
    jmp .ud_iterator

.to_ld_iterator:
    movq %r14, %r8    # i = row
    movq %r15, %r9    # j = col
    jmp .ld_iterator

.ld_iterator:
    cmp %r12, %r8       # while i < n
    jge .isSafeTrue
    cmp $0, %r9       # while j >= 0
    jl .isSafeTrue
    movq %r12, %rax     # needed index [i][j] (i*n+j)
    mulq %r8
    add %r9, %rax
    cmp $1, (%r13, %rax, 8)
    je .isSafeFalse     # return false if occupied
    inc %r8             # i++
    dec %r9             # j--
    jmp .ld_iterator

.isSafeTrue:
    movq $1, %rbx
    ret

.isSafeFalse:
    movq $0, %rbx
    ret

solver:                 # bool solver(board, col)
    cmp %r12, %r15      # if col >= n
    je .solverTrue      # return true
    movq $0, %r8        # i = 0

.solver_loop:
    cmp %r12, %r8       # while i < n
    je .solverFalse

    push %r8; push %r9; push %r10; push %r11; push %r12; push %r13; push %r14; push %r15;
    movq %r8, %r14        
    call isSafe         # isSafe(board, i, col)
    pop %r15; pop %r14; pop %r13; pop %r12; pop %r11; pop %r10; pop %r9; pop %r8;

    cmp $1, %rbx        # if isSafe is true
    je .recurse
    
    inc %r8             # i++
    jmp .solver_loop
    

.recurse:
    movq %r12, %rax     # needed index [i][col] (i*n+col)
    mulq %r8
    add %r15, %rax
    movq $1, (%r13, %rax, 8)    # placing the queen
    
    push %r8; push %r9; push %r10; push %r11; push %r12; push %r13; push %r14; push %r15;      
    inc %r15
    call solver         # solver(board, col+1)
    pop %r15; pop %r14; pop %r13; pop %r12; pop %r11; pop %r10; pop %r9; pop %r8;

    cmp $1, %rbx        # if solver is true, return true
    je .solverTrue

    
    movq %r12, %rax     # needed index [i][col] (i*n+col)
    mulq %r8
    add %r15, %rax
    movq $0, (%r13, %rax, 8)    # backtracking

    inc %r8             # i++
    jmp .solver_loop
    
.solverTrue:
    movq $1, %rbx
    ret

.solverFalse:
    movq $0, %rbx
    ret

solve:
    movq $0, %r15       # col = 0
    movq $0, %r14       # row = 0 (not needed by as a precaution)
    movq %rsi, %r12     # n
    movq %rdi, %r13     # board
    call solver         # solve(board, 0)
    ret

