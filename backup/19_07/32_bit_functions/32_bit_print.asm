[bits 32] ; using 32-bit mode

; how to define constants in 32 bit mode

; EQU = equal

VIDEO_MEMORY equ 0xb8000 ; base video mem address
WHITE_ON_BLACK equ 0x0f ; 0 = 0000 = black background, f = 1111 = white foreground 

print_string_pm:
    pusha 
    mov edx, VIDEO_MEMORY ; set EDX to store the starting address of video memory

print_string_pm_loop:
    mov al, [ebx] ; [ebx] is the address of our character
    mov ah, WHITE_ON_BLACK ; color 

    cmp al, 0 ; chech if end of string
    je print_string_pm_done

    mov [edx], ax  ; store our symbol + attr(color) in Video memory
    add ebx, 1; next char 
    add edx, 2; next vid mem pos

    jmp print_string_pm_loop

print_string_pm_done: 
    popa 
    ret
