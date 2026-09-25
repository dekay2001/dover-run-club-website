---
layout: page
title: Routes
description: Dover Run Club running routes around Dover, NH — common Tuesday routes plus member-contributed alternates, with shareable per-route links.
---

<p class="routes-page-intro">Every Tuesday we run one of these routes from The Brick. Tap "Copy link" on a route to share it, or long-press its title to copy the link without JavaScript.</p>

{%- assign this_week = site.data.this_week -%}
{%- assign this_week_route = nil -%}
{%- if this_week.route_id and this_week.route_id != "" -%}
    {%- assign this_week_route = site.data.routes | where: "id", this_week.route_id | first -%}
    {%- if this_week_route == nil -%}
        {%- assign this_week_route = site.data.member_routes | where: "id", this_week.route_id | first -%}
    {%- endif -%}
{%- endif -%}

{%- if this_week_route -%}
<section id="this-week" class="this-week-callout">
    <h2>This Tuesday</h2>
    <p class="this-week-date">{{ this_week.date | date: "%A, %b %-d" }}</p>
    <p class="this-week-route"><a href="#{{ this_week_route.id }}">{{ this_week_route.title }}</a></p>
    {%- if this_week.note and this_week.note != "" -%}
    <p class="this-week-note">{{ this_week.note }}</p>
    {%- endif -%}
    <div class="route-actions">
        <button type="button" class="button route-copy-link" data-route-url="{{ '/routes.html' | absolute_url }}#this-week">Copy this week's link</button>
        <span class="route-copy-feedback" aria-live="polite"></span>
    </div>
</section>
{%- endif -%}

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
