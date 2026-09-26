---
layout: default
title: Home
---

<div class="hero">
    <h1>Dover Run Club</h1>
    <p class="hero-tagline">Show up, say hi, and run.</p>
    <p>Tuesdays · 6 PM · The Brick · Dover, NH</p>
    <div class="hero-actions">
        <a href="#what-to-expect" class="button">First run? What to expect</a>
        <a href="{{ '/routes.html' | relative_url }}" class="button">Routes &rarr;</a>
    </div>
</div>

<script>
// Old shared links pointed at #common-routes on the homepage; send them to the new Routes page.
if (location.hash === '#common-routes') {
    location.replace('{{ "/routes.html" | relative_url }}');
}
</script>

<div class="hero-image">
    <img 
        srcset="{{ '/assets/images/run-club-group-photo-400.jpg' | relative_url }} 400w,
                {{ '/assets/images/run-club-group-photo-800.jpg' | relative_url }} 800w,
                {{ '/assets/images/run-club-group-photo-1200.jpg' | relative_url }} 1200w"
        sizes="(max-width: 900px) 100vw,
               900px"
        src="{{ '/assets/images/run-club-group-photo-1200.jpg' | relative_url }}" 
        width="1200" height="588" fetchpriority="high"
        alt="Dover Run Club group photo">
</div>

<hr class="section-divider">

<div class="page" id="what-to-expect">
    <h2>What to Expect</h2>
    <p>
        There's no fee, no sign-up sheet, and no pressure. Just come as you are.
    </p>
    <ul>
        <li><strong>All paces welcome:</strong> Fast, slow, somewhere in between. Everyone finds their pace group.</li>
        <li><strong>No experience needed:</strong> Whether it's your first run or your thousandth, you're welcome.</li>
        <li><strong>Year-round:</strong> Rain or shine, summer or winter.</li>
        <li><strong>Optional post-run hang:</strong> Some folks stick around at <strong><a href="https://thebricknh.com/" target="_blank" rel="noopener">The Brick</a></strong> afterward; plenty just come for the run.</li>
    </ul>
</div>

<div class="page">
    <h2>Community Photos</h2>
    {% assign recent_photos = site.data.gallery | sort: "date" | reverse %}
    <div class="gallery-grid">
        {% for photo in recent_photos limit:2 %}
        <div class="gallery-card">
            <div class="gallery-image-wrapper">
                {% if photo.image_base %}
                <img src="{{ photo.image | relative_url }}"
                     srcset="{{ photo.image_base | append: '-400.jpg' | relative_url }} 400w, {{ photo.image_base | append: '-800.jpg' | relative_url }} 800w, {{ photo.image_base | append: '-1200.jpg' | relative_url }} 1200w"
                     sizes="(max-width: 600px) 400px, (max-width: 1000px) 800px, 1200px"
                     alt="{{ photo.alt | default: photo.title }}" class="gallery-image" loading="lazy">
                {% else %}
                <img src="{{ photo.image | relative_url }}" alt="{{ photo.alt | default: photo.title }}" class="gallery-image" loading="lazy">
                {% endif %}
            </div>
            <div class="gallery-caption-wrapper">
                <h3 class="gallery-title">{{ photo.title }}</h3>
                <div class="gallery-meta">{{ photo.date | date: "%B %d, %Y" }}</div>
                <p class="gallery-caption">{{ photo.caption | truncatewords: 15 }}</p>
            </div>
        </div>
        {% endfor %}
    </div>
    
    <div class="gallery-cta-wrapper">
        <a href="{{ '/gallery.html' | relative_url }}" class="button">View Full Gallery &rarr;</a>
    </div>
</div>

<div class="page">
    <h2>Stay in Touch</h2>
    <p><strong>Safety note:</strong> Contact channels are not monitored for emergencies. If someone is in immediate danger, call 911.</p>
    <ul>
        <li><strong>Email:</strong> <a href="mailto:{{ site.contact_email }}">{{ site.contact_email }}</a></li>
        <li><strong>Facebook Group:</strong> <a href="https://www.facebook.com/groups/doverrunclub" target="_blank" rel="noopener">Join the {{ site.title }} group</a></li>
        <li><strong>Instagram:</strong> <a href="https://www.instagram.com/doverrunclubnh/" target="_blank" rel="noopener">Follow {{ site.title }} on Instagram</a></li>
        <li><strong>Strava Club:</strong> <a href="https://www.strava.com/clubs/1768701" target="_blank" rel="noopener">Join {{ site.title }} on Strava</a></li>
        {% if site.merch_url and site.merch_url != blank %}
        <li><strong>Merch:</strong> Rep the club — <a href="{{ site.merch_url }}" target="_blank" rel="noopener">shop {{ site.title }} gear</a></li>
        {% endif %}
        <li><strong>Response expectations:</strong> Messages are checked by volunteers; we aim to respond within 48 hours.</li>
    </ul>
</div>

<div class="page">
    <h2>Our Roots</h2>
    <p>
        Dover's running community goes back years, and many of us first connected through the Tuesday pub runs <strong><a href="https://six03endurance.com/" target="_blank" rel="noopener">SIX03 Endurance</a></strong> brought to the Seacoast.
        {{ site.title }} carries that spirit forward today.
    </p>
    <p>
        <a href="{{ '/our-story.html' | relative_url }}">Read Our Full Story →</a>
    </p>
</div>

