# convert-0001-0250.ps1
# Checks for ffmpeg and converts Imgs\0001-0250.mkv -> Imgs\0001-0250.mp4 (H.264/AAC)

$src = "Imgs\0001-0250.mkv"
$dst = "Imgs\0001-0250.mp4"

if (-not (Test-Path $src)) {
    Write-Error "Source file not found: $src"
    exit 1
}

if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    Write-Host "ffmpeg is not installed or not on PATH. Install it first (see instructions)."
    Write-Host "Windows (winget): winget install --id=FFmpeg.FFmpeg -e"
    Write-Host "Or download from: https://ffmpeg.org/download.html"
    exit 1
}

Write-Host "Starting conversion: $src -> $dst"
ffmpeg -y -i $src -c:v libx264 -crf 22 -preset medium -c:a aac -b:a 160k $dst

if (Test-Path $dst) {
    Write-Host "Conversion complete: $dst"
    exit 0
} else {
    Write-Error "Conversion failed. Check ffmpeg output above for errors."
    exit 1
}