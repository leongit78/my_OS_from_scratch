gdt_start: 

gdt_null: 
    dd 0x0
    dd 0x0
    ;        first GDT entry
    ;        first null 8 bytes

    
; GDT for code segment 

gdt_code: 
    ; base = 0x0, limit = 0xfffff
    ; 1st glags: (present)1 (priviledge)00 (descriptor type)1 -> 1001b
    ; type flags: (code)1 (conformig)0 (readable)1 (accessed)0 -> 1010b
    ; 2nd flags: (granularity)1 (32-bit default)1 (64-bit segment)0 (available)0 -> 1100b + limit(bits 16-19) = 0xf = 1111b
    dw 0xffff ; seg limit(bits 0 - 15)
    dw 0x0    ; seg base(bits 0 - 15)
    db 0x0    ; seg base(bits 16 -23)    
    db 10011010b ; 1st flags + type flags 
    db 11001111b ; 2nd flags + Limit(bits 16-19)
    db 0x0    ; seg base (bits 24-31)

gdt_data: 
    ; Since code and data segments are overlapped -> they are identical, BUT
    ; (code)0 for data segment, (expand down)0, (writable)1, (accessed)0    
    dw 0xffff ; seg limit(bits 0-15)
    dw 0x0    ; seg base(bits 0-15)
    db 0x0    ; seg base(bits 23-16)
    db 10010010b ; 1st flags + type flags
    db 11001111b ; 2nd flags + seg limit(bits 16-19)
    db 0x0     ; segment base(bits 24-31)

gdt_end:
    ; is used to calculate the GDT size for the GDT descriptor

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; size(16 bit) , always one less than the true size
    dd gdt_start ; address(32 bit)


; Define useful constants for the GDT SD's(entrys in Global Descriptor Table) OFFSETS.
; Segment registers in PM must contain one of these to determine which segment to use(code or data),
; by knowing it's offset. For example if we set DS = 0x10 in PM, CPU knows that we mean it to use
; segment, DESCRIBED at offset 0x10 (16 bytes) in our GDT, which in out case is DATA segment
; 0x0 -> NULL, 0x08 - CODE, 0x10 -> DATA.
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
