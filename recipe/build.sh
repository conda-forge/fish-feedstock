#!/bin/sh
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./pcre2-10.32

export CXXFLAGS="-I$PREFIX/include -I$PREFIX/include/ncursesw -static-libstdc++"

mkdir build
cd build
cmake ${CMAKE_ARGS} .. -DCMAKE_INSTALL_PREFIX="$PREFIX" -DCMAKE_BUILD_TYPE=Release
make -j$CPU_COUNT
make install
