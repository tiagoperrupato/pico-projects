#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/irq.h"
#include "hardware/gpio.h"

// Define GPIO pins for LEDs and buttons
#define LED_PIN1 1
#define LED_PIN2 2
#define LED_PIN3 3
#define LED_PIN4 4
#define BUTTON_INC 5
#define BUTTON_DEC 6
#define NUMBER_LEDS 4

// Initialize counter variable
volatile int counter = 0;
int led_masks[] = {0x01, 0x02, 0x04, 0x08};

// Function to update the LEDs to represent the current counter value
void update_leds(int value) {
    int pin;
    for (pin = 1; pin <= NUMBER_LEDS; pin++) {
        gpio_put(pin, ((value & led_masks[pin-1]) >> (pin-1)));
    }
}

// Interrupt handler for the increment or decrement button
void button_callback(uint gpio, uint32_t events) {
    if (gpio == BUTTON_INC && (events & GPIO_IRQ_EDGE_FALL)) {
        if (counter < 15) {
            counter++;
            update_leds(counter);
        }
    } else if (gpio == BUTTON_DEC && (events & GPIO_IRQ_EDGE_FALL)) {
        if (counter > 0) {
            counter--;
            update_leds(counter);
        }
    }
}

int main() {
    // Initialize stdio (if needed for debugging)
    stdio_init_all();

    // Initialize LED pins as outputs
    gpio_init(LED_PIN1);
    gpio_set_dir(LED_PIN1, GPIO_OUT);
    gpio_init(LED_PIN2);
    gpio_set_dir(LED_PIN2, GPIO_OUT);
    gpio_init(LED_PIN3);
    gpio_set_dir(LED_PIN3, GPIO_OUT);
    gpio_init(LED_PIN4);
    gpio_set_dir(LED_PIN4, GPIO_OUT);

    // Initialize button pins as inputs with pull-up resistors
    gpio_init(BUTTON_INC);
    gpio_set_dir(BUTTON_INC, GPIO_IN);
    
    gpio_init(BUTTON_DEC);
    gpio_set_dir(BUTTON_DEC, GPIO_IN);

    // Set up interrupt handlers for button press events (falling edge)
    gpio_set_irq_enabled_with_callback(BUTTON_INC, GPIO_IRQ_EDGE_FALL, true, &button_callback);
    gpio_set_irq_enabled(BUTTON_DEC, GPIO_IRQ_EDGE_FALL, true);

    // Initialize LEDs to represent the counter's starting value (0)
    update_leds(counter);

    // Keep the main program running indefinitely
    while (1) {
        tight_loop_contents();  // Loop to keep the program alive
    }

    return 0;
}