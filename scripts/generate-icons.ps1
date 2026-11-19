param(
  [string]$Source = (Join-Path $PSScriptRoot '..\azot logo.png'),
  [string]$Output = (Join-Path $PSScriptRoot '..\build')
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
New-Item -ItemType Directory -Force -Path $Output | Out-Null
$sourcePath = (Resolve-Path $Source).Path
$pngPath = Join-Path $Output 'icon.png'
$image = [System.Drawing.Image]::FromFile($sourcePath)
$canvas = New-Object System.Drawing.Bitmap 512, 512
$graphics = [System.Drawing.Graphics]::FromImage($canvas)
$graphics.Clear([System.Drawing.Color]::Transparent)
$graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$ratio = [Math]::Min(512 / $image.Width, 512 / $image.Height)
$width = [int]($image.Width * $ratio)
$height = [int]($image.Height * $ratio)
$graphics.DrawImage($image, [int]((512 - $width) / 2), [int]((512 - $height) / 2), $width, $height)
$canvas.Save($pngPath, [System.Drawing.Imaging.ImageFormat]::Png)
$graphics.Dispose(); $canvas.Dispose(); $image.Dispose()

# ICO accepts a PNG payload. ICNS uses the same 512px PNG in its modern ic09 slot.
$png = [System.IO.File]::ReadAllBytes($pngPath)
$ico = New-Object System.IO.MemoryStream
$writer = New-Object System.IO.BinaryWriter($ico)
$writer.Write([UInt16]0); $writer.Write([UInt16]1); $writer.Write([UInt16]1)
$writer.Write([byte]0); $writer.Write([byte]0); $writer.Write([byte]0); $writer.Write([byte]0)
$writer.Write([UInt16]1); $writer.Write([UInt16]32); $writer.Write([UInt32]$png.Length); $writer.Write([UInt32]22); $writer.Write($png)
[System.IO.File]::WriteAllBytes((Join-Path $Output 'icon.ico'), $ico.ToArray())
$writer.Dispose(); $ico.Dispose()

$icns = New-Object System.IO.MemoryStream
$icnsWriter = New-Object System.IO.BinaryWriter($icns)
$total = 8 + 8 + $png.Length
$icnsWriter.Write([System.Text.Encoding]::ASCII.GetBytes('icns'))
$icnsWriter.Write([System.BitConverter]::GetBytes([System.Net.IPAddress]::HostToNetworkOrder($total)))
$icnsWriter.Write([System.Text.Encoding]::ASCII.GetBytes('ic09'))
$icnsWriter.Write([System.BitConverter]::GetBytes([System.Net.IPAddress]::HostToNetworkOrder(8 + $png.Length)))
$icnsWriter.Write($png)
[System.IO.File]::WriteAllBytes((Join-Path $Output 'icon.icns'), $icns.ToArray())
$icnsWriter.Dispose(); $icns.Dispose()
Write-Output "Generated build/icon.png, build/icon.ico and build/icon.icns from azot logo.png."
