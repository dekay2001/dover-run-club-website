param([string]$Path, [int]$Width = 600)
Add-Type -AssemblyName System.Drawing
Get-ChildItem -Path $Path | ForEach-Object {
  $img = [System.Drawing.Image]::FromFile($_.FullName)
  $h = [math]::Round($img.Height * ($Width / $img.Width))
  $bmp = New-Object System.Drawing.Bitmap($Width, $h)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.DrawImage($img, 0, 0, $Width, $h)
  $newName = $_.DirectoryName + "\" + $_.BaseName + "-resized" + $_.Extension
  $bmp.Save($newName, $img.RawFormat)
  $g.Dispose()
  $bmp.Dispose()
  $img.Dispose()
  Write-Host "Resized $($_.Name) to $Width x $h -> $newName"
}
