---
layout: page
title: Routes
description: Dover Run Club running routes around Dover, NH — common Tuesday routes plus member-contributed alternates, with shareable per-route links.
---

<p class="routes-page-intro">Every Tuesday we run one of these routes from The Brick. Tap "Copy link" on a route to share it, or right-click (or press and hold on mobile) its title to copy the link directly from your browser.</p>

<section class="route-section">
    <h2>Common Routes</h2>
    {% include route-card.html routes=site.data.routes %}
</section>

<section class="route-section route-section-secondary">
    <h2 class="route-section-heading-secondary">Member Routes</h2>
    <p class="routes-intro">Routes contributed by club members — same great Dover roads, new perspectives.</p>
    {% include route-card.html routes=site.data.member_routes %}
</section>

<script src="{{ '/assets/js/route-share.js' | relative_url }}" defer></script>
