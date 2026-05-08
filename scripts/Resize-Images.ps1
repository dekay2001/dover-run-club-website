param(
    [Parameter(Mandatory = $true)]
    [ValidateScript({ Test-Path $_ })]
    [string]$Path,

    [ValidateRange(1, 10000)]
    [int]$Width = 600
)

Add-Type -AssemblyName System.Drawing
$imageExtensions = '.bmp', '.gif', '.jpeg', '.jpg', '.png', '.tif', '.tiff'

Get-ChildItem -Path $Path -File | Where-Object { $imageExtensions -contains $_.Extension.ToLowerInvariant() } | ForEach-Object {
    $img = $null
    $bmp = $null
    $g = $null
    try {
        $img = [System.Drawing.Image]::FromFile($_.FullName)
        $h = [math]::Round($img.Height * ($Width / $img.Width))
        $bmp = New-Object System.Drawing.Bitmap($Width, $h)
        $g = [System.Drawing.Graphics]::FromImage($bmp)
        $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g.DrawImage($img, 0, 0, $Width, $h)
        $newName = Join-Path $_.DirectoryName ("$($_.BaseName)-resized$($_.Extension)")
        $bmp.Save($newName, $img.RawFormat)
        Write-Host "Resized $($_.Name) to $Width x $h -> $newName"
    }
    catch {
        Write-Warning "Failed to resize $($_.Name): $_"
    }
    finally {
        if ($g) { $g.Dispose() }
        if ($bmp) { $bmp.Dispose() }
        if ($img) { $img.Dispose() }
    }
}
