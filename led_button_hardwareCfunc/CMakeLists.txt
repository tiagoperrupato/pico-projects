include_directories(${CMAKE_SOURCE_DIR})

add_executable(LED_Button_HardwareCFunc
  led_button_hardwareCfunc.c
)

pico_enable_stdio_uart(LED_Button_HardwareCFunc 1)

pico_add_extra_outputs(LED_Button_HardwareCFunc)

target_link_libraries(LED_Button_HardwareCFunc pico_stdlib)