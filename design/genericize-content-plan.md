# Plan: Genericize Dover Run Club Website Content

**Date:** February 7, 2026
**Goal:** Remove all references to "SIX03", specific pricing, business names, and real-world locations. Replace with obvious placeholder text so the site serves as a clean scaffolding template while styling is worked out.

---

## Steps

### 1. Update `_config.yml` (site-wide config)
- Change `title` from `SIX03 Run Club` → `Run Club`
- Change `email` from `info@six03runclub.com` → `yourclub@example.com`
- Update `description` to a generic running club description

### 2. Genericize `index.md`
- Replace all "SIX03" mentions with `{{ site.title }}`
- Replace "Dover" city reference with `[Your City]`

### 3. Strip pricing and business names from `membership.md`
- Replace `$40/$60/$25` tier pricing with `$XX/year`
- Remove Venmo/PayPal references
- Swap "SIX03" with `{{ site.title }}`
- Replace Facebook/Strava references with generic placeholders

### 4. Gut sponsor content in `sponsors.md`
- Remove all 13+ fictional business names, addresses, phone numbers, URLs
- Remove sponsorship tier pricing (`$2,500/$1,000/$500`)
- Replace with TODO placeholder sections

### 5. Clean up `events.md`
- Remove specific locations (`Dover High School Track`, `Dover Town Square`, etc.)
- Remove the `$5,000` charity amount
- Replace with `[Location TBD]` and TODO placeholders

### 6. Clean up `pub-runs.md`
- Remove all pub names and their discount details
- Replace with TODO placeholder sections

### 7. Update `README.md`
- Replace `SIX03 Run Club` with generic club name
- Remove `six03runclub.com` domain references
- Keep `dekay2001` GitHub references (actual repo owner)

### 8. Update `GITHUB_PAGES_SETUP.md`
- Replace `SIX03 Run Club` with generic references
- Remove `six03runclub.com` domain references

### 9. Clean up `CNAME`
- Keep the domain commented out / blank

---

## Design Decisions
- **Use Liquid variables** (`{{ site.title }}`) in content pages where possible so updating `_config.yml` propagates the club name everywhere
- **Keep "Dover" in the repo name** for now — it's just a repo slug
- **CNAME** stays commented out until a real domain is configured
- **Layouts and includes are already clean** — they use `{{ site.title }}` and `{{ site.description }}` dynamically
