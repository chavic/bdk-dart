#!/usr/bin/env bash
set -euo pipefail

OS=$(uname -s)
echo "Running on $OS"

dart --version
dart pub get

# Install Rust targets if on macOS
if [[ "$OS" == "Darwin" ]]; then
    LIBNAME=libbdkffi.dylib
elif [[ "$OS" == "Linux" ]]; then
    LIBNAME=libbdkffi.so
else
    echo "Unsupported os: $OS"
    exit 1
fi

# Run from the specific crate inside the embedded submodule
cd ./bdk-ffi/bdk-ffi/
echo "Building bdk-ffi crate and (skipping uniffi dart codegen in this CLI)..."
cargo build --profile dev -p bdk-ffi
# NOTE: The current uniffi-bindgen CLI in this toolchain does not support '--language dart'.
# We keep the previously generated Dart bindings checked in under ../lib/bdk.dart.
# To regenerate Dart bindings, run the appropriate generator from a toolchain that supports Dart.

if [[ "$OS" == "Darwin" ]]; then
    echo "Generating native binaries..."
    rustup target add aarch64-apple-darwin x86_64-apple-darwin
    # This is a test script the actual release should not include the test utils feature
    cargo build --profile dev -p bdk-ffi --target aarch64-apple-darwin &
    cargo build --profile dev -p bdk-ffi --target x86_64-apple-darwin &
    wait

    echo "Building macOS fat library"
    lipo -create -output ../../$LIBNAME \
        target/aarch64-apple-darwin/debug/$LIBNAME \
        target/x86_64-apple-darwin/debug/$LIBNAME
else
    echo "Generating native binaries..."
    rustup target add x86_64-unknown-linux-gnu
    # This is a test script the actual release should not include the test utils feature
    cargo build --profile dev -p bdk-ffi --target x86_64-unknown-linux-gnu

    echo "Copying bdk-ffi binary"
    cp target/x86_64-unknown-linux-gnu/debug/$LIBNAME ../../$LIBNAME
fi

echo "All done!"
