#include "pico/stdlib.h"
#include "hardware/gpio.h"

// Function to set the direction of GPIO pins (input/output)
void link_gpio_set_dir(uint gpio_pin, int direction) {
    gpio_set_dir(gpio_pin, direction);  // Set the GPIO direction: 1 for output, 0 for input
}

// Function to write a value to a GPIO pin (turn LED on or off)
void link_gpio_put(uint gpio_pin, int value) {
    gpio_put(gpio_pin, value);  // Write the specified value (1 for high, 0 for low) to the GPIO pin
}

// Function to read the state of a GPIO pin (read pushbutton status)
int link_gpio_get(uint gpio_pin) {
    return gpio_get(gpio_pin);  // Return the current state of the GPIO pin (1 if high, 0 if low)
}

