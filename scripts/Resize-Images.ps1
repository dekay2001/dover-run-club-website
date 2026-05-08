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
    $file = $_
    $img = $null
    $bmp = $null
    $g = $null
    try {
        $img = [System.Drawing.Image]::FromFile($file.FullName)
        $h = [math]::Round($img.Height * ($Width / $img.Width))
        $bmp = New-Object System.Drawing.Bitmap($Width, $h)
        $g = [System.Drawing.Graphics]::FromImage($bmp)
        $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g.DrawImage($img, 0, 0, $Width, $h)
        $newName = Join-Path $file.DirectoryName ("$($file.BaseName)-resized$($file.Extension)")
        $bmp.Save($newName, $img.RawFormat)
        Write-Host "Resized $($file.Name) to $Width x $h -> $newName"
    }
    catch {
        Write-Warning "Failed to resize $($file.Name): $($_.Exception.Message)"
    }
    finally {
        if ($g) { $g.Dispose() }
        if ($bmp) { $bmp.Dispose() }
        if ($img) { $img.Dispose() }
    }
}
