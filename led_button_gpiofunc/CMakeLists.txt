include_directories(${CMAKE_SOURCE_DIR})

add_executable(LED_Button_GPIOFunc
  led_button_gpiofunc.c
)

pico_enable_stdio_uart(LED_Button_GPIOFunc 1)

pico_add_extra_outputs(LED_Button_GPIOFunc)

target_link_libraries(LED_Button_GPIOFunc pico_stdlib)