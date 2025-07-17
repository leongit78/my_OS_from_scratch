mov ah, 0x0e

; 1
mov al, [the_secret]
int 0x10

; 2
mov bx, 0x7c0
mov ds, bx     ; now all data will be stored implictily by offset in ds(data segment)

mov al, [the_secret]
int 0x10


; 3
mov al, [es:the_secret] ; ES = 0x00 by default -> WA
int 0x10 

; 4
mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10


jmp $

; data

the_secret: 
    db "X"

times 510-($-$$) db 0
dw 0xaa55