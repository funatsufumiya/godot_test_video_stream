#!/bin/bash

# ps1
# $ErrorActionPreference='Stop';
# Set-Location -Path $PSScriptRoot;
# cargo build
# cargo build --release
# # if not found, create dir
# if (!(Test-Path "$env:USERPROFILE\Documents\Godot\GVVideoTest\addons\gv_video\windows_x86_64\release")) {
#     New-Item -Path "$env:USERPROFILE\Documents\Godot\GVVideoTest\addons\gv_video\windows_x86_64\release" -ItemType Directory
# }
# if (!(Test-Path "$env:USERPROFILE\Documents\Godot\GVVideoTest\addons\gv_video\windows_x86_64\debug")) {
#     New-Item -Path "$env:USERPROFILE\Documents\Godot\GVVideoTest\addons\gv_video\windows_x86_64\debug" -ItemType Directory
# }
# Copy-Item -Path ".\target\release\godot_gv_video_stream.dll" -Destination "$env:USERPROFILE\Documents\Godot\GVVideoTest\addons\gv_video\windows_x86_64\release" -Force
# echo "Copied release dll"
# Copy-Item -Path ".\target\debug\godot_gv_video_stream.dll" -Destination "$env:USERPROFILE\Documents\Godot\GVVideoTest\addons\gv_video\windows_x86_64\debug" -Force
# echo "Copied debug dll"

GODOT_PROJECT_PATH=$HOME/Documents/Godot/TestVideoTest
GV_VIDEO_PATH=$GODOT_PROJECT_PATH/addons/gv_video

# mac
cd $(dirname $0) && \
    # cargo build && \
    cargo +nightly build && \
    # cargo build --release && \
    # cargo build --target=x86_64-apple-darwin && \
    cargo +nightly build --target=x86_64-apple-darwin && \
    # cargo build --release --target=x86_64-apple-darwin && \
    # mkdir -p $GODOT_PROJECT_PATH/addons/gv_video/macos_arm64/release && \
    mkdir -p $GODOT_PROJECT_PATH/addons/gv_video/macos_arm64/debug && \
    # mkdir -p $GODOT_PROJECT_PATH/addons/gv_video/macos_x86_64/release && \
    mkdir -p $GODOT_PROJECT_PATH/addons/gv_video/macos_x86_64/debug && \
    cp target/x86_64-apple-darwin/debug/libgodot_gv_video_stream.dylib $GV_VIDEO_PATH/macos_x86_64/debug && \
    echo "Copied debug dylib (x86_64)" && \
    # cp target/x86_64-apple-darwin/release/libgodot_gv_video_stream.dylib $GV_VIDEO_PATH/macos_x86_64/release && \
    # echo "Copied release dylib (x86_64)" && \
    cp target/debug/libgodot_gv_video_stream.dylib $GV_VIDEO_PATH/macos_arm64/debug && \
    echo "Copied debug dylib (arm64)" && \
    # cp target/release/libgodot_gv_video_stream.dylib $GV_VIDEO_PATH/macos_arm64/release && \
    # echo "Copied release dylib (arm64)"
    echo "Done"