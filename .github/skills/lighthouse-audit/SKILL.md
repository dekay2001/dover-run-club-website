---
name: lighthouse-audit
description: "Run and interpret Lighthouse audits (performance, accessibility, best practices, SEO) for the Dover Run Club website, compare against a baseline, and track findings as GitHub issues. Use when: re-evaluating Lighthouse or UX scores after changes, checking accessibility or contrast, checking page speed, LCP, CLS, or page weight, verifying a Lighthouse issue fix."
---

# Lighthouse Audit

## When to Use
- After you change CSS, images, layouts, or includes, to confirm scores didn't drop
- When you close a `lighthouse`-labeled GitHub issue, to verify the fix
- For a periodic UX or accessibility health check on the live site

## Prerequisites
- Node.js (for `npx lighthouse`). The script downloads Lighthouse on first run.
- Chrome or Edge. The script finds either automatically, or you can set `$env:CHROME_PATH`.

## Run an Audit
Run from the repo root. Reports go to `$env:TEMP\drc-lighthouse\` by default, outside the repo:
```powershell
# Live site, mobile (the default and the one tracked below)
.\scripts\Invoke-Lighthouse.ps1

# Compare against the previous run of the same form factor and URL
$prev = Get-ChildItem "$env:TEMP\drc-lighthouse\lighthouse-mobile-*.report.json" |
    Where-Object { (Get-Content $_ -Raw | ConvertFrom-Json).requestedUrl -eq 'https://www.doverrunclub.com/' } |
    Sort-Object LastWriteTime | Select-Object -Last 1
.\scripts\Invoke-Lighthouse.ps1 -CompareTo $prev.FullName

# Local build before pushing (serve first, see copilot-instructions.md)
.\scripts\Invoke-Lighthouse.ps1 -Url http://localhost:4000/

# Desktop preset
.\scripts\Invoke-Lighthouse.ps1 -FormFactor desktop
```
The script prints category scores, core metrics, failing audits with the worst offending elements (`-MaxItems`), and a list of what got fixed or newly broke compared with `-CompareTo`. Open the `.report.html` file for full detail.

**Comparisons must be like for like.** The script refuses a `-CompareTo` report from a different form factor, and warns when the URL or Lighthouse version differs. Lighthouse is pinned with `-LighthouseVersion` (default `13.5.0`, the version the baseline used). If you bump it, do so on purpose and record a new baseline row.

## Interpreting Results
- **Performance numbers vary a lot between runs.** Lighthouse simulates mobile throttling. On 2026-09-25, three runs of the same unchanged site scored 68, 83, and 62, with LCP from 3.6 s to 11.3 s and CLS at 0.021 or 0.139. Run 3 times and use the median before you call something a regression or a fix.
- **Accessibility, Best Practices, and SEO results are deterministic.** A single run is enough to tell whether an audit passes.
- **Localhost vs live:** Only test local builds for accessibility and markup checks. Caching, compression, and CDN behavior differ on GitHub Pages, so measure performance on the live site. If you must compare performance before deploying, serve a build **without live-reload** (the live-reload script is render-blocking and skews scores):
  ```powershell
  bundle exec jekyll serve --config _config.yml,_config_dev.yml --port 4001 --destination "$env:TEMP\drc-site-perf" --no-watch
  ```
- Audits with metric IDs (`largest-contentful-paint` and similar) show up in "Core metrics". "Failing audits" lists everything else with a score below 1.
- **Simulated vs observed:** Performance is scored on *simulated* slow-4G timings. If a score drops but the page didn't get slower, compare `audits.metrics.details.items[0]`: `firstContentfulPaint` (simulated) vs `observedFirstContentfulPaint` (real). A gap between them usually means the simulation is charging for a script, not that the page got slower.
- **Isolate third-party cost** by blocking it for one diagnostic run (don't record it as a baseline):
  ```powershell
  npx --yes lighthouse@13.5.0 https://www.doverrunclub.com/ --output=json --output-path="$env:TEMP\drc-lighthouse\probe.json" --chrome-flags="--headless=new" --quiet --blocked-url-patterns="*chimpstatic.com*" --blocked-url-patterns="*mailchimp.com*"
  ```
- The script prints with `Write-Host`, so its output can't be captured into a variable. For scripted analysis, read the `.report.json` path it prints.

## Tracked Findings
Each actionable finding is a GitHub issue labeled `lighthouse` plus `accessibility` or `performance`.

| Audit ID(s) | Finding | Source | Issue | Status |
|---|---|---|---|---|
| `color-contrast` (cards, pages, routes, gallery) | `--color-primary` `#26726c` on `--color-surface` `#072240` = 2.82:1 | `assets/css/main.css` | #50 | Fixed (PR #59) |
| `color-contrast` (footer, cookie button) | Gold on `#1d5650` = 3.75:1; teal on gold = 2.53:1 | `assets/css/main.css` | #51 | Fixed (PR #59) |
| `total-byte-weight`, `image-delivery-insight`, `unsized-images`, LCP | Route PNGs (375–495 KB each) load eagerly, about 6.2 MB total | `_includes/route-card.html`, `assets/images/route-*.png` | #52 | Fixed (PR #60) |
| `layout-shifts`, `cls-culprits-insight` | Hero `<img>` has no `width`/`height` (the shift is intermittent) | `index.md` | #53 | Fixed (PR #60) |
| `heading-order` | `h1` jumps to `h3` in the feature cards | `index.md` | #54 | Fixed (PR #57) |
| `label-content-name-mismatch` | "Email Us" and "Got it" `aria-label`s don't contain the visible text | `_includes/footer.html`, `_includes/cookie-notice.html` | #55 | Fixed (PR #57) |
| `image-delivery-insight` (hero) | Hero photo served as JPG, ~106–129 KiB savings as WebP | `index.md`, `assets/images/run-club-group-photo-*.jpg` | #61 | Open |

List open items with `gh issue list --label lighthouse`.

## Known / Accepted (Do Not File)
- **`cache-insight`**: GitHub Pages fixes cache TTL at 10 minutes, and the repo can't change it.
- **`unused-javascript`, `agent-accessibility-tree` (form role), `font-display-insight` (Courier Prime / Marcellus)**: All come from the third-party Mailchimp embed. The site's own `@font-face` rules already use `font-display: swap`.
- **`render-blocking-insight` for `main.css`**: The file is about 4 KB. Inlining it isn't worth the added complexity.
- **`max-potential-fid`, `interactive`**: These move with Mailchimp script timing. Only act if total blocking time goes above 200 ms.
- **Mailchimp is now the main Performance cost.** After the image fixes, a run with Mailchimp blocked scored Performance **93** (simulated FCP 1.85 s, LCP 3.0 s), while normal live runs scored 63–71. Real first paint was about 1.4 s either way.
- **Mailchimp loads after the `load` event + idle** (`_layouts/default.html`, decided 2026-09-25). On a no-live-reload local build this took Performance to 84 with FCP/LCP equal to the Mailchimp-blocked run. The remaining gap (84 vs 88 blocked) is **Speed Index**: the signup popup covers the screen in the final frame, so Lighthouse counts it as late visual progress. Closing that gap means changing the popup itself (for example, a delay or trigger in the Mailchimp UI, or no popup), which is a product decision. Don't file it as a bug.

## Baseline (mobile, live site)
| Date | Perf | A11y | Best Pr. | SEO | LCP | CLS | Notes |
|---|---|---|---|---|---|---|---|
| 2026-09-25 | 68 / 83 / 62 (median 68) | 95 | 100 | 100 | 10.1 s / 3.6 s / 11.3 s | 0.139 / 0.021 / 0.139 | Three runs, Lighthouse 13.5.0; issues #50–#55 filed |
| 2026-09-25 (after PRs #57, #59, #60) | 71 / 63 / 63 (median 63) | 100 | 100 | 100 | 4.8 s / 5.8 s / 6.0 s | 0.021 × 3 | Page weight 6.2 MB → 597 KB; observed FCP ~1.4 s (unchanged), observed load 2.2 s → 0.6–0.8 s. Mailchimp blocked: Perf 93. #50–#55 closed |

## Workflow After a Fix
1. Implement the fix and run `bundle exec jekyll build`.
2. For accessibility fixes, audit localhost. After deploying, re-run against the live site with `-CompareTo`.
3. Confirm the target audit ID appears under **Fixed**, and that **New fails** is `none`.
4. Close the issue with the before/after numbers, for example `gh issue close 54 --comment "heading-order passes (Lighthouse 2026-10-01)"`.
5. Add a row to the **Baseline** table above. Update **Tracked Findings** if you filed a new issue.

## Filing New Findings
Only file actionable, site-owned findings. Check the Known / Accepted list first.
```powershell
gh issue create --title "Accessibility: <summary>" --label "bug,accessibility,lighthouse" --body-file <file.md>
```
Labels: `bug` for regressions or WCAG failures, `enhancement` for optimizations, `performance` or `accessibility` by area, `lighthouse` always, and `good first issue` for small markup-only fixes. Include the audit ID, the offending selector or URL, the source file, the proposed fix, and acceptance criteria.
