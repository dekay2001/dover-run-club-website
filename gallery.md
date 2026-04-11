---
layout: page
title: Photo Gallery
---

<!-- Note: Per Phase 1 rules, this page is deliberately NOT linked in the main navigation header. It is accessed via the homepage Photos section. -->

<div class="gallery-intro">
    <p>Scenes from our Tuesday night runs, community events, and member accomplishments. We run and then we pub, in that order.</p>
</div>

<div class="gallery-grid">
    {% for photo in site.data.gallery %}
    <div class="gallery-card">
        <div class="gallery-image-wrapper">
            <img src="{{ photo.image | relative_url }}" alt="{{ photo.alt | default: photo.title }}" class="gallery-image" loading="lazy">
        </div>
        <div class="gallery-caption-wrapper">
            <h3 class="gallery-title">{{ photo.title }}</h3>
            <div class="gallery-meta">{{ photo.date | date: "%B %d, %Y" }}</div>
            <p class="gallery-caption">{{ photo.caption }}</p>
        </div>
    </div>
    {% endfor %}
</div>

<div class="gallery-cta-wrapper">
    <a href="{{ '/' | relative_url }}" class="button">&larr; Back to Home</a>
</div>
