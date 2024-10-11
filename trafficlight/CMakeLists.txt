include_directories(${CMAKE_SOURCE_DIR})

add_executable(TrafficLights
  trafficlights.S
  sdklink.c
)

pico_enable_stdio_uart(TrafficLights 1)

pico_add_extra_outputs(TrafficLights)

target_link_libraries(TrafficLights pico_stdlib)