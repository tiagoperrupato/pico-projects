.EQU    SEG_A, 0      @ GP0
.EQU    SEG_B, 1      @ GP1
.EQU    SEG_C, 2      @ GP2
.EQU    SEG_D, 3      @ GP3
.EQU    SEG_E, 4      @ GP4
.EQU    SEG_F, 5      @ GP5
.EQU    SEG_G, 6      @ GP6
.EQU    GPIO_OUT, 1   @ GPIO direction
.EQU    sleep_time, 1000  @ 1 second delay

.thumb_func
.global main

main:
    @ Initialize GPIO pins for segments A to G
    MOV     R0, #SEG_A
    BL      gpio_init
    MOV     R0, #SEG_A
    MOV     R1, #GPIO_OUT
    BL      link_gpio_set_dir

    MOV     R0, #SEG_B
    BL      gpio_init
    MOV     R0, #SEG_B
    MOV     R1, #GPIO_OUT
    BL      link_gpio_set_dir

    MOV     R0, #SEG_C
    BL      gpio_init
    MOV     R0, #SEG_C
    MOV     R1, #GPIO_OUT
    BL      link_gpio_set_dir

    MOV     R0, #SEG_D
    BL      gpio_init
    MOV     R0, #SEG_D
    MOV     R1, #GPIO_OUT
    BL      link_gpio_set_dir

    MOV     R0, #SEG_E
    BL      gpio_init
    MOV     R0, #SEG_E
    MOV     R1, #GPIO_OUT
    BL      link_gpio_set_dir

    MOV     R0, #SEG_F
    BL      gpio_init
    MOV     R0, #SEG_F
    MOV     R1, #GPIO_OUT
    BL      link_gpio_set_dir

    MOV     R0, #SEG_G
    BL      gpio_init
    MOV     R0, #SEG_G
    MOV     R1, #GPIO_OUT
    BL      link_gpio_set_dir

loop:
	@ Display 0 -> 1 transition: turn off A, D, E, F; leave B, C on
    MOV     R0, #SEG_A
    MOV     R1, #1
    BL      link_gpio_put    @ Turn off A for 1
    MOV     R0, #SEG_D
    MOV     R1, #1
    BL      link_gpio_put    @ Turn off D for 1
    MOV     R0, #SEG_E
    MOV     R1, #1
    BL      link_gpio_put    @ Turn off E for 1
    MOV     R0, #SEG_F
    MOV     R1, #1
    BL      link_gpio_put    @ Turn off F for 1
    MOV     R0, #SEG_B
    MOV     R1, #1
    BL      link_gpio_put    @ Keep B on for 1
    MOV     R0, #SEG_C
    MOV     R1, #1
    BL      link_gpio_put    @ Keep C on for 1

    LDR     R0, =sleep_time
    BL      sleep_ms

    @ Display 0 -> 1 transition: turn off A, D, E, F; leave B, C on
    MOV     R0, #SEG_A
    MOV     R1, #0
    BL      link_gpio_put    @ Turn off A for 1
    MOV     R0, #SEG_D
    MOV     R1, #0
    BL      link_gpio_put    @ Turn off D for 1
    MOV     R0, #SEG_E
    MOV     R1, #0
    BL      link_gpio_put    @ Turn off E for 1
    MOV     R0, #SEG_F
    MOV     R1, #0
    BL      link_gpio_put    @ Turn off F for 1

    LDR     R0, =sleep_time
    BL      sleep_ms

    @ Display 1 -> 2 transition: turn off C; turn on A, D, E, G
    MOV     R0, #SEG_C
    MOV     R1, #0
    BL      link_gpio_put    @ Turn off C for 2
    MOV     R0, #SEG_A
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on A for 2
    MOV     R0, #SEG_D
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on D for 2
    MOV     R0, #SEG_E
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on E for 2
    MOV     R0, #SEG_G
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on G for 2

    LDR     R0, =sleep_time
    BL      sleep_ms

    @ Display 2 -> 3 transition: turn on C; turn off E
    MOV     R0, #SEG_C
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on C for 3
    MOV     R0, #SEG_E
    MOV     R1, #0
    BL      link_gpio_put    @ Turn off E for 3

    LDR     R0, =sleep_time
    BL      sleep_ms

    @ Display 3 -> 4 transition: turn off A, D; turn on F
    MOV     R0, #SEG_A
    MOV     R1, #0
    BL      link_gpio_put    @ Turn off A for 4
    MOV     R0, #SEG_D
    MOV     R1, #0
    BL      link_gpio_put    @ Turn off D for 4
    MOV     R0, #SEG_F
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on F for 4

    LDR     R0, =sleep_time
    BL      sleep_ms

	 @ Display 4 -> 5 transition: turn off B; turn on A, D, E
    MOV     R0, #SEG_B
    MOV     R1, #0
    BL      link_gpio_put    @ Turn off B for 5
    MOV     R0, #SEG_A
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on A for 5
    MOV     R0, #SEG_D
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on D for 5
    MOV     R0, #SEG_E
    MOV     R1, #0
    BL      link_gpio_put    @ Turn on E for 5

    LDR     R0, =sleep_time
    BL      sleep_ms

    @ Display 5 -> 6 transition: turn on C, G; turn off B
	MOV     R0, #SEG_E
    MOV     R1, #1
    BL      link_gpio_put    @ Turn off B for 5

    LDR     R0, =sleep_time
    BL      sleep_ms

    @ Display 6 -> 7 transition: turn off E, F, G, D; turn on B
    MOV     R0, #SEG_E
    MOV     R1, #0
    BL      link_gpio_put    @ Turn off E for 7
    MOV     R0, #SEG_F
    MOV     R1, #0
    BL      link_gpio_put    @ Turn off F for 7
    MOV     R0, #SEG_G
    MOV     R1, #0
    BL      link_gpio_put    @ Turn off G for 7
    MOV     R0, #SEG_D
    MOV     R1, #0
    BL      link_gpio_put    @ Turn off D for 7
    MOV     R0, #SEG_B
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on B for 7

    LDR     R0, =sleep_time
    BL      sleep_ms

    @ Display 7 -> 8 transition: turn on A, D, E, F, G
    MOV     R0, #SEG_A
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on A for 8
    MOV     R0, #SEG_D
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on D for 8
    MOV     R0, #SEG_E
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on E for 8
    MOV     R0, #SEG_F
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on F for 8
    MOV     R0, #SEG_G
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on G for 8

    LDR     R0, =sleep_time
    BL      sleep_ms

    @ Display 8 -> 9 transition: turn off E
    MOV     R0, #SEG_E
    MOV     R1, #0
    BL      link_gpio_put    @ Turn off E for 9

    LDR     R0, =sleep_time
    BL      sleep_ms

    @ Display 9 -> 8 transition: turn off E
    MOV     R0, #SEG_E
    MOV     R1, #1
    BL      link_gpio_put    @ Turn off E for 9

    LDR     R0, =sleep_time
    BL      sleep_ms

	@ Display 8 -> 7 transition: turn on A, D, E, F, G
    MOV     R0, #SEG_D
    MOV     R1, #0
    BL      link_gpio_put    @ Turn on D for 8
    MOV     R0, #SEG_E
    MOV     R1, #0
    BL      link_gpio_put    @ Turn on E for 8
    MOV     R0, #SEG_F
    MOV     R1, #0
    BL      link_gpio_put    @ Turn on F for 8
    MOV     R0, #SEG_G
    MOV     R1, #0
    BL      link_gpio_put    @ Turn on G for 8

    LDR     R0, =sleep_time
    BL      sleep_ms

	@ Display 7 -> 6 transition: turn on A, D, E, F, G
    MOV     R0, #SEG_B
    MOV     R1, #0
    BL      link_gpio_put    @ Turn on D for 8
    MOV     R0, #SEG_E
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on E for 8
    MOV     R0, #SEG_D
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on F for 8
    MOV     R0, #SEG_G
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on G for 8
	MOV     R0, #SEG_F
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on D for 8

    LDR     R0, =sleep_time
    BL      sleep_ms

	@ Display 6 -> 5 transition: turn on A, D, E, F, G
    MOV     R0, #SEG_E
    MOV     R1, #0
    BL      link_gpio_put    @ Turn on D for 8

    LDR     R0, =sleep_time
    BL      sleep_ms

	@ Display 5 -> 4 transition: turn on A, D, E, F, G
    MOV     R0, #SEG_D
    MOV     R1, #0
    BL      link_gpio_put    @ Turn on D for 8
	MOV     R0, #SEG_A
    MOV     R1, #0
    BL      link_gpio_put    @ Turn on D for 8
	MOV     R0, #SEG_B
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on D for 8

    LDR     R0, =sleep_time
    BL      sleep_ms

	@ Display 4 -> 3 transition: turn on A, D, E, F, G
    MOV     R0, #SEG_A
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on D for 8
	MOV     R0, #SEG_D
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on D for 8
	MOV     R0, #SEG_G
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on D for 8
	MOV     R0, #SEG_F
    MOV     R1, #0
    BL      link_gpio_put    @ Turn on D for 8

    LDR     R0, =sleep_time
    BL      sleep_ms

	@ Display 3 -> 2 transition: turn on A, D, E, F, G
    MOV     R0, #SEG_E
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on D for 8
	MOV     R0, #SEG_C
    MOV     R1, #0
    BL      link_gpio_put    @ Turn on D for 8

    LDR     R0, =sleep_time
    BL      sleep_ms

	@ Display 2 -> 1 transition: turn on A, D, E, F, G
    MOV     R0, #SEG_E
    MOV     R1, #0
    BL      link_gpio_put    @ Turn on D for 8
	MOV     R0, #SEG_C
    MOV     R1, #1
    BL      link_gpio_put    @ Turn on D for 8
	MOV     R0, #SEG_D
    MOV     R1, #0
    BL      link_gpio_put    @ Turn on D for 8
	MOV     R0, #SEG_A
    MOV     R1, #0
    BL      link_gpio_put    @ Turn on D for 8
	MOV     R0, #SEG_G
    MOV     R1, #0
    BL      link_gpio_put    @ Turn on D for 8

    LDR     R0, =sleep_time
    BL      sleep_ms

    B       loop    @ Repeat loop infinitely