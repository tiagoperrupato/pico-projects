include_directories(${CMAKE_SOURCE_DIR})

add_executable(BinaryCounter
  binarycounter.S
  sdklink.c
)

pico_enable_stdio_uart(BinaryCounter 1)

pico_add_extra_outputs(BinaryCounter)

target_link_libraries(BinaryCounter pico_stdlib)