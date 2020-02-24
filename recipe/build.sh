#!/bin/sh

export CXXFLAGS="-I$PREFIX/include -I$PREFIX/include/ncursesw -static-libstdc++"

mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$PREFIX" -DCMAKE_BUILD_TYPE=Release
make -j$CPU_COUNT
make install
