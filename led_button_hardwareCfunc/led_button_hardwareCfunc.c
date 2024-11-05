#include <stdio.h>
#include "pico/stdlib.h"
#include "pico/time.h"
#include "hardware/regs/sio.h"

#define LED_PIN 0
#define BUTTON_ON 1
#define BUTTON_OFF 2

#define LED_PIN_MASK (1 << LED_PIN)
#define BUTTON_ON_MASK (1 << BUTTON_ON)
#define BUTTON_OFF_MASK (1 << BUTTON_OFF)

uint32_t *sio_gpio_in = (uint32_t *)(SIO_BASE + SIO_GPIO_IN_OFFSET);
uint32_t *sio_gpio_out_set = (uint32_t *)(SIO_BASE + SIO_GPIO_OUT_SET_OFFSET);
uint32_t *sio_gpio_out_clr = (uint32_t *)(SIO_BASE + SIO_GPIO_OUT_CLR_OFFSET);

int main() {

    // initialize the pins
    stdio_init_all();

    gpio_init(LED_PIN);
    gpio_set_dir(LED_PIN, GPIO_OUT);

    gpio_init(BUTTON_ON);
    gpio_set_dir(BUTTON_ON, GPIO_IN);

    gpio_init(BUTTON_OFF);
    gpio_set_dir(BUTTON_OFF, GPIO_IN);

    while(1) {
        if(*sio_gpio_in & BUTTON_ON_MASK) {
            *sio_gpio_out_set = LED_PIN_MASK;
        }

        if(*sio_gpio_in & BUTTON_OFF_MASK) {
            *sio_gpio_out_clr = LED_PIN_MASK;
        }

        sleep_ms(20);
    }

    return 0;
}