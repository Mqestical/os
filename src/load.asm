org 0x7C00
bits 16

start:
    jmp main

main:
    mov ax, 0
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; kernel at sec2
    mov ax, 2      ; sector 2
    mov bx, 0x1000 ; destination address (0x1000)
    call load_kernel
    jmp 0x0000:0x1000
load_kernel:
    mov ah, 0x02
    mov al, 1
    mov ch, 0      ; cylinder 0
    mov cl, 2      ; sector 2
    mov dh, 0      ; head 0
    mov dl, 0x80   ; drive 0 (floppy)
    int 0x13       
    ret
times 510-($-$$) db 0
dw 0xAA55