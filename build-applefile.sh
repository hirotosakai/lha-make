#!/bin/sh
# make libapplefile

# prepare
cp /usr/share/automake-1.10/config.* .

# PPC
PATH=/Xcode2.5/usr/bin:${PATH} NEXT_ROOT=/Xcode2.5/SDKs/MacOSX10.2.8.sdk MACOSX_DEPLOYMENT_TARGET=10.2 CC=gcc-3.3 CFLAGS="-arch ppc -Os -isystem /Xcode2.5/SDKs/MacOSX10.2.8.sdk/usr/include/gcc/darwin/3.3 -isystem /Xcode2.5/SDKs/MacOSX10.2.8.sdk/usr/include" CPP=cpp-3.3 CPPFLAGS="-arch ppc" ./configure --enable-shared=no

gcc -o make_crc_table make_crc_table.c

PATH=/Xcode2.5/usr/bin:${PATH} NEXT_ROOT=/Xcode2.5/SDKs/MacOSX10.2.8.sdk MACOSX_DEPLOYMENT_TARGET=10.2 make

mkdir -p ppc
cp .libs/libapplefile.* ppc
make distclean

# i386
PATH=/Developer/usr/bin:${PATH} MACOSX_DEPLOYMENT_TARGET=10.4 CC=gcc-4.0 CFLAGS="-arch i386 -isysroot /Developer/SDKs/MacOSX10.4u.sdk -mmacosx-version-min=10.4 -Os" CPP=cpp-4.0 CPPFLAGS="-arch i386" LDFLAGS="-Wl,-syslibroot,/Developer/SDKs/MacOSX10.4u.sdk -mmacosx-version-min=10.4" ./configure --enable-shared=no

gcc -o make_crc_table make_crc_table.c

PATH=/Developer/usr/bin:${PATH} MACOSX_DEPLOYMENT_TARGET=10.4 make

mkdir -p i386
cp .libs/libapplefile.* i386
make distclean

# x86_64
PATH=/Developer/usr/bin:${PATH} MACOSX_DEPLOYMENT_TARGET=10.5 CC=llvm-gcc-4.2 CFLAGS="-arch x86_64 -isysroot /Developer/SDKs/MacOSX10.5.sdk -Os -mmacosx-version-min=10.5" CPP=llvm-cpp-4.2 CPPFLAGS="-arch x86_64 -mmacosx-version-min=10.5" LDFLAGS="-arch x86_64 -Wl,-syslibroot,/Developer/SDKs/MacOSX10.5.sdk -mmacosx-version-min=10.5" ./configure --enable-shared=no

gcc -o make_crc_table make_crc_table.c

PATH=/Developer/usr/bin:${PATH} MACOSX_DEPLOYMENT_TARGET=10.5 make

mkdir -p x86_64
cp .libs/libapplefile.* x86_64
make distclean

# Universal Binary
lipo -arch ppc ppc/libapplefile.a -arch i386 i386/libapplefile.a -arch x86_64 x86_64/libapplefile.a -create -output libapplefile.a 

echo ""
echo "Build succeeded. To install, type"
echo "  sudo cp libapplefile.a /usr/local/lib"
echo "  sudo cp applefile.h af-graphics.h /usr/local/include"
