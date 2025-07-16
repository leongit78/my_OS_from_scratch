[org 0x7c00]
mov ah, 0x0e ; tty mode

mov bp, 0x8000 ; far away from 0x7c00 -> not getting owerwrtitten
mov sp, bp     ; if stack is empty -> sp = bp

; 2 bytes / symbol
push 'A'
push 'B'
push 'C'

mov bx, push_str
call print_string

mov al, [0x7ffe] ; 0x8000 - 2, e.g. first pushed = A
int 0x10
mov al, [0x7ffc] ; 0x8000 - 4, e.g. second pushed = B
int 0x10
mov al, [0x7ffa] ; 0x8000 - 6, e.g. third pushed  = C
int 0x10


call print_nl
; recover symbols from the stack
; we can pop only full maching word e.g. 16 bytes

mov bx, pop_str
call print_string

pop bx ; move top charater into bx

mov al, bl
int 0x10

pop bx 

mov al, bl
int 0x10

pop bx

mov al, bl
int 0x10

jmp $

%include "print.asm"

push_str db 'Push order: ', 0
pop_str db 'Pop order: ', 0

times 510-($-$$) db 0
dw 0xaa55