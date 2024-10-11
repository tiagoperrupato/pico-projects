.EQU	LED_PIN1, 0
.EQU	LED_PIN2, 1
.EQU	LED_PIN3, 2
.EQU	GPIO_OUT, 1
.EQU	sleep_time, 2000

.thumb_func	@ Necessary because sdk uses BLX
.global main    @ Provide program starting address

@ set up pins for the LEDs
main:
	MOV	R0, #LED_PIN1			
	BL	gpio_init
	MOV	R0, #LED_PIN1
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir		@ set up green LED
	MOV	R0, #LED_PIN2
	BL	gpio_init
	MOV	R0, #LED_PIN2
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir		@ set up yellow LED
	MOV	R0, #LED_PIN3
	BL	gpio_init
	MOV	R0, #LED_PIN3
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir		@ set up red LED
loop:   MOV	R0, #LED_PIN1
	MOV	R1, #1
	BL	link_gpio_put			@ turn on green
	LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN1
	MOV	R1, #0
	BL	link_gpio_put			@ turn off green

	MOV	R0, #LED_PIN2
	MOV	R1, #1
	BL	link_gpio_put			@ turn on yellow
	LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN2
	MOV	R1, #0					@ turn off yellow
	BL	link_gpio_put

	MOV	R0, #LED_PIN3
	MOV	R1, #1
	BL	link_gpio_put			@ turn on red
	LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN2
	MOV	R1, #1
	BL	link_gpio_put			@ turn on yellow
	LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN2
	MOV	R1, #0
	BL	link_gpio_put			@ turn off yellow
	MOV	R0, #LED_PIN3
	MOV	R1, #0
	BL	link_gpio_put			@ turn off red
	
	MOV	R0, #LED_PIN1		
	MOV	R1, #1
	BL	link_gpio_put			@ turn on yellow
	LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN1
	MOV	R1, #0
	BL	link_gpio_put			@ turn off yellow
	B       loop