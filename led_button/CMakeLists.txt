include_directories(${CMAKE_SOURCE_DIR})

add_executable(LED_Button
  led_button.S
  sdklink.c
)

pico_enable_stdio_uart(LED_Button 1)

pico_add_extra_outputs(LED_Button)

target_link_libraries(LED_Button pico_stdlib)