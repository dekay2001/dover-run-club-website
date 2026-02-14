# Dover Run Club — Website Roadmap

_Created: February 14, 2026_

---

## Current State (Phase 1)

The site is a **single-page website** focused on the essentials:

- **What:** Dover Run Club — a casual, social running group
- **When:** Every Tuesday at 6 PM
- **Where:** The Brick, Dover, NH
- **Vibe:** All paces welcome, post-run hangs at the pub

### What's Live
- Homepage with club info, schedule, and About section
- Custom CSS with responsive design
- Hosted on GitHub Pages

### What's Hidden (pages exist but are not linked)
- `events.md` — Generic event/race calendar (placeholder content)
- `pub-runs.md` — Pub run details page (placeholder content)
- `membership.md` — Membership tiers & sign-up (placeholder content)
- `sponsors.md` — Sponsor recognition page (placeholder content)

These pages are kept in the repo for future development but are **not in the navigation** and not linked from anywhere on the site.

---

## Decisions Made

| Decision | Choice | Reasoning |
|----------|--------|-----------|
| Club name | Dover Run Club | Clear, local identity — not tied to any business name |
| Site structure | Single page (home only) | Keep it simple; don't expose unfinished pages |
| Tone | Casual & fun | Matches the social pub-run culture of the group |
| Six03 Endurance | Not prominently featured | Club has its own identity; affiliation may be added later |
| Membership/fees | Not applicable for now | No membership structure currently needed |

---

## Future Ideas

These are things we may want to add down the road. Nothing here is committed — just ideas to revisit when the time is right.

### Near-Term (when ready)

#### 📸 Photos
- Add a photo gallery or photo section to the homepage
- Could be a grid of images from Tuesday runs
- Consider hosting images in `/assets/images/` or linking from an external service

#### 🔗 Additional Social Media Links
- Strava link is already implemented in the footer
- Future: Add links to Facebook and/or Instagram pages if/when those are created
- Could use simple icon links (no heavy icon library needed)

### Medium-Term (if there's demand)

#### 🗺️ Routes Page
- Showcase the variety of routes the club runs on Tuesdays
- Could include maps, distances, descriptions
- Possible integration with Strava or MapMyRun links

#### 🏪 Six03 Endurance Affiliation
- If the relationship is formalized, add a "Affiliated with Six03 Endurance" mention
- Could be a logo in the footer or a small section on the homepage
- Link to their website

#### 📅 Events Page
- Activate the Events page when there are real events to list
- Group races, seasonal runs, special events
- Currently has placeholder content in `events.md`

### Longer-Term (if the club grows)

#### 🍺 Pub Runs Page
- If the club expands beyond Tuesdays or beyond The Brick
- Multiple locations, rotating schedule, partner pub info
- Currently has placeholder content in `pub-runs.md`

#### 🤝 Membership Page
- Only if the club ever formalizes membership (dues, perks, etc.)
- Currently has placeholder content in `membership.md`

#### 💼 Sponsors Page
- If local businesses want to sponsor or be recognized
- Tiered sponsorship structure already templated in `sponsors.md`

#### 🌐 Custom Domain
- Register and configure a custom domain (e.g., `doverrunclub.com`)
- CNAME file is already in the repo (currently commented out)
- DNS setup instructions in `GITHUB_PAGES_SETUP.md`

---

## Technical Notes

- **Framework:** Jekyll, hosted on GitHub Pages
- **Theme:** Custom CSS (Minima declared in config but fully overridden)
- **Layouts:** `default.html` (base), `page.html` (content pages)
- **Hidden pages** are still accessible via direct URL (e.g., `/events.html`) but aren't discoverable through navigation. If this is a concern, they can be added to the `exclude` list in `_config.yml`.
