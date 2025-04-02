#!/bin/bash

cp -rf "${MESON_SOURCE_ROOT}"/PathOfBuildingBuild/* "${MESON_INSTALL_PREFIX}"/Contents/MacOS/
cp -f "${MESON_SOURCE_ROOT}"/fonts/*.ttf "${MESON_INSTALL_PREFIX}"/Contents/MacOS/

mkdir -p "${MESON_INSTALL_PREFIX}/Contents/Frameworks"

# Meson doesn't bundle dependencies of our shared library by default, so we have
# to do it on our own.
#
# This fixes the error:
# "Symbol not found: _curl_easy_option_by_id" since that didn't exist in older
# cURL libraries.
echo 'Bundling dylibs for lcurl.so'
cd "${MESON_INSTALL_PREFIX}/Contents"
dylibbundler --overwrite-dir --create-dir --bundle-deps --fix-file MacOS/lcurl.so
