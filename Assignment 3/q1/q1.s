.text
.global solve

solve:
    movq $0, %r8   # Setting counter to 0

.loopback:
    movq %rdi, %rax # Temp store in %rax
    jz .loopexit    # Checking for exit condition
    and $1, %rax    # Checking whether the last bit is set
    jz .loopmidz    # If last bit is not set
    jnz .loopmidnz  # If last bit is set

.loopmidz:
    sar $1, %rdi    # Arithemetic right shift by 1 bit
    jmp .loopback 

.loopmidnz:
    inc %r8        # Increase count
    sar $1, %rdi   # Arethemetic right shift by 1 bit
    jmp .loopback

.loopexit:
    movq %r8, %rax # Move counter to %rax
    and $1, %rax 
    ret
