disk_load: 
    pusha
    push dx

    mov ah, 0x02 ; int 0x13 function. '0x02' = READ
    mov al, dh ; al <- number of sectors to read. We get this number from calling proc
    mov cl, 0x02 ; cl <- sector (0x01 ... 0x11)
                 ; 0x01 is our boot sector, so we want to read from the sector right after it(0x02)
    mov ch, 0x00 ; ch <- cylinder (0x0 .... 0x3ff, upper 2 bits in cl)

    ; dl <- drive number. Caller proc sets it as a parameter and gets it from BIOS
    ; (0 = floppy, 1 = floppy2, 0x80 = hdd, 0x81 = hdd2)  

    mov dh, 0x00 ; dh <- head number (0x0 ... 0xf (16 heads))
    
    ; [es:bx] <- pointer to buffer where the data will be stored
    ; caller sets it up for us, and int 0x13 stadartly uses it

    int 0x13
    jc disk_error ; if error (exceeded boundary e.t.c.) -> cf = 1

    pop dx
    cmp al, dh  ; compare the expected number of sectors to be read(in DH) to actually read number of sedctor(BIOS sets this number to AL)

    jne sectors_error ; if expected != actual -> sectors error

    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print_string
    call print_nl
    mov dh, ah ; ah = error code, dl = disk drive that dropped the error
    call print_hex
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print_string
    call print_nl

disk_loop: 
    jmp $ ; hang

; data

DISK_ERROR:
    db 'Disk error!' , 0
SECTORS_ERROR:
    db 'Incorrect number of sectors read!' , 0