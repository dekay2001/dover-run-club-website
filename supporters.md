---
layout: page
title: Our Supporters
description: Thanks to the local businesses supporting Dover Run Club, and how your business can help
---

## Thank You to Our Supporters

{{ site.title }} is grateful to the local businesses who've helped keep the club running.

<ul>
{% for supporter in site.data.supporters %}
  <li>Thanks to <a href="{{ supporter.url }}" target="_blank" rel="noopener">{{ supporter.name }}</a>{% if supporter.contribution and supporter.contribution != blank %} for our {{ supporter.contribution | downcase }}{% endif %}.</li>
{% endfor %}
</ul>

---

## Work With Us

We run and then we pub, in that order. Every Tuesday at 6 PM, {{ site.title }} heads out from The Brick in Dover, NH — all paces welcome.

If your business or group wants to help us keep that going, we'd love to hear from you. Helpful kinds of support include:

- Gear for club runs
- Venue space for a run or event
- Co-hosting an event
- Race or event partnerships

<a href="mailto:{{ site.contact_email }}?subject=Supporting%20Dover%20Run%20Club">Email us about supporting the club</a>
