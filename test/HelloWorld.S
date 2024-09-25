@
@ Assembler program print out "Hello World"
@ using the Pico SDK.
@
@ R0 - first parameter to printf
@ R1 - second parameter to printer
@ R7 - index counter
@
.thumb_func .global main @ Necessary because sdk uses BLX
@  Provide program starting
address to linker
main:
MOV R7, #0 @ initialize counter to 0
BL stdio_init_all @ initialize uart or usb
loop:
LDR R0, =helloworld ADD R7, #1 MOV R1, R7 @ load address of string
@ Increment counter
@  Move the counter to second
parameter
BL printf @ Call pico_printf
B loop @ loop forever
.data
.align 4 @ necessary alignment
helloworld: .asciz "Hello World %d\n"