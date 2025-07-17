print_string: 
    pusha
    mov ah, 0x0e

    return_to_check:
        mov al, [bx]
        cmp al, 0
        jne print_symbol
        popa 
        ret

    print_symbol:
        int 0x10
        add bx, 1
        jmp return_to_check


print_nl:
    pusha 

    mov ah, 0x0e
    mov al, 0x0a ; LF = \n
    int 0x10
    mov al, 0x0d ; CR = \r
    int 0x10

    popa
    ret