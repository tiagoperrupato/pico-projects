include_directories(${CMAKE_SOURCE_DIR})

add_executable(HelloWorld
  HelloWorld.S
)

pico_enable_stdio_uart(HelloWorld 0)
pico_enable_stdio_usb(HelloWorld 1)

pico_add_extra_outputs(HelloWorld)

target_link_libraries(HelloWorld pico_stdlib)