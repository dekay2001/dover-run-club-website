---
layout: default
title: Home
---

<div class="hero">
    <h1>Dover Run Club</h1>
    <p class="hero-tagline">Tuesday nights. All paces welcome. Meet, run, and hang after if you'd like.</p>
    <p>Tuesday nights · 6 PM · The Brick · Dover, NH</p>
</div>

<div class="hero-image">
    <img 
        srcset="{{ '/assets/images/run-club-group-photo-400.jpg' | relative_url }} 400w,
                {{ '/assets/images/run-club-group-photo-800.jpg' | relative_url }} 800w,
                {{ '/assets/images/run-club-group-photo-1200.jpg' | relative_url }} 1200w"
        sizes="(max-width: 900px) 100vw,
               900px"
        src="{{ '/assets/images/run-club-group-photo-1200.jpg' | relative_url }}" 
        alt="Dover Run Club group photo">
</div>

<div class="cards">
    <div class="card">
        <h3>🏃 When & Where</h3>
        <p>Every Tuesday at 6 PM we meet at <strong><a href="https://thebricknh.com/" target="_blank" rel="noopener">The Brick</a></strong> in downtown Dover, NH. Show up, say hi, and run.</p>
    </div>
    
    <div class="card">
        <h3>🗺️ Variety of Routes</h3>
        <p>We mix it up each week with different routes around Dover. Favorites include the <strong><a href="https://www.doverraceseries.org/" target="_blank" rel="noopener">Dover Red's 5-miler</a></strong>, Mount Vernon, Washington, and parts of the community trail. Road routes with hills and flats.</p>
    </div>
    
    <div class="card">
        <h3>🤝 Optional Post-Run Hang</h3>
        <p>We start and finish at The Brick. Many runners stick around for food, drinks, and good company, but plenty come just for the run.</p>
    </div>
    
    <div class="card">
        <h3>👥 All Paces Welcome</h3>
        <p>Fast, slow, somewhere in between — doesn't matter. We have runners of all abilities and everyone finds their group.</p>
    </div>
</div>

<div class="page">
    <h2>About Us</h2>
    <p>
        {{ site.title }} has a long history of Tuesday night runs in Dover.
        What started as a regular Tuesday meetup has grown into a large, loyal group of runners
        who show up rain or shine, summer or winter.
    </p>
    <p>
        There's no membership fee, no sign-up sheet, and no pressure. Just show up at
        <strong><a href="https://thebricknh.com/" target="_blank" rel="noopener">The Brick</a></strong> on Tuesdays at 6 PM and you're part of the crew. We run a variety of
        routes around Dover and the surrounding area. Many runners hang out at The Brick afterward,
        but plenty head home after the run—and both are part of the crew.
    </p>
    
    <h3>What to Expect</h3>
    <ul>
        <li><strong>No experience needed:</strong> Whether it's your first run or your thousandth, you're welcome</li>
        <li><strong>Multiple pace groups:</strong> You'll find people running your speed</li>
        <li><strong>Optional post-run hang:</strong> Some runners stay at <strong><a href="https://thebricknh.com/" target="_blank" rel="noopener">The Brick</a></strong> afterward, and some just come for the run</li>
        <li><strong>Year-round:</strong> We run every Tuesday, all year long</li>
    </ul>

    <h3>Stay in Touch</h3>
    <p><strong>Safety note:</strong> Contact channels are not monitored for emergencies. If someone is in immediate danger, call 911.</p>
    <ul>
        <li><strong>Email:</strong> <a href="mailto:{{ site.contact_email }}">{{ site.contact_email }}</a></li>
        <li><strong>Facebook Group:</strong> <a href="https://www.facebook.com/groups/doverrunclub" target="_blank" rel="noopener">Join the {{ site.title }} group</a></li>
        <li><strong>Instagram:</strong> <a href="https://www.instagram.com/doverrunclubnh/" target="_blank" rel="noopener">Follow {{ site.title }} on Instagram</a></li>
        <li><strong>Strava Club:</strong> <a href="https://www.strava.com/clubs/1768701" target="_blank" rel="noopener">Join {{ site.title }} on Strava</a></li>
        <li><strong>Response expectations:</strong> Messages are checked by volunteers; we aim to respond within 48 hours.</li>
    </ul>

    <!-- TODO: Add a photo gallery section here -->
    <h3>Photos</h3>
    <img 
        class="responsive-img"
        srcset="{{ '/assets/images/DCR_20260310-400.jpg' | relative_url }} 400w,
                {{ '/assets/images/DCR_20260310-800.jpg' | relative_url }} 800w,
                {{ '/assets/images/DCR_20260310-1200.jpg' | relative_url }} 1200w"
        sizes="(max-width: 800px) 100vw, 800px"
        src="{{ '/assets/images/DCR_20260310-1200.jpg' | relative_url }}" 
        alt="{{ site.title }}'s first official run club photo">
</div>

<div class="page">
    <h2>Our Roots</h2>
    <p>
        Dover's running community has deep history, and many of us first found each other through the energy and camaraderie that <strong><a href="https://six03endurance.com/" target="_blank" rel="noopener">SIX03 Endurance</a></strong> brought to the Seacoast. Those weekly pub runs, group races, and shared miles helped shape the culture we still enjoy today.
    </p>
    <p>
        {{ site.title }} continues that spirit—welcoming runners of all paces, celebrating community, and keeping <strong><a href="https://thebricknh.com/" target="_blank" rel="noopener">The Brick</a></strong> as our home base. We're proud of where we came from, and excited for where we're going together.
    </p>
    <p>
        <a href="{{ '/our-story.html' | relative_url }}">Read Our Full Story →</a>
    </p>
</div>

