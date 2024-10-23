.EQU    LED_PIN, 0         
.EQU    BUTTON1_PIN, 1     
.EQU    BUTTON2_PIN, 2     
.EQU    GPIO_OUT, 1
.EQU    GPIO_IN, 0        

.thumb_func  
.global main    

main:
    MOV    R0, #LED_PIN
    BL     gpio_init
    MOV    R0, #LED_PIN
    MOV    R1, #GPIO_OUT
    BL     link_gpio_set_dir

    MOV    R0, #BUTTON1_PIN
    BL     gpio_init
    MOV    R0, #BUTTON1_PIN
    MOV    R1, #GPIO_IN
    BL     link_gpio_set_dir

    MOV    R0, #BUTTON2_PIN
    BL     gpio_init
    MOV    R0, #BUTTON2_PIN
    MOV    R1, #GPIO_IN
    BL     link_gpio_set_dir

    MOV    R3, #0

loop:
    MOV    R0, #BUTTON1_PIN
    BL     link_gpio_get     
    CMP    R0, #1           
    BEQ    turn_on_led      

    MOV    R0, #BUTTON2_PIN
    BL     link_gpio_get    
    CMP    R0, #1            
    BEQ    turn_off_led      

    B      loop             

turn_on_led:
    MOV    R0, #LED_PIN
    MOV    R1, #1           
    BL     link_gpio_put
    B      loop              

turn_off_led:
    MOV    R0, #LED_PIN
    MOV    R1, #0            
    BL     link_gpio_put
    B      loop              