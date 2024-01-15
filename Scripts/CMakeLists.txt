cmake_minimum_required(VERSION 3.27)
project(power_window C)

set(CMAKE_C_STANDARD 99)

set(IMAGE_SOURCE_PATH ${CMAKE_SOURCE_DIR}/MononokiNerdFontMono-Regular.ttf)
set(IMAGE_DEST_PATH ${CMAKE_BINARY_DIR}/MononokiNerdFontMono-Regular.ttf)
configure_file(${IMAGE_SOURCE_PATH} ${IMAGE_DEST_PATH} COPYONLY)

add_executable(power_window power_window.c)

target_link_libraries(power_window PRIVATE raylib)
