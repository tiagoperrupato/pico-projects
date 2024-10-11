.thumb_func             @ Necessary because sdk uses BLX
.global main             @ Provide program starting address to linker

main:
	MOV	R7, #100		@ initialize counter to 0
	BL	stdio_init_all	@ initialize uart or usb
loop:
	LDR	R0, =helloworld	@ load address of helloworld string
	MOV	R1, R7		@ Move the counter to second parameter
	BL	printf		@ Call pico_printf

	SUB R7, R7, #1
	CMP R7, #0
	BGE loop

	MOV R7, #100
	B	loop		@ loop forever

.section .data
    .align 4             @ necessary alignment
helloworld: .asciz "Hello World %d\n"