[org 0x7c00] ; bootloader offset
    mov bp, 0x9000
    mov sp,bp

    mov bx, MSG_REAL_MODE
    call print_string       ; print in real mode

    call switch_to_pm ; make a switch
    jmp $ ; this will never be executed

; includes

%include "16_bit_functions/print.asm"
%include "32_bit_gdt.asm"
%include "32_bit_functions/32_bit_print.asm"
%include "32_bit_switch.asm"

[bits 32]

BEGIN_PM: ; we will get here right after the switch
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    jmp $

; data
MSG_REAL_MODE db "Started at 16-bit mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0

; bootsector ending

times 510 - ($-$$) db 0
dw 0xaa55