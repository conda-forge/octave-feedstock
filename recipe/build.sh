#!/bin/bash

set -ex

export CPPFLAGS="-I${PREFIX}/include ${CPPFLAGS}"

chmod +x configure
chmod +x build-aux/mk-opts.pl

if [[ $target_platform == "linux-ppc64le" || $target_platform == "osx-arm64" || $target_platform == "linux-aarch64" ]]; then
    # Needs to be set for cross-compilation
    export ax_blas_integer_size=4
fi

if [[ $target_platform == "osx-arm64" ]]; then
    which pkg-config
    pkg-config --version
    printenv | grep PKG

    export PKG_CONFIG=${BUILD_PREFIX}/bin/pkg-config
fi

./configure --help
./configure --prefix=$PREFIX \
    --enable-readline \
    --without-pcre2 \
    --enable-shared \
    --with-blas="-lblas" \
    --with-lapack="-llapack" \
    --with-fltk \
    --enable-dl \
    --without-qrupdate \
    --with-qt=5 \
    --with-magick=GraphicsMagick++ \
    --without-framework-carbon \
    --with-hdf5-includedir=${PREFIX}/include \
    --with-hdf5-libdir=${PREFIX}/lib || { cat config.log; exit 1; }

make -j${CPU_COUNT}
make install

# Copy the [de]activate scripts to $PREFIX/etc/conda/[de]activate.d.
# This will allow them to be run on environment activation.
for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${RECIPE_DIR}/scripts/${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
done

