#!/bin/bash

## 使用的ffmpeg是4.2.4,NDK是21

API=21
TOOLCHAIN=$NDK_PATH/toolchains/llvm/prebuilt/darwin-x86_64/
#armv8-a
ARCH=arm64
CPU=armv8-a
#r20版本的ndk中所有的编译器都在/android-ndk-r20/toolchains/llvm/prebuilt/linux-x86_64/目录下（clang）
CC=$TOOLCHAIN/bin/aarch64-linux-android$API-clang
CXX=$TOOLCHAIN/bin/aarch64-linux-android$API-clang++
#头文件环境用的不是/android-ndk-r20/sysroot,而是编译器//android-ndk-r20/toolchains/llvm/prebuilt/linux-x86_64/sysroot
SYSROOT=$NDK_PATH/toolchains/llvm/prebuilt/darwin-x86_64/sysroot
#交叉编译工具目录,对应关系如下(不明白的可以看下图)
# armv8a -> arm64 -> aarch64-linux-android-
# armv7a -> arm -> arm-linux-androideabi-
# x86 -> x86 -> i686-linux-android-
# x86_64 -> x86_64 -> x86_64-linux-android-
CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-
#输出目录
PREFIX=$(pwd)/android/$CPU
OPTIMIZE_CFLAGS="-march=$CPU"


function build_android
{
echo "CC is $CC"
echo "CROSS_PREFIX is $CROSS_PREFIX"
./configure \
	--prefix=$PREFIX \
	--enable-shared \
	--disable-static \
	--disable-ffmpeg \
	--disable-ffplay \
	--disable-ffprobe \
	--disable-avdevice \
	--disable-doc \
	--disable-symver \
	--cross-prefix=$CROSS_PREFIX \
	--target-os=android \
	--arch=$ARCH \
	--cpu=$CPU \
	--cc=$CC \
	--cxx=$CXX \
	--enable-cross-compile \
	--sysroot=$SYSROOT \
	--extra-cflags="-Os -fpic $OPTIMIZE_CFLAGS" \

make clean
make
make install

}

build_android
