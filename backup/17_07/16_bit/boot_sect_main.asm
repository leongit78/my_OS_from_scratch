[org 0x7c00]

mov bp, 0x8000 ; mov the stack safely away from us. It grows donwwards, so it never gonna overlap our data
mov sp, bp

mov bx, 0x9000 ; es:bx = 0x0000:0x9000 = 0x09000 ; offset where to store loaded sectors
mov dh, 2 ; 2 sectors to read

; BIOS stores boot disk number in DL

call disk_load

mov dx, [0x9000] ; retreive the first loaded word, 0xDADA
call print_hex

call print_nl

mov dx, [0x9000 + 512] ; first word from second loaded sector, 0xFACE
call print_hex

jmp $

; includes

%include "print.asm"
%include "print_hex.asm"
%include "boot_sect_disk.asm"

; Magic number 
times 510 - ($-$$) db 0
dw 0xaa55

; 2 addtional sectors

times 256 dw 0xdada ; sector 2 = 512 bytes = 256 words
times 256 dw 0xface ; sector 3 = 512 bytes