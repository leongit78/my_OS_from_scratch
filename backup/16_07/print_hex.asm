print_hex:
    pusha
    mov cx, 4 ; loop counter 4 0xXXXX

; 1 iteration = 1 character is printed

hex_loop:
    cmp cx, 0 ; while(cx != 0) do .... 
    je end 

    sub cx, 1

    mov ax, dx ; DX = our 16-base number 
    shr dx, 4 ; prepare DX for next iteration

    and ax, 0xf ; Isolate 1st character of 16base number
    add al, 0x30 ; add the code of '0' to convert to ASCII 
    cmp al, 0x39 ; whether it is a number or letter
    jle set_char ; if number -> write it to our tempate string HEX_OUT
    add al, 7 ; if letter -> add diff b/w letters and numbers(7 chars)

set_char:
    mov bx, HEX_OUT + 2; skip "Ox"
    add bx, cx ; add pointer dep. on it's pos in template string(curr char pos)
    mov [bx], al  ; write char to pos, ref by pointer(BX)
    jmp hex_loop ; repeat for other chars

end: 
    mov bx, HEX_OUT ; Now BX stores the complete hex string, so we can print it
    call print_string

    popa
    ret

; Template string
HEX_OUT:    
    db "0x0000", 0