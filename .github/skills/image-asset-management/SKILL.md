---
name: image-asset-management
description: "Resize images, generate favicons, integrate SVG logos, and follow Jekyll image best practices for the Dover Run Club website. Use when: resizing photos, creating favicon sets, adding logos, optimizing images, managing image assets."
---

# Image Asset Management

## When to Use
- Adding new photos to the community gallery
- Resizing photos for responsive variants (400/800/1200px)
- Generating favicon sets or integrating SVG/raster logos
- General Jekyll image best practices

## Gallery Content Workflow

### 1. Optimize Photos
Before adding to the gallery, images must be optimized for fast loading:
```powershell
.\scripts\Resize-Images.ps1 -Path "assets/images/photo.jpg" -Width 1200
.\scripts\Resize-Images.ps1 -Path "assets/images/photo.jpg" -Width 800
.\scripts\Resize-Images.ps1 -Path "assets/images/photo.jpg" -Width 400
```
- Rename outputs to: `photo-1200.jpg`, `photo-800.jpg`, `photo-400.jpg`.

### 2. Update Gallery Data
Prepend new entries to `_data/gallery.yml`:
```yaml
- image: /assets/images/photo-1200.jpg
  image_base: /assets/images/photo
  title: "Race Title"
  date: "YYYY-MM-DD"
  caption: "Engagement text."
  alt: "Accessibility description."
```
- `image_base` must be the path WITHOUT the `-size.jpg` suffix.

### 3. Local Preview (Multi-root Fix)
Run from the repo root, or set the location to your local clone path first:
```powershell
Set-Location "<repo-root>"
bundle exec jekyll serve --config _config.yml,_config_dev.yml
```

## Logos & Favicons

### Generate Favicons
> **Prerequisite:** The script uses `System.Drawing` and requires a **raster input (PNG or JPG)**. Passing an `.svg` file will cause a runtime error — convert the SVG to a high-resolution PNG first (e.g., `logo-1080.png`).

```powershell
.\scripts\Generate-Favicons.ps1 -SourceImage "assets/images/logo-1080.png"
```
- Generates: `favicon-16/32.png`, `apple-touch-icon.png`, etc. in `assets/images/favicons/`.

### SVG Logo Integration
The site uses an SVG-first strategy:
```html
<link rel="icon" type="image/svg+xml" href="...DRC-FinalLogo.svg">
```

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