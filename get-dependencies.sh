#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    libdecor \
    sdl2

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
echo "Making nightly build of Raptor..."
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
mv -v  ../../AppDir/bin
