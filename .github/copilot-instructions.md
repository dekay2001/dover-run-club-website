# GitHub Copilot Instructions for Dover Run Club Website

Use these files as primary context for all non-trivial work:

- [Product goals and scope](../PRODUCT.md)
- [Architecture and boundaries](../ARCHITECTURE.md)
- [Contribution and workflow rules](../CONTRIBUTING.md)
- [Planning template](../plan-template.md)
- [Roadmap and canonical idea backlog](../design/website-roadmap.md)

## Project Overview
The Dover Run Club website is a Jekyll-based GitHub Pages site. It is currently in a **Phase 1 single-page state**, focusing on the essentials (What, When, Where, Vibe). Additional pages exist in the repository for future expansion but are intentionally hidden from the main navigation.

## Tech Stack
- **Framework:** Jekyll (hosted on GitHub Pages)
- **Templating:** Liquid
- **Content:** Markdown
- **Styling:** Custom CSS (no heavy frameworks like Bootstrap or Tailwind)

## Essential Commands

Local preview requires `_config_dev.yml` at the repo root (`.gitignore`d) with `baseurl: ""`. If it doesn't exist, create it (from the repo root):
```powershell
Set-Content -Path ".\_config_dev.yml" -Value 'baseurl: ""'
```

Then serve:
```powershell
bundle exec jekyll serve --config _config.yml,_config_dev.yml
```
Open **http://localhost:4000/**

For a build-only check (no server):
```powershell
bundle exec jekyll build
```

## File Structure
- `index.md`: The main homepage containing all visible content for Phase 1.
- `_includes/`: Reusable HTML components (e.g., `header.html`, `footer.html`).
- `_layouts/`: Base HTML templates (`default.html`, `page.html`).
- `assets/css/main.css`: The primary stylesheet containing all custom CSS and theme variables.
- `design/`: Contains planning documents, roadmaps, and design decisions (e.g., `website-roadmap.md`).

## Design & Content Guidelines
- **Tone:** Casual, welcoming, and inclusive of all paces. The unofficial motto is "We run and then we pub, in that order."
- **Variables:** Prefer using `{{ site.title }}` instead of hardcoding the club name in new or updated content files. Existing hardcoded instances may be refactored over time as the site evolves.
- **CSS:** Use the CSS variables defined in the `:root` selector within `assets/css/main.css` for colors, fonts, and spacing. Do not introduce new hardcoded colors unless adding them to the `:root` variables.
- **Hidden Pages:** Pages like `events.md`, `pub-runs.md`, `membership.md`, and `sponsors.md` exist in the repository as placeholders. They should remain unlinked in the main navigation until the club is ready to expand beyond the single-page format.

## Agents

- [drc-idea.agent.md](agents/drc-idea.agent.md) — brainstorms and prioritizes enhancement ideas, and outputs roadmap-ready TODO entries
- [drc-plan.agent.md](agents/drc-plan.agent.md) — creates sequence-aware implementation plans using `plan-template.md`
- [drc-implement.agent.md](agents/drc-implement.agent.md) — executes approved plans with clean code + SOLID focus and incremental validation
- [drc-verify.agent.md](agents/drc-verify.agent.md) — build, HTTP smoke tests, stale-ref checks, and content spot-checks for local validation

## Prompts

- [idea-capture.prompt.md](prompts/idea-capture.prompt.md) — structured idea capture and prioritization
- [plan-qna.prompt.md](prompts/plan-qna.prompt.md) — clarifying questions followed by full plan generation
- [implement-from-plan.prompt.md](prompts/implement-from-plan.prompt.md) — implementation of approved plan with stepwise validation

## Skills

| Skill | Purpose | File |
|-------|---------|------|
| image-asset-management | Image resizing, favicon generation, SVG integration, and Jekyll image best practices | [SKILL.md](skills/image-asset-management/SKILL.md) |

## Quick Start Flow

Use this sequence in Chat for non-trivial enhancements:

1. `/idea-capture` and describe the desired improvement.
2. Add approved idea(s) to `design/website-roadmap.md` using the Canonical Idea Backlog format.
3. `/plan-qna` referencing the selected roadmap item.
4. `/implement-from-plan` with the approved plan.
5. Hand off to `verify` for build/smoke/content checks.

## Workflow
- **Canonical Backlog:** `design/website-roadmap.md` is the source-of-truth for enhancement ideas and TODO status.
- **Flow:** Idea → Plan → Implement → Verify.
- **Roadmap Updates:** Whenever structural changes are made, new features are implemented, or page status changes, update `design/website-roadmap.md` in the same change.
