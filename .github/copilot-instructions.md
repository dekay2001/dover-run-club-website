# GitHub Copilot Instructions for Dover Run Club Website

## Project Overview
The Dover Run Club (DPR) website is a Jekyll-based GitHub Pages site. It is currently in a **Phase 1 single-page state**, focusing on the essentials (What, When, Where, Vibe). Additional pages exist in the repository for future expansion but are intentionally hidden from the main navigation.

## Tech Stack
- **Framework:** Jekyll (hosted on GitHub Pages)
- **Templating:** Liquid
- **Content:** Markdown
- **Styling:** Custom CSS (no heavy frameworks like Bootstrap or Tailwind)

## Essential Commands
To run the site locally for development:
```bash
bundle exec jekyll serve --livereload
```

## File Structure
- `index.md`: The main homepage containing all visible content for Phase 1.
- `_includes/`: Reusable HTML components (e.g., `header.html`, `footer.html`).
- `_layouts/`: Base HTML templates (`default.html`, `page.html`).
- `assets/css/main.css`: The primary stylesheet containing all custom CSS and theme variables.
- `design/`: Contains planning documents, roadmaps, and design decisions (e.g., `website-roadmap.md`).

## Design & Content Guidelines
- **Tone:** Casual, welcoming, and inclusive of all paces. The unofficial motto is "We run and then we pub, in that order."
- **Variables:** Always use `{{ site.title }}` instead of hardcoding the club name in content files.
- **CSS:** Use the CSS variables defined in the `:root` selector within `assets/css/main.css` for colors, fonts, and spacing. Do not introduce new hardcoded colors unless adding them to the `:root` variables.
- **Hidden Pages:** Pages like `events.md`, `pub-runs.md`, `membership.md`, and `sponsors.md` exist in the repository as placeholders. They should remain unlinked in the main navigation until the club is ready to expand beyond the single-page format.

## Workflow
- **Roadmap Updates:** Whenever structural changes are made, new features are implemented, or the status of a page changes, update `design/website-roadmap.md` to reflect the current state of the site.
