include_directories(${CMAKE_SOURCE_DIR})

add_executable(SegmentDisplay
  segmentdisplay.S
  sdklink.c
)

pico_enable_stdio_uart(SegmentDisplay 1)

pico_add_extra_outputs(SegmentDisplay)

target_link_libraries(SegmentDisplay pico_stdlib)