	.EQU	LED_PIN1, 0
	.EQU	LED_PIN2, 1
	.EQU	LED_PIN3, 2
	.EQU	GPIO_OUT, 1
	.EQU	sleep_time, 2000

.thumb_func	@ Necessary because sdk uses BLX
.global main    @ Provide program starting address

main:
	MOV	R0, #LED_PIN1
	BL	gpio_init
	MOV	R0, #LED_PIN1
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	MOV	R0, #LED_PIN2
	BL	gpio_init
	MOV	R0, #LED_PIN2
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	MOV	R0, #LED_PIN3
	BL	gpio_init
	MOV	R0, #LED_PIN3
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
loop:   MOV	R0, #LED_PIN1
	MOV	R1, #1
	BL	link_gpio_put
	LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN1
	MOV	R1, #0
	BL	link_gpio_put

	MOV	R0, #LED_PIN2
	MOV	R1, #1
	BL	link_gpio_put
	LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN2
	MOV	R1, #0
	BL	link_gpio_put

	MOV	R0, #LED_PIN3
	MOV	R1, #1
	BL	link_gpio_put
	LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN2
	MOV	R1, #1
	BL	link_gpio_put
	LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN2
	MOV	R1, #0
	BL	link_gpio_put
	MOV	R0, #LED_PIN3
	MOV	R1, #0
	BL	link_gpio_put
	
	MOV	R0, #LED_PIN1
	MOV	R1, #1
	BL	link_gpio_put
	LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN1
	MOV	R1, #0
	BL	link_gpio_put
	B       loop
