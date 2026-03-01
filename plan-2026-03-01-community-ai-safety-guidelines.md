
> Note: `status` must be one of: `draft`, `in-review`, `approved`, `in-progress`, `done`.

# Implementation Plan: Community AI Safety Guidelines

## Goal
Add a Phase-1-compatible content slice that provides practical, human-centered AI usage guidance for the running community while preserving the site’s welcoming tone and simple homepage-first scope.

## Requirements and Constraints
- Functional requirements
  - Draft clear community-safe AI guidance copy suitable for current site scope.
  - Keep guidance practical: transparency, privacy, verification, and healthy boundaries.
  - Route content into an existing or planned path without exposing unfinished pages in navigation.
- Non-functional requirements
  - Tone remains inclusive, casual, and non-judgmental.
  - Content remains short and easy to scan.
- Compatibility constraints (Jekyll/GitHub Pages, existing URLs, content structure)
  - Preserve Phase 1 single-page-first behavior.
  - Do not link placeholder pages in header navigation.
  - Maintain existing URL/content paths.

## Architecture and Design
Describe affected components/files and proposed design.
- Primary draft location: `design/website-roadmap.md` as a scoped roadmap item + copy sketch.
- Optional implementation target: `index.md` section or a future hidden page linked from homepage body only (not header nav), pending roadmap decision.
- Reuse existing layout and CSS token conventions.

## SOLID Design Review
- Single Responsibility: deliver one focused safety-guidance content slice.
- Open/Closed: extend current content model without redesigning IA.
- Liskov Substitution: any placement option preserves expected Phase 1 behavior.
- Interface Segregation: keep guidance content independent from event logistics content.
- Dependency Inversion: guidance principles rely on policy and tone, not tooling specifics.

## Tasks
- [x] Task 1
  - Add roadmap entry: objective, scope boundary, and acceptance criteria.
- [x] Task 2
  - Draft v1 guidance copy (5-7 bullets max) with welcoming tone.
- [x] Task 3
  - Choose placement option that preserves Phase 1 constraints.
- [x] Task 4
  - Implement minimal content change and update roadmap status.

## Validation
- Build/test checks
  - `bundle exec jekyll build`
- Manual verification steps
  - Verify homepage still communicates What/When/Where/Vibe clearly.
  - Verify main nav remains unchanged for hidden pages.
- Regression checks
  - Confirm no broken links and consistent styling.

## TDD Strategy (if applicable)
- Red: define acceptance checks for content presence, tone, and nav constraints.
- Green: implement minimal copy and placement to satisfy checks.
- Refactor: tighten wording and reduce cognitive load.

## Risks and Mitigations
- Risk: guidance content feels preachy or off-brand.
  - Mitigation: use practical, friendly language and keep it optional.
- Risk: scope creep into multi-page expansion.
  - Mitigation: enforce Phase 1 constraints and keep nav unchanged.

## Open Questions
- Question 1
  - Should v1 live directly on homepage or in a hidden support page linked from body copy?
  - Decision: Homepage placement selected for Phase 1 simplicity.
- Question 2
  - Do you want explicit examples for runners (training plans, route safety, event planning)?
  - Decision: Included concise runner-relevant examples in homepage bullet list.

## Approval
- Requested by: dekay2001
- Reviewed by: GitHub Copilot
- Decision: Approved and Implemented
