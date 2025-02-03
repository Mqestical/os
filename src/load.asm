org 0x7C00
bits 16 

%define ENDL 0x0D, 0x0A

start:
jmp main

; prints a string to the screen
; params:
; - ds:si points to the string
puts:
 push si
 push ax
 
 .loop:
 lodsb
 or al, al ; check whether next char is NULL or not.
 jz .done
 mov bh, 0
 mov ah, 0x0e
 int 0x10
 jmp .loop
 
 .done:
 pop ax
 pop si
 ret 
 
 
; NOTICE: Physical Address=Segment*16+Offset

main:
; setup data segments
mov ax, 0 ; can't write directly to segment registers.
mov ds, ax
mov es, ax 
; setup stack

mov ss, ax
mov sp, 0x7c00

mov si, msg_hello
call puts

hlt

.halt:
jmp .halt

msg_hello: db 'Hello, World!', ENDL, 0

times 510-($_$$) db 0
dw 0AA55h
