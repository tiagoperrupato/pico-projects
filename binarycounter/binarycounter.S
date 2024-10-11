.EQU    LED_PIN1, 0   @ LED connected to GPIO pin 0 (represents bit 0)
.EQU    LED_PIN2, 1   @ LED connected to GPIO pin 1 (represents bit 1)
.EQU    LED_PIN3, 2   @ LED connected to GPIO pin 2 (represents bit 2)
.EQU    GPIO_OUT, 1
.EQU    sleep_time, 1000  @ 1000ms or 1 second delay

.thumb_func  @ Necessary because sdk uses BLX
.global main    @ Provide program starting address

main:
    MOV    R0, #LED_PIN1
    BL     gpio_init
    MOV    R0, #LED_PIN1
    MOV    R1, #GPIO_OUT
    BL     link_gpio_set_dir
    MOV    R0, #LED_PIN2
    BL     gpio_init
    MOV    R0, #LED_PIN2
    MOV    R1, #GPIO_OUT
    BL     link_gpio_set_dir
    MOV    R0, #LED_PIN3
    BL     gpio_init
    MOV    R0, #LED_PIN3
    MOV    R1, #GPIO_OUT
    BL     link_gpio_set_dir

    MOV    R4, #0  @ R4 will hold the binary counter value
    MOV    R5, #1  @ R5 will be the direction flag (1 = counting up)

loop:
    @ Extract the value for each LED from the binary counter value
    MOV    R0, R4
    MOV    R1, #1     @ Load immediate value 1 into R1
    AND    R0, R0, R1 @ AND with bit 0 for LED_PIN1
    MOV    R1, R0
    MOV    R0, #LED_PIN1
    BL     link_gpio_put

    MOV    R0, R4
    LSR    R0, #1     @ Shift right to get bit 1 (for LED_PIN2)
    MOV    R1, #1     @ Load immediate value 1 into R1
    AND    R0, R0, R1
    MOV    R1, R0
    MOV    R0, #LED_PIN2
    BL     link_gpio_put

    MOV    R0, R4
    LSR    R0, #2     @ Shift right to get bit 2 (for LED_PIN3)
    MOV    R1, #1     @ Load immediate value 1 into R1
    AND    R0, R0, R1
    MOV    R1, R0
    MOV    R0, #LED_PIN3
    BL     link_gpio_put

    LDR    R0, =sleep_time
    BL     sleep_ms

    @ Update the counter based on the direction (R5 = 1 for up, 0 for down)
    CMP    R5, #1
    BEQ    count_up
    B      count_down

count_up:
    ADD    R4, R4, #1  @ Increment the binary counter

    CMP    R4, #7  @ If counter reaches 7, change direction to decrement
    BGE    change_direction_to_decrement
    B      loop

count_down:
    SUB    R4, R4, #1  @ Decrement the binary counter

    CMP    R4, #0  @ If counter reaches 0, change direction to increment
    BLE    change_direction_to_increment
    B      loop

change_direction_to_decrement:
    MOV    R5, #0   @ Change direction to decrement
    B      loop

change_direction_to_increment:
    MOV    R5, #1   @ Change direction to increment
    B      loop