#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    cmake    \
    libdecor \
    sdl2

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Building Raptor..."
echo "---------------------------------------------------------------"
REPO="https://github.com/skynettx/raptor"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone "$REPO" ./raptor
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cd ./raptor
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
mv -v bin/raptor bin/raptorsetup ../../AppDir/bin
