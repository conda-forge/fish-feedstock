#!/usr/bin/env bash

set -exo pipefail

cd src
cargo-bundle-licenses --format yaml --output ../THIRDPARTY.yml

mkdir build
cd build

export RUSTFLAGS="${CARGO_BUILD_RUSTFLAGS}"

extra_cmake_args=(
    -DWITH_GETTEXT=ON
    -DGETTEXT_MSGFMT_EXECUTABLE="${BUILD_PREFIX}/bin/msgfmt"
    -DFISH_USE_SYSTEM_PCRE2=ON
)

case "${target_platform}" in
linux-ppc64le)
    # CFLAGS -mcpu=power8 -mtune=power8 break the ppc64le build
    export CFLAGS=$(echo $CFLAGS | sed -E 's?-mcpu=[^ ]+ ??; s?-mtune=[^ ]+ ??')
    ;;
osx-64 | osx-arm64)
    extra_cmake_args+=(-DMAC_CODESIGN_ID=OFF)
    ;;
esac

if [[ "${target_platform}" != "${build_platform}" ]]; then
    extra_cmake_args+=(
        -DRUST_BUILD_TARGET=${CARGO_BUILD_TARGET}
        -DRust_CARGO_TARGET=${CARGO_BUILD_TARGET}
    )
fi

cmake ${CMAKE_ARGS} "${extra_cmake_args[@]}" ${SRC_DIR}/src

cmake --build .

if [[ "${target_platform}" == "linux-64" ]]; then
    cmake --build . --target fish_run_tests
fi

cmake --install .

# Tell `pixi global` to not set CONDA_PREFIX during activation
# https://pixi.sh/dev/global_tools/introduction/#opt-out-of-conda_prefix
mkdir -p "${PREFIX}/etc/pixi/fish"
touch "${PREFIX}/etc/pixi/fish/global-ignore-conda-prefix"
