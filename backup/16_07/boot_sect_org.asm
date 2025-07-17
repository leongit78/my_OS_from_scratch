[org 0x7c00] ; auto indent for boot_sector
mov ah, 0x0e ; BIOS teletype routine 

mov bx, the_secret
mov al, [bx]
int 0x10


jmp $ ; infinite loop

the_secret:
    ; ASCII code 0x58 ('X') is stored just before the zero-padding.
    ; On this code that is at byte 0x2d (check it out using 'xxd file.bin')
    db "L"

; zero padding and magic bios number
times 510-($-$$) db 0
dw 0xaa55