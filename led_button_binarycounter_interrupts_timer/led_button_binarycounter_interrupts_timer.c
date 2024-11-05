#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/irq.h"
#include "hardware/gpio.h"
#include "pico/time.h"

// Define GPIO pins for LEDs and buttons
#define LED_PIN1 1
#define LED_PIN2 2
#define LED_PIN3 3
#define LED_PIN4 4
#define BUTTON_RST 0
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
    counter = 0;
    update_leds(counter);
}

int64_t timer_callback(alarm_id_t id, void *unused) {
    if (counter < 15) {
        counter++;
        update_leds(counter);
    }
    return 1000 * 1000;
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

    // Initialize button pin as input
    gpio_init(BUTTON_RST);
    gpio_set_dir(BUTTON_RST, GPIO_IN);


    // Set up interrupt handlers for button press events (falling edge)
    gpio_set_irq_enabled_with_callback(BUTTON_RST, GPIO_IRQ_EDGE_FALL, true, &button_callback);
    
    add_alarm_in_us(1000 * 1000, timer_callback, NULL, true);

    // Initialize LEDs to represent the counter's starting value (0)
    update_leds(counter);

    // Keep the main program running indefinitely
    while (1) {
        tight_loop_contents();  // Loop to keep the program alive
    }

    return 0;
}