#!/bin/sh
# make lha

if [ ! -e configure ] ; then
  aclocal
  autoheader
  automake -a
  autoconf
fi

# ppc
PATH=/Xcode2.5/usr/bin:${PATH} NEXT_ROOT=/Xcode2.5/SDKs/MacOSX10.2.8.sdk MACOSX_DEPLOYMENT_TARGET=10.2 CC=gcc-3.3 CPP=cpp-3.3 CFLAGS="-arch ppc -I/usr/local/include -Os -isystem /Xcode2.5/SDKs/MacOSX10.2.8.sdk/usr/include/gcc/darwin/3.3 -isystem /Xcode2.5/SDKs/MacOSX10.2.8.sdk/usr/include" CPPFLAGS="-arch ppc" LDFLAGS="-arch ppc -L/usr/local/lib" ./configure --disable-dependency-tracking --enable-iconv=no --enable-multibyte-filename=utf8

PATH=/Xcode2.5/usr/bin:${PATH} NEXT_ROOT=/Xcode2.5/SDKs/MacOSX10.2.8.sdk MACOSX_DEPLOYMENT_TARGET=10.2 make LDFLAGS="-arch ppc -L/usr/local/lib -lapplefile -framework CoreFoundation -mmacosx-version-min=10.2 -Wl,-syslibroot,/Xcode2.5/SDKs/MacOSX10.2.8.sdk"

mkdir -p ppc
cp src/lha ppc
make distclean

# i386
PATH=/Developer/usr/bin:${PATH} MACOSX_DEPLOYMENT_TARGET=10.4 CC=gcc-4.0 CFLAGS="-arch i386 -isysroot /Developer/SDKs/MacOSX10.4u.sdk -I/usr/local/include -Os -mmacosx-version-min=10.4" CPP=cpp-4.0 CPPFLAGS="-arch i386 -mmacosx-version-min=10.4" LDFLAGS="-arch i386 -Wl,-syslibroot,/Developer/SDKs/MacOSX10.4u.sdk -L/usr/local/lib -mmacosx-version-min=10.4" ./configure --disable-dependency-tracking --enable-iconv=no --enable-multibyte-filename=utf8

PATH=/Developer/usr/bin:${PATH} MACOSX_DEPLOYMENT_TARGET=10.4 make

mkdir -p i386
cp src/lha i386/lha
make distclean

# x86_64
PATH=/Developer/usr/bin:${PATH} MACOSX_DEPLOYMENT_TARGET=10.5 CC=llvm-gcc-4.2 CFLAGS="-arch x86_64 -isysroot /Developer/SDKs/MacOSX10.5.sdk -I/usr/local/include -Os -mmacosx-version-min=10.5" CPP=llvm-cpp-4.2 CPPFLAGS="-arch x86_64 -mmacosx-version-min=10.5" LDFLAGS="-arch x86_64 -Wl,-syslibroot,/Developer/SDKs/MacOSX10.5.sdk -L/usr/local/lib -mmacosx-version-min=10.5" ./configure --disable-dependency-tracking --enable-iconv=no --enable-multibyte-filename=utf8

PATH=/Developer/usr/bin:${PATH} MACOSX_DEPLOYMENT_TARGET=10.5 make

mkdir -p x86_64
cp src/lha x86_64
make distclean

# universal binary
lipo -arch ppc ppc/lha -arch i386 i386/lha -arch x86_64 x86_64/lha -create -output lha

echo ""
echo "Build succeed. Copy lha to anywhere."
