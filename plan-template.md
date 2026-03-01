---
title: "<short implementation title>"
version: "<optional>"
date_created: "<YYYY-MM-DD>"
last_updated: "<YYYY-MM-DD>"
owner: "<owner or team>"
status: "draft"
---

> Note: `status` must be one of: `draft`, `in-review`, `approved`, `in-progress`, `done`.

# Implementation Plan: <feature>

## Goal
Describe the user-facing goal and what success looks like.

## Requirements and Constraints
- Functional requirements
- Non-functional requirements
- Compatibility constraints (Jekyll/GitHub Pages, existing URLs, content structure)

## Architecture and Design
Describe affected components/files and proposed design.

## SOLID Design Review
- Single Responsibility: responsibilities per file/module are clear.
- Open/Closed: extend existing patterns before introducing new ones.
- Liskov Substitution: preserve expected behavior in shared templates.
- Interface Segregation: avoid bloated include/page contracts.
- Dependency Inversion: prefer config/data-driven values over hardcoding.

## Tasks
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

## Validation
- Build/test checks
- Manual verification steps
- Regression checks

## TDD Strategy (if applicable)
- Red: failing tests to add first
- Green: minimal implementation changes
- Refactor: cleanup while preserving passing checks

## Risks and Mitigations
- Risk: ...
  - Mitigation: ...

## Open Questions
- Question 1
- Question 2

## Approval
- Requested by:
- Reviewed by:
- Decision: Approved / Changes requested / Rejected
