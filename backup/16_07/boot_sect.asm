[org 0x7c00]

mov bx, HELLO
call print_string

call print_nl

mov bx, GOODBYE
call print_string

call print_nl

mov dx, 0x12fe
call print_hex



jmp $  ; jump to current instruction = infinite loop => HANG

; includes
%include "print_hex.asm"
%include "print.asm"

; data

HELLO:
    db 'Hello!', 0

GOODBYE:
    db 'Goodbye!', 0
    

; Fill 510 zeros minus the size of the previous code 
times 510-($-$$) db 0

; Magic number
dw 0xaa55