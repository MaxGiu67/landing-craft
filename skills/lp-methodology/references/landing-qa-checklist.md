# QA Checklist per Landing Page Animate

Reference per `/lp-qa`. Criteri di qualita verificabili.

---

## Performance (Lighthouse)

| Metrica | Target | Critico se |
|---------|--------|------------|
| Performance Score | > 90 | < 70 |
| LCP (Largest Contentful Paint) | < 2.5s | > 4s |
| FID/INP (Interaction to Next Paint) | < 200ms | > 500ms |
| CLS (Cumulative Layout Shift) | < 0.1 | > 0.25 |
| TBT (Total Blocking Time) | < 200ms | > 600ms |
| Speed Index | < 3.4s | > 5.8s |

### Checklist Performance
- [ ] Hero image/video non blocca LCP (lazy o preload strategico)
- [ ] Font con `font-display: swap` o `optional`
- [ ] Immagini WebP/AVIF con dimensioni appropriate
- [ ] CSS critico inline, non-critico differito
- [ ] JS animazione non nel critical path (defer/async)
- [ ] `will-change` solo sugli elementi animati, rimosso dopo
- [ ] Animazioni usano solo `transform` e `opacity`
- [ ] Nessun layout shift da immagini senza dimensioni
- [ ] LazyMotion con domAnimation (non domMax)
- [ ] ScrollTrigger con `lazy: true` per batch rendering

---

## Accessibility (WCAG 2.2 AA)

| Criterio | Target | Tool |
|----------|--------|------|
| Accessibility Score | > 95 | Lighthouse |
| WCAG Level | AA | axe-core |
| Color Contrast | >= 4.5:1 (testo), >= 3:1 (large) | axe-core |

### Checklist Accessibility
- [ ] `prefers-reduced-motion: reduce` rispettato per OGNI animazione
- [ ] Heading hierarchy corretta (h1 → h2 → h3, no skip)
- [ ] Alt text per tutte le immagini (decorative: `alt=""`)
- [ ] Focus visible su tutti gli elementi interattivi
- [ ] Tab order logico (no `tabindex` > 0)
- [ ] Color contrast sufficiente su tutti i testi
- [ ] Animazioni non causano motion sickness (no parallax aggressivo)
- [ ] Video: `autoplay muted`, con controlli accessibili
- [ ] ARIA labels per icone e bottoni senza testo
- [ ] Skip-to-content link nascosto ma accessibile

### prefers-reduced-motion implementation
```jsx
// CSS
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}

// GSAP
const prefersReducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
if (prefersReducedMotion) {
  gsap.globalTimeline.timeScale(1000); // skip istantaneo
}

// Motion.dev
import { useReducedMotion } from "motion/react";
const shouldReduce = useReducedMotion();
```

---

## Responsive (3 viewport)

| Viewport | Dimensioni | Breakpoint Tailwind |
|----------|-----------|---------------------|
| Mobile | 375x812 | default (< sm) |
| Tablet | 768x1024 | md |
| Desktop | 1440x900 | lg/xl |

### Checklist Responsive
- [ ] Hero leggibile su mobile (font-size adattato)
- [ ] CTA raggiungibili con il pollice (min 44x44px touch target)
- [ ] Griglia features: 3 colonne desktop → 1 colonna mobile
- [ ] Immagini responsive (`srcset` o `<picture>`)
- [ ] Video background: immagine statica su mobile
- [ ] Nessun overflow orizzontale su nessun viewport
- [ ] Font size minimo 16px su mobile (previene zoom iOS)
- [ ] Spacing proporzionale (clamp() o viewport units)

---

## SEO

### Checklist SEO
- [ ] Meta title (50-60 chars) e description (150-160 chars)
- [ ] OG tags (og:title, og:description, og:image)
- [ ] Canonical URL
- [ ] Heading h1 unico e descrittivo
- [ ] Schema.org JSON-LD (Organization, Product, FAQ se applicabile)
- [ ] Sitemap.xml
- [ ] robots.txt
- [ ] Core Web Vitals entro soglie (vedi Performance)

---

## Animazione Quality

### Checklist Animazione
- [ ] Tutte le animazioni hanno durata ragionevole (0.3-1.5s)
- [ ] Nessuna animazione bloccante al caricamento pagina (LCP)
- [ ] ScrollTrigger: `start` e `end` calibrati (non trigger troppo presto/tardi)
- [ ] Stagger: delay coerente (0.05-0.15s per elemento)
- [ ] Ease coerente in tutta la pagina (non mescolare ease diversi senza motivo)
- [ ] Exit animation presenti dove servono (AnimatePresence)
- [ ] Nessun flash/flicker su slow connection (FOUC prevenuto)
- [ ] Animazioni non si sovrappongono in modo confuso
- [ ] Counter/number animation: `snap` per numeri interi
- [ ] Hover animation: feedback immediato (< 100ms response)

---

## Build & Deploy

### Checklist Pre-Deploy
- [ ] `pnpm build` passa senza errori
- [ ] `tsc --noEmit` passa senza errori TypeScript
- [ ] ESLint: zero errori (warning accettabili)
- [ ] Bundle size ragionevole (< 200KB JS iniziale)
- [ ] Asset ottimizzati (immagini compresse, font subset)
- [ ] Environment variables corrette per produzione
- [ ] HTTPS configurato
- [ ] Redirect www → non-www (o viceversa)
- [ ] 404 page presente
- [ ] Analytics/tracking configurato
