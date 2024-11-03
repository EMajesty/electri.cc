#!/bin/bash

REPO_URL="https://github.com/emajesty/ssgoat.git"
BUILD_DIR="./build"

cargo install --git $REPO_URL

if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
fi

mkdir -p "$BUILD_DIR"

ssgoat . "$BUILD_DIR"
