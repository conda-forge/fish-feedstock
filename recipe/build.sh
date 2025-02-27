#!/bin/sh

mkdir build
cd build
cmake ${CMAKE_ARGS} .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DFISH_USE_SYSTEM_PCRE2=ON \
    -Dmbrtowc_invalid_utf8_exit=OFF
cmake --build .
cmake --install .
