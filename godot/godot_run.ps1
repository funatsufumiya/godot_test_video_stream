cd $(Split-Path $MyInvocation.MyCommand.Path)
$env:RUST_BACKTRACE="full"
godot --path . res://node_2d.tscn