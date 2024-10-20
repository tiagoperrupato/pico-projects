.thumb_func @ Necessary because sdk uses BLX
.global main @ Provide program starting address to linker

main:
    BL stdio_init_all @ initialize uart or usb
loop:
    LDR R0, =my_array
    MOV R1, #8 @ 8 elements in the array
    BL average @ Call the subroutine average, with parameters R0 and R1

    @Print string and average value
    MOV R1, R0 @ Move average value to printf parameter R1
    LDR R0, =message_str  @ load address of helloworld string
    BL printf @ Call pico_printf
    B loop @ loop forever

@Subroutine average takes the parameters:
@R0 - Memory address to first element of integer array
@R1 - Number of integers in the array
@R0 - Return value (integer average value)
average:
    PUSH {LR}   @stack the address of the function return point
    BL sum
    LSR R0, #3  @devide the sum by 8, since we have 8 numbers
    POP {PC}    @get the return address
    BX LR
@Subroutine sum of numbers takes the parameters:
@R0 - Memory address to first element of integer array
@R1 - Number of integers in the array
@R0 - Return value (integer sum value)
sum:
    MOV R2, #0
    MOV R3, #0
    loop1:
        LDR R4, [R0, R2]
        ADD R3, R3, R4
        ADD R2, R2, #4
        SUB R1, R1, #1
        CMP R1, #0
        BGT loop1
    MOV R0, R3
    BX LR

.data
    .align 4 @ necessary alignment
    message_str: .asciz "Average value %d\n"
    .align 4 @ necessary alignment
    my_array: .word 10, 20, 30, 40, 50, 60, 70, 80