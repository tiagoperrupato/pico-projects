#include <stdio.h>
#include "pico/stdlib.h"
#include "pico/time.h"


#define LED_PIN 0
#define BUTTON_ON 1
#define BUTTON_OFF 2

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
        if(gpio_get(BUTTON_ON)) {
            gpio_put(LED_PIN, 1);
        }

        if(gpio_get(BUTTON_OFF)) {
            gpio_put(LED_PIN, 0);
        }

        sleep_ms(20);
    }

    return 0;
}