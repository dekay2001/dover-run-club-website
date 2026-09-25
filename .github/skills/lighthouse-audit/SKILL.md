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

# Compare against a previous run
$prev = Get-ChildItem "$env:TEMP\drc-lighthouse\*.report.json" | Sort-Object LastWriteTime | Select-Object -Last 1
.\scripts\Invoke-Lighthouse.ps1 -CompareTo $prev.FullName

# Local build before pushing (serve first, see copilot-instructions.md)
.\scripts\Invoke-Lighthouse.ps1 -Url http://localhost:4000/

# Desktop preset
.\scripts\Invoke-Lighthouse.ps1 -FormFactor desktop
```
The script prints category scores, core metrics, failing audits with the worst offending elements (`-MaxItems`), and a list of what got fixed or newly broke compared with `-CompareTo`. Open the `.report.html` file for full detail.

## Interpreting Results
- **Performance numbers vary a lot between runs.** Lighthouse simulates mobile throttling. On 2026-09-25, two back-to-back runs scored 68 and 83, with LCP at 10.1 s vs 3.6 s and CLS at 0.139 vs 0.021. Run 3 times and use the median before you call something a regression or a fix.
- **Accessibility, Best Practices, and SEO results are deterministic.** A single run is enough to tell whether an audit passes.
- **Localhost vs live:** Only test local builds for accessibility and markup checks. Caching, compression, and CDN behavior differ on GitHub Pages, so measure performance on the live site.
- Audits with metric IDs (`largest-contentful-paint` and similar) show up in "Core metrics". "Failing audits" lists everything else with a score below 1.

## Tracked Findings
Each actionable finding is a GitHub issue labeled `lighthouse` plus `accessibility` or `performance`.

| Audit ID(s) | Finding | Source | Issue |
|---|---|---|---|
| `color-contrast` (cards, pages, routes, gallery) | `--color-primary` `#26726c` on `--color-surface` `#072240` = 2.82:1 | `assets/css/main.css` | #50 |
| `color-contrast` (footer, cookie button) | Gold on `#1d5650` = 3.75:1; teal on gold = 2.53:1 | `assets/css/main.css` | #51 |
| `total-byte-weight`, `image-delivery-insight`, `unsized-images`, LCP | Route PNGs (375–495 KB each) load eagerly, about 6.2 MB total | `_includes/route-card.html`, `assets/images/route-*.png` | #52 |
| `layout-shifts`, `cls-culprits-insight` | Hero `<img>` has no `width`/`height` (the shift is intermittent) | `index.md` | #53 |
| `heading-order` | `h1` jumps to `h3` in the feature cards | `index.md` | #54 |
| `label-content-name-mismatch` | "Email Us" and "Got it" `aria-label`s don't contain the visible text | `_includes/footer.html`, `_includes/cookie-notice.html` | #55 |

List open items with `gh issue list --label lighthouse`.

## Known / Accepted (Do Not File)
- **`cache-insight`**: GitHub Pages fixes cache TTL at 10 minutes, and the repo can't change it.
- **`unused-javascript`, `agent-accessibility-tree` (form role), `font-display-insight` (Courier Prime / Marcellus)**: All come from the third-party Mailchimp embed. The site's own `@font-face` rules already use `font-display: swap`.
- **`render-blocking-insight` for `main.css`**: The file is about 4 KB. Inlining it isn't worth the added complexity.
- **`max-potential-fid`, `interactive`**: These move with Mailchimp script timing. Only act if total blocking time goes above 200 ms.

## Baseline (mobile, live site)
| Date | Perf | A11y | Best Pr. | SEO | LCP | CLS | Notes |
|---|---|---|---|---|---|---|---|
| 2026-09-25 | 68 / 83 | 95 | 100 | 100 | 10.1 s / 3.6 s | 0.139 / 0.021 | Two runs; issues #50–#55 filed |

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
