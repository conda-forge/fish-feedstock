#!/bin/sh

export CFLAGS="-I$PREFIX/include -I$PREFIX/include/ncursesw"
export CXXFLAGS="-I$PREFIX/include -I$PREFIX/include/ncursesw -static-libstdc++"

echo $PKG_VERSION > version
autoreconf -fiv
./configure --prefix=$PREFIX || cat config.log
make -j$CPU_COUNT
make install
