# Dover Run Club Website Architecture

## Stack
- Platform: GitHub Pages (Jekyll build + hosting)
- Site generator: Jekyll with Liquid templating
- Content: Markdown pages with YAML front matter
- Styling: custom CSS in `assets/css/main.css`
- Dependency contract: `github-pages` gem in `Gemfile`
- Plugins: `jekyll-seo-tag`, `jekyll-sitemap`

## Key Files and Responsibilities
- `_config.yml`: canonical settings (title/description, URL/baseurl, plugins, excludes)
- `_config_dev.yml`: local override for development (`baseurl: ""`)
- `_layouts/default.html`: global shell, SEO tag, JSON-LD, includes, and main content slot
- `_layouts/page.html`: wrapper for non-home content pages
- `_includes/header.html`: main navigation (Home, Routes, Our Story, Gallery, Supporters) with `aria-current` on the active page
- `_includes/footer.html`: footer and social link
- `index.md`: newcomer-first homepage and primary user journey
- `routes.md`: Routes page, data-driven from `_data/routes.yml` and `_data/member_routes.yml` via `_includes/route-card.html`, linked from nav
- `our-story.md`: supporting narrative page, linked from nav and homepage "Our Roots" teaser
- `gallery.md`: Photo gallery, data-driven from `_data/gallery.yml`, linked from nav and homepage preview
- `supporters.md`: Supporters page, data-driven from `_data/supporters.yml`, linked from nav and footer
- `events.md`, `pub-runs.md`, `membership.md`: placeholder/future pages, intentionally hidden from nav
- `assets/css/main.css`: design tokens, layout, and responsive styling
- `design/website-roadmap.md`: roadmap and backlog source-of-truth

## Build and Runtime Flow
1. Author content/layout/style changes.
2. Local build or serve merges `_config.yml` plus `_config_dev.yml` for local URL behavior.
3. Jekyll renders Markdown + Liquid into `_site` static files.
4. GitHub Pages builds/deploys static output from repository branch.

## Boundaries and Constraints
- Preserve GitHub Pages compatibility.
- Keep the main nav focused on Home, Routes, Our Story, Gallery, and Supporters unless explicitly changed.
- Do not expose placeholder pages (Events, Pub Runs, Membership) in nav without a roadmap decision.
- Use Liquid URL helpers (`relative_url`, `absolute_url`) for path correctness.
- Prefer `site.title`/config-backed values over duplicated literals.
- Use existing CSS variables and avoid ad hoc visual token additions.

## Change Impact Checklist
- Did config changes preserve local and production URL behavior?
- Did nav/header changes keep intended page visibility?
- Did homepage still communicate What/When/Where/Vibe clearly?
- Did style changes reuse existing CSS variables/tokens?
- Did edited links/assets resolve under configured `baseurl`?
- Was `design/website-roadmap.md` updated for structure/status changes?
- Did local build/serve checks pass for touched areas?
