include_directories(${CMAKE_SOURCE_DIR})

add_executable(Average
  average.S
)

pico_enable_stdio_uart(Average 0)
pico_enable_stdio_usb(Average 1)

pico_add_extra_outputs(Average)

target_link_libraries(Average pico_stdlib)