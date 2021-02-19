
cmake_minimum_required(VERSION 3.4.2)

project("myffmpeg42demo")

include_directories(${PROJECT_SOURCE_DIR}/ffmpeg/include)

#link_directories(${CMAKE_SOURCE_DIR}/../jniLibs/armeabi)

message("CMAKE_CXX_FLAGS:" + ${CMAKE_CXX_FLAGS})
message("CMAKE_SOURCE_DIR:" + ${CMAKE_SOURCE_DIR})

message("CMAKE_ANDROID_ARCH_ABI版本是:" + ${CMAKE_ANDROID_ARCH_ABI})

# 引入FFmpeg的库文件，设置内部的方式引入，指定库的目录是 -L  指定具体的库-l
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -L${CMAKE_SOURCE_DIR}/../jniLibs/${CMAKE_ANDROID_ARCH_ABI}")


add_library( # Sets the name of the library.
        native-lib
        SHARED
        native-lib.cpp)


find_library( # Sets the name of the path variable.
        log-lib

        log)


target_link_libraries( # Specifies the target library.
        native-lib

        avformat avcodec avfilter avutil swresample swscale

        ${log-lib})