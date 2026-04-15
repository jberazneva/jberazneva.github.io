---
layout: default
title: Home
---

{% assign c = site.data.contact %}

<div class="home-header">
  <div class="home-intro">
    <h1 class="name">{{ c.name }}</h1>
    <p class="title">{{ c.title | markdownify | remove: '<p>' | remove: '</p>' | replace: '<a ', '<a target="_blank" rel="noopener" ' }}</p>
    <ul class="affiliations">
      {% for a in c.affiliations %}<li>{{ a | markdownify | remove: '<p>' | remove: '</p>' | replace: '<a ', '<a target="_blank" rel="noopener" ' }}</li>{% endfor %}
    </ul>
    <div class="home-bio">
      {% include_relative _includes/bio.md %}
    </div>
    <p class="home-contact">
      <a href="mailto:{{ c.email }}" target="_blank" rel="noopener">Email</a><span class="sep">·</span>
      <a href="{{ c.links.google_scholar }}" target="_blank" rel="noopener">Google Scholar</a><span class="sep">·</span>
      <a href="{{ c.links.cv }}" target="_blank" rel="noopener">CV</a>
    </p>
  </div>
  <div class="home-headshot">
    <img src="{{ '/assets/images/headshot.jpg' | relative_url }}" alt="{{ c.name }}">
  </div>
</div>

<h2 id="working-papers">Working Papers</h2>

<ul class="pub-list">
{% for p in site.data["working-papers"].working_papers %}
  <li>
    <span class="pub-title">{{ p.title }}</span><br>
    <span class="pub-authors">{{ p.authors }}</span>.
    <span class="pub-meta">{{ p.year }}{% if p.status %}. {{ p.status }}{% endif %}.</span>
  </li>
{% endfor %}
</ul>

<h2 id="publications">Published and Forthcoming Papers</h2>

<ul class="pub-list">
{% for p in site.data.publications %}
  <li>
    <span class="pub-title">{% if p.doi %}<a href="{{ p.doi }}" target="_blank" rel="noopener">{{ p.title }}</a>{% elsif p.url %}<a href="{{ p.url }}" target="_blank" rel="noopener">{{ p.title }}</a>{% else %}{{ p.title }}{% endif %}</span><br>
    <span class="pub-authors">{{ p.authors }}</span>.
    {% if p.type == "book_chapter" %}
      In <span class="pub-venue">{{ p.in }}</span>, ed. {{ p.editors }}. {{ p.publisher }}, {{ p.year }}.
    {% else %}
      <span class="pub-venue">{{ p.journal }}</span>{% if p.volume %} {{ p.volume }}{% endif %}{% if p.pages %}: {{ p.pages }}{% endif %}, {{ p.year }}.
    {% endif %}
    {% if p.media %}<br><span class="pub-media">Media: {% for m in p.media %}<a href="{{ m.url }}" target="_blank" rel="noopener">{{ m.title }}</a>{% unless forloop.last %}, {% endunless %}{% endfor %}</span>{% endif %}
  </li>
{% endfor %}
</ul>
