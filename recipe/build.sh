#!/bin/sh

export CFLAGS="-I$PREFIX/include -I$PREFIX/include/ncursesw"
export CXXFLAGS="-I$PREFIX/include -I$PREFIX/include/ncursesw -static-libstdc++"

./configure --prefix=$PREFIX || cat config.log
make -j$CPU_COUNT
make install
