#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm cmake sdl2-compat

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini

echo "Building Raptor..."
echo "---------------------------------------------------------------"
REPO="https://github.com/skynettx/raptor"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone --depth 1 "$REPO" ./raptor
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cmake -S ./raptor -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build -j$(nproc)
mv -v ./build/bin/raptor ./build/bin/raptorsetup ./AppDir/bin
