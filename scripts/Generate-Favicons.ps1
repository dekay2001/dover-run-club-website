param(
    [Parameter(Mandatory=$true)]
    [string]$SourceImage,

    [string]$OutputDir = "assets/images/favicons"
)

Add-Type -AssemblyName System.Drawing

if (-not (Test-Path $SourceImage)) {
    Write-Error "Source image not found: $SourceImage"
    exit 1
}

$img = [System.Drawing.Image]::FromFile((Resolve-Path $SourceImage).Path)

try {
    if ($img.Width -ne $img.Height) {
        Write-Warning "Source image is not square ($($img.Width)x$($img.Height)). Output may be distorted."
    }

    if ($img.Width -lt 512 -or $img.Height -lt 512) {
        Write-Warning "Source image is smaller than 512px. Upscaling may produce blurry results."
    }

    if (-not (Test-Path $OutputDir)) {
        New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
        Write-Host "Created output directory: $OutputDir"
    }

    $sizes = @(
        @{ Name = "favicon-16.png";         Size = 16 },
        @{ Name = "favicon-32.png";         Size = 32 },
        @{ Name = "apple-touch-icon.png";   Size = 180 },
        @{ Name = "android-chrome-192.png"; Size = 192 },
        @{ Name = "android-chrome-512.png"; Size = 512 }
    )

    foreach ($entry in $sizes) {
        $size = $entry.Size
        $outPath = Join-Path $OutputDir $entry.Name
        $bmp = $null
        $g = $null

        try {
            $bmp = New-Object System.Drawing.Bitmap($size, $size)
            $g = [System.Drawing.Graphics]::FromImage($bmp)
            $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
            $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
            $g.DrawImage($img, 0, 0, $size, $size)

            $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)

            Write-Host "Generated $($entry.Name) (${size}x${size}) -> $outPath"
        }
        finally {
            if ($g -ne $null) {
                $g.Dispose()
            }

            if ($bmp -ne $null) {
                $bmp.Dispose()
            }
        }
    }

    Write-Host "Done. $($sizes.Count) favicons generated in $OutputDir"
}
finally {
    if ($img -ne $null) {
        $img.Dispose()
    }
}