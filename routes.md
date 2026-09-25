---
layout: page
title: Routes
description: Dover Run Club running routes around Dover, NH — common Tuesday routes plus member-contributed alternates, with shareable per-route links.
---

<p class="routes-page-intro">Every Tuesday we run one of these routes from The Brick. Tap "Copy link" on a route to share it, or long-press its title to copy the link without JavaScript.</p>

<div class="page">
    <h2>Common Routes</h2>
    {% include route-card.html routes=site.data.routes %}
</div>

<div class="page route-section-secondary">
    <h3>Member Routes</h3>
    <p class="routes-intro">Routes contributed by club members — same great Dover roads, new perspectives.</p>
    {% include route-card.html routes=site.data.member_routes %}
</div>

<script src="{{ '/assets/js/route-share.js' | relative_url }}" defer></script>
