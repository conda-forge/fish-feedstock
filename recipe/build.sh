#!/bin/sh

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
mkdir build
cd build
export RUSTFLAGS="${CARGO_BUILD_RUSTFLAGS}"
cmake ${CMAKE_ARGS} .. \
      -DCMAKE_BUILD_TYPE="Release" \
      -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
      -DWITH_GETTEXT=ON \
      -DGETTEXT_MSGFMT_EXECUTABLE="${BUILD_PREFIX}/bin/msgfmt" \
      -DFISH_USE_SYSTEM_PCRE2=ON \
      -DMAC_CODESIGN_ID=OFF
      
cmake --build .
cmake --install .
