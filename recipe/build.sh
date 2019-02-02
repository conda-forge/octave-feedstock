#!/usr/bin/env bash

export CPPFLAGS="-I${PREFIX}/include ${CPPFLAGS}"

chmod +x configure
chmod +x build-aux/mk-opts.pl

./configure --help
./configure --prefix=$PREFIX \
    --disable-docs \
    --enable-readline \
    --enable-shared \
    --with-lapack="-lopenblas" \
    --without-fltk \
    --enable-dl \
    --without-qrupdate \
    --with-qt=5 \
    --with-magick=GraphicsMagick \
    --without-framework-carbon \
    --with-hdf5-includedir=${PREFIX}/include \
    --with-hdf5-libdir=${PREFIX}/lib

make -j${CPU_COUNT}
make install

