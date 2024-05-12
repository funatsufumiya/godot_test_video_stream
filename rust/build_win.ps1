$ErrorActionPreference = 'Stop';
$GodotProjectPath = "$env:USERPROFILE\Documents\Godot\GVVideoTest";
$GvVideoPath = "$GodotProjectPath\addons\gv_video";
Set-Location -Path $PSScriptRoot;
cargo build
if (-not $?) { exit 1; }
# cargo build --release
# if (-not $?) { exit 1; }
# if not found, create dir
if (-not (Test-Path $GvVideoPath)) {
    New-Item -ItemType Directory -Path $GvVideoPath;
    if (-not $?) { exit 1; }
    New-Item -ItemType Directory -Path "$GvVideoPath\windows_x86_64";
    if (-not $?) { exit 1; }
    # New-Item -ItemType Directory -Path "$GvVideoPath\windows_x86_64\release";
    # if (-not $?) { exit 1; }
    New-Item -ItemType Directory -Path "$GvVideoPath\windows_x86_64\debug";
}
if (-not $?) { exit 1; }
# Copy-Item -Path ".\target\release\godot_gv_video_stream.dll" -Destination "$GvVideoPath\windows_x86_64\release" -Force
# if (-not $?) { exit 1; }
# echo "Copied release dll"
Copy-Item -Path ".\target\debug\godot_gv_video_stream.dll" -Destination "$GvVideoPath\windows_x86_64\debug" -Force
if (-not $?) { exit 1; }
echo "Copied debug dll"