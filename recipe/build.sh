#!/bin/sh
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./pcre2/

mkdir build
cd build
cmake ${CMAKE_ARGS} .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DGETTEXT_MSGFMT_EXECUTABLE="${BUILD_PREFIX}/bin/msgfmt" \
    -DFISH_USE_SYSTEM_PCRE2=ON \
    -Dmbrtowc_invalid_utf8_exit=OFF

make -j$CPU_COUNT

make install
