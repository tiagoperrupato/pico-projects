@ Assuming the correct base and offsets are used in place of SIO_BASE, etc.

.EQU    LED_PIN, 0
.EQU    BUTTON1_PIN, 1
.EQU    BUTTON2_PIN, 2
.EQU    GPIO_OUT, 1
.EQU    GPIO_IN, 0

.EQU    SIO_BASE, 0xD0000000                @ SIO base address
.EQU    SIO_GPIO_IN_OFFSET, 0x00000004      @ Offset for GPIO input register
.EQU    SIO_GPIO_OUT_SET_OFFSET, 0x00000014 @ Offset for GPIO set register
.EQU    SIO_GPIO_OUT_CLR_OFFSET, 0x00000018 @ Offset for GPIO clear register

.thumb_func 
.global main
.align 4

main:
    @ Initialize LED on GP0
    MOV    R0, #LED_PIN
    BL     gpio_init                        @ Call gpio_init for LED
    MOV    R0, #LED_PIN
    MOV    R1, #GPIO_OUT
    BL     link_gpio_set_dir                @ Set LED direction as output

    @ Initialize Pushbutton 1 on GP1
    MOV    R0, #BUTTON1_PIN
    BL     gpio_init                        @ Call gpio_init for BUTTON1
    MOV    R0, #BUTTON1_PIN
    MOV    R1, #GPIO_IN
    BL     link_gpio_set_dir                @ Set BUTTON1 direction as input

    @ Initialize Pushbutton 2 on GP2
    MOV    R0, #BUTTON2_PIN
    BL     gpio_init                        @ Call gpio_init for BUTTON2
    MOV    R0, #BUTTON2_PIN
    MOV    R1, #GPIO_IN
    BL     link_gpio_set_dir                @ Set BUTTON2 direction as input

    MOV    R4, #1

wait_on:
    MOV    R0, #BUTTON1_PIN
    LDR    R2, =SIO_BASE                    @ Load SIO base address
    LDR    R1, [R2, #SIO_GPIO_IN_OFFSET]    @ Read the GPIO input register
    LSL    R3, R4, #BUTTON1_PIN             @ Shift for BUTTON1 pin
    AND    R1, R1, R3                       @ Mask to check BUTTON1 state
    CMP    R1, #0
    BEQ    wait_on                          @ Loop until BUTTON1 is pressed

turn_on:
    MOV    R3, #1
    LSL    R3, R3, #LED_PIN                 @ Shift to correct LED pin position
    STR    R3, [R2, #SIO_GPIO_OUT_SET_OFFSET] @ Turn the LED on

    B wait_off

wait_off:
    MOV    R0, #BUTTON2_PIN
    LDR    R2, =SIO_BASE                    @ Load SIO base address again
    LDR    R1, [R2, #SIO_GPIO_IN_OFFSET]    @ Read the GPIO input register
    LSL    R3, R4, #BUTTON2_PIN             @ Shift for BUTTON2 pin
    AND    R1, R1, R3                       @ Mask to check BUTTON2 state
    CMP    R1, #0
    BEQ    wait_off                         @ Loop until BUTTON2 is pressed

turn_off:
    MOV    R3, #1
    LSL    R3, R3, #LED_PIN                 @ Shift to correct LED pin position
    STR    R3, [R2, #SIO_GPIO_OUT_CLR_OFFSET] @ Turn the LED off

    B wait_on                               @ Repeat the loop
