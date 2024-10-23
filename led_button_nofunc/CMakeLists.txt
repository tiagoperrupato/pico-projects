include_directories(${CMAKE_SOURCE_DIR})

add_executable(LED_Button_Nofunc
  led_button_nofunc.S
  sdklink.c
)

pico_enable_stdio_uart(LED_Button_Nofunc 1)

pico_add_extra_outputs(LED_Button_Nofunc)

target_link_libraries(LED_Button_Nofunc pico_stdlib)