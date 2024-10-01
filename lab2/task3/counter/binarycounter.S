.EQU	LED_PIN1, 0
.EQU	LED_PIN2, 1
.EQU	LED_PIN3, 2
.EQU	GPIO_OUT, 1
.EQU	sleep_time, 1000  # 1 second delay

.thumb_func	@ Necessary because sdk uses BLX
.global main @ Provide program starting address

main:
    # Initialize GPIO pins as before
    # ... (same as previous code)

    # Initialize counter variable
    MOV R4, #0  # R4 will store the counter value

loop:
    # Convert counter value to binary
    AND R0, R4, #1  # Extract least significant bit
    BL link_gpio_put  # Set LED_PIN1 based on R0
    LSR R4, R4, #1  # Shift counter value right
    AND R0, R4, #1  # Extract second least significant bit
    BL link_gpio_put  # Set LED_PIN2 based on R0
    LSR R4, R4, #1  # Shift counter value right
    AND R0, R4, #1  # Extract most significant bit
    BL link_gpio_put  # Set LED_PIN3 based on R0

    # Delay for 1 second
    LDR R0, =sleep_time
    BL sleep_ms

    # Increment or decrement counter based on current value
    CMP R4, #7  # Check if counter is at maximum value
    BNE increment
    MOV R4, #0  # Reset counter to 0
    B loop

increment:
    ADD R4, R4, #1  # Increment counter
    B loop