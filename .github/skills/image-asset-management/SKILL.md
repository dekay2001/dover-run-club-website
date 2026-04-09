---
name: image-asset-management
description: "Resize images, generate favicons, integrate SVG logos, and follow Jekyll image best practices for the Dover Run Club website. Use when: resizing photos, creating favicon sets, adding logos, optimizing images, managing image assets."
---

# Image Asset Management

## When to Use
- Resizing photos for responsive variants (400/800/1200px)
- Generating favicon sets from a source image
- Integrating SVG or raster logos into the site
- Adding new images to the Jekyll site

## Scripts

### Resize Images

Generate responsive image variants from a source image.

```powershell
.\scripts\Resize-Images.ps1 -Path "assets/images/photo.jpg" -Width 800
```

- Outputs `<basename>-resized.<ext>` next to the original
- Uses System.Drawing with HighQualityBicubic interpolation
- Rename outputs to follow the convention: `<name>-400.jpg`, `<name>-800.jpg`, `<name>-1200.jpg`

### Generate Favicons

Generate a complete favicon set from a high-res raster image (PNG/JPG).

```powershell
.\scripts\Generate-Favicons.ps1 -SourceImage "assets/images/logo-1080.png"
```

- **Prerequisite:** Export the SVG logo to a high-res PNG (≥512×512) first. System.Drawing cannot render SVG natively.
- Outputs to `assets/images/favicons/` by default (override with `-OutputDir`)
- Generates: `favicon-16.png`, `favicon-32.png`, `apple-touch-icon.png` (180×180), `android-chrome-192.png`, `android-chrome-512.png`

## SVG Logo Integration

The site uses an SVG-first favicon strategy:

```html
<!-- In _layouts/default.html <head> -->
<link rel="icon" type="image/svg+xml" href="...DRC-FinalLogo.svg">
<link rel="icon" type="image/png" sizes="32x32" href="...favicons/favicon-32.png">
<link rel="apple-touch-icon" sizes="180x180" href="...favicons/apple-touch-icon.png">
```

- Modern browsers (Chrome 80+, Firefox 41+, Edge 80+) use the SVG favicon
- Safari and legacy browsers fall back to the 32×32 PNG
- iOS uses the apple-touch-icon for home screen bookmarks

## Jekyll Image Best Practices

- **Use `relative_url` filter** for all image paths: `{{ '/assets/images/logo.svg' | relative_url }}`
- **Filename case matters** on GitHub Pages (Linux): `DRC-FinalLogo.svg` ≠ `drc-finallogo.svg`
- **Pre-generate responsive sizes**: 400px (mobile), 800px (tablet), 1200px (desktop)
- **Use `srcset`** for responsive images:
  ```html
  <img srcset="photo-400.jpg 400w, photo-800.jpg 800w, photo-1200.jpg 1200w"
       sizes="(max-width: 900px) 100vw, 900px"
       src="photo-1200.jpg" alt="...">
  ```
- **Favicons live in** `assets/images/favicons/`
- **SVG logos** can be used directly in `<img>` tags and as favicons — they scale perfectly

## Brand Logo Colors

The DRC logo (`DRC-FinalLogo.svg`) uses these colors:

| Color | Hex | Usage |
|-------|-----|-------|
| Light Sage | `#b6ddbc` | Background elements |
| Soft Green | `#a3d5aa` | Accent fills |
| Deep Teal | `#1d5650` | Primary brand |
| Teal | `#26726c` | Secondary brand |
| Navy | `#001d37` | Dark accents |
| Dark Teal | `#033033` | Deep accents |

These complement the site's CSS variables: `--color-primary: #1F4D3A` (Forest Green), `--color-secondary: #4A6FA5` (Slate Blue).