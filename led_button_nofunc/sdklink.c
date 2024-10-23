#include "pico/stdlib.h"
#include "hardware/gpio.h"

// Function to set the direction of GPIO pins (input/output)
void link_gpio_set_dir(uint gpio_pin, int direction) {
    gpio_set_dir(gpio_pin, direction);  // Set the GPIO direction: 1 for output, 0 for input
}


