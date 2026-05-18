---
layout: page
title: Photo Gallery
description: Photos from Dover Run Club runs, races, and community events
---

<!-- Note: Per Phase 1 rules, this page is deliberately NOT linked in the main navigation header. It is accessed via the homepage Photos section. -->

<div class="gallery-intro">
    <p>Scenes from our Tuesday night runs, community events, and member accomplishments.</p>
</div>

<div class="gallery-grid">
    {% for photo in site.data.gallery %}
    <div class="gallery-card">
        <div class="gallery-image-wrapper">
            {% if photo.image_base %}
            {% assign ext = photo.image | split: '.' | last %}
            <img src="{{ photo.image | relative_url }}"
                 srcset="{{ photo.image_base | append: '-400.' | append: ext | relative_url }} 400w, {{ photo.image_base | append: '-800.' | append: ext | relative_url }} 800w, {{ photo.image_base | append: '-1200.' | append: ext | relative_url }} 1200w"
                 sizes="(max-width: 600px) 400px, (max-width: 1000px) 800px, 1200px"
                 alt="{{ photo.alt | default: photo.title }}" class="gallery-image" loading="lazy">
            {% else %}
            <img src="{{ photo.image | relative_url }}" alt="{{ photo.alt | default: photo.title }}" class="gallery-image" loading="lazy">
            {% endif %}
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
