---
name: lp-methodology
description: "Overview del plugin Landing Craft. Mostra skill disponibili, workflow, stack e references. Usa quando l'utente chiede aiuto sul plugin, vuole vedere le skill, o dice help landing, come funziona, lp help."
---

# lp-methodology — Overview Landing Craft

Plugin Claude Code per creare landing page animate professionali.

## Stack

- **React 19** + TypeScript + Vite 7 (o Next.js 16)
- **Tailwind CSS v4** (CSS-first config)
- **GSAP 3.12+** (ScrollTrigger, timeline, SplitText, parallax)
- **Motion.dev 12+** (entrance/exit, gesture, layout, spring)
- **shadcn/ui** (primitives UI)

## Skill disponibili (7)

| Skill | Cosa fa |
|-------|---------|
| `/lp-init` | Setup progetto: scaffold, CLAUDE.md, hook QA, animation config |
| `/lp-hero` | Hero section animata (minimal, bold, video-bg, split-screen) |
| `/lp-section` | Sezione scroll-triggered (features, testimonials, stats, pricing, CTA, footer) |
| `/lp-animate` | Aggiungi animazione a componente esistente |
| `/lp-qa` | QA: Lighthouse, A11y, responsive, animation check |
| `/lp-deploy` | Deploy su Vercel/Netlify |
| `/lp-status` | Dashboard stato landing |

## Workflow consigliato

```
/lp-init → /lp-hero → /lp-section (ripeti) → /lp-animate (opzionale) → /lp-qa → /lp-deploy
```

## References

- `references/gsap-patterns.md` — Pattern GSAP: tween, timeline, ScrollTrigger, SplitText, performance
- `references/motion-patterns.md` — Pattern Motion.dev: gesture, scroll, layout, spring, LazyMotion
- `references/landing-sections.md` — Template 10+ sezioni con layout e animazione
- `references/landing-qa-checklist.md` — Criteri QA: Lighthouse, WCAG, responsive, SEO
