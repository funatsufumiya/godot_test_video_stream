#!/bin/bash 
cd $(dirname $0)
RUST_BACKTRACE=full
/Applications/Godot.app/Contents/MacOS/Godot \
    --path . \
    res://node_2d.tscn