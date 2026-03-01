# Contributing to Dover Run Club Website

## Branch Strategy
- Use short-lived branches from the default branch.
- Keep one concern per branch/PR.
- Suggested names: `feat/<topic>`, `fix/<topic>`, `docs/<topic>`, `chore/<topic>`.
- Prefer squash merges for clean history.

## Scope Discipline
- Keep changes focused and minimal.
- Preserve GitHub Pages compatibility.
- Respect Phase 1 single-page behavior unless explicitly changed.
- Avoid unrelated refactors and avoid exposing hidden pages in main nav by default.

## Content and Style Rules
- Tone: casual, welcoming, inclusive of all paces.
- Prefer `{{ site.title }}` over hardcoded club name in new/updated content.
- Use existing layout/include patterns before introducing new structure.
- In CSS, use variables from `:root` in `assets/css/main.css`.

## Agent Workflow (Idea → Plan → Implement → Verify)
1. Idea: capture enhancement ideas and prioritize.
2. Plan: create a scoped, sequence-aware implementation plan.
3. Implement: execute minimal, focused changes.
4. Verify: run local checks and content spot-checks.

Canonical backlog for idea capture and TODOs: `design/website-roadmap.md`.

## Verification Commands
If missing, create local dev config:
```powershell
Set-Content -Path "_config_dev.yml" -Value 'baseurl: ""'
```

Build check:
```powershell
bundle exec jekyll build
```

Serve with local override:
```powershell
bundle exec jekyll serve --config _config.yml,_config_dev.yml
```

Smoke check:
```powershell
Invoke-WebRequest -Uri "http://localhost:4000/" | Select-Object StatusCode
```

## When to Update `design/website-roadmap.md`
Update roadmap when structure, navigation visibility, roadmap priorities, or feature status changes.
