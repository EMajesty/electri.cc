#!/bin/bash

REPO_URL="https://github.com/emajesty/ssgoat.git"
BUILD_DIR="./build"

install_rust() {
    echo "Installing Rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
}

echo "Hell world"

if ! command -v cargo &> /dev/null; then
    echo "Cargo not found"
    install_rust
fi

cargo install --git $REPO_URL

if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
fi

mkdir -p "$BUILD_DIR"

ssgoat . "$BUILD_DIR"
