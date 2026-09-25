# Dover Run Club Website Product Brief

## Purpose
Provide a simple, welcoming web presence for Dover Run Club that answers the essentials quickly: what the club is, when it meets, where to show up, and what the vibe is.

## Product Goals
- Make first-time visitors confident enough to join a Tuesday run.
- Keep maintenance low with a lightweight, Markdown-first Jekyll approach.
- Preserve GitHub Pages compatibility and lightweight Jekyll delivery.
- Create a clear foundation for future expansion without exposing unfinished content.

## Target Users
- **Newcomers** — local runners, drop-ins, and friends/family checking the club out. Need What/When/Where/Vibe and first-run reassurance.
- **Weekly runners** — regulars looking up tonight's route on their phone.
- **Run admins** — volunteers who post the weekly route to the Facebook group and Strava. Need a quick, shareable link to any route.
- **Supporters and partners** — local businesses that have donated (The Brick, Middleton Chiropractic, and others), future sponsors, civic groups, race organizers, and donors if the club becomes a nonprofit. Need recognition, legitimacy, and a clear way to get in touch.

## Current Scope (Phase 2)
- Multi-page site with a newcomer-first homepage and a main navigation: Home, Routes, Our Story, Gallery, Supporters.
- Homepage communicates, each fact stated once:
  - What: Dover Run Club (casual, social group)
  - When: Tuesdays at 6:00 PM
  - Where: The Brick, Dover, NH
  - Vibe: All paces welcome; social post-run hang mentioned briefly, once
- Dedicated Routes page (common routes primary, member routes secondary) with shareable per-route links.
- Supporters page recognizing local business support, linked from nav and footer.
- Events, Pub Runs, and Membership pages remain in-repo but unlinked (`published: false`) until there's real content.

## Non-goals
- No activation of events, pub runs, or membership pages until there is real content.
- No formal membership system, dues workflow, or account features.
- No heavy framework adoption or redesign away from current custom CSS + Jekyll setup.
- No publishing placeholder content as primary user paths.

## Tone
Casual, welcoming, and inclusive. Clear language, low friction, and a running-first, community-first voice. The post-run hang at The Brick is optional: mention it briefly, never lead with it.

## Success Criteria
- Visitors can identify What/When/Where/Vibe within seconds on first load.
- Main navigation stays focused on the active phase's pages; unfinished pages stay hidden.
- Run admins can grab a link to any route in one tap.
- Content updates remain simple for maintainers (Markdown + lightweight templates).
- Site builds and deploys cleanly via GitHub Pages-compatible configuration.

## Agent Guardrails
- Keep changes focused and minimal; avoid unrelated refactors.
- Preserve GitHub Pages/Jekyll compatibility.
- Use existing design tokens/variables and current styling approach.
- Keep hidden future pages unlinked from main navigation until explicitly promoted.
- When structure/scope changes, update roadmap documentation in lockstep.

## Roadmap Linkage
Phase progression and activation criteria for future pages are tracked in [design/website-roadmap.md](design/website-roadmap.md). This PRODUCT.md defines Phase 2 intent; roadmap entries define when and how scope expands.
