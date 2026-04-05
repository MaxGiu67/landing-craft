---
name: lp-section
description: "Genera sezione landing page con animazioni scroll-triggered. Tipi: features, testimonials, stats, pricing, comparison, cta, footer. Usa quando l'utente vuole aggiungere una sezione, o dice lp section, aggiungi sezione, crea features, pricing, testimonials."
---

# lp-section — Generatore Sezioni Landing Page

Genera una sezione landing page completa con animazioni scroll-triggered.

## Workflow

### Step 1: Scegli tipo sezione

Se `$ARGUMENTS` specifica il tipo, usalo. Altrimenti chiedi:

| Tipo | Varianti | Animazione principale |
|------|----------|----------------------|
| **features** | grid-cards, showcase-alternating, icon-list | Stagger reveal, parallax immagini |
| **testimonials** | carousel, grid, single-quote | AnimatePresence, stagger |
| **stats** | counter-row, counter-cards | GSAP counter scroll-triggered |
| **pricing** | 3-column, comparison-table, toggle-annual | Stagger cards, number morph |
| **comparison** | vs-table, feature-matrix | Stagger rows |
| **cta** | gradient-bg, split, minimal | Fade-up, CTA pulse/glow |
| **footer** | 4-column, minimal, mega-footer | Fade-in on scroll |

### Step 2: Leggi contesto

- Leggi `CLAUDE.md` per stack e convenzioni
- Leggi `src/lib/animation-config.ts` per timing coerente
- Leggi sezioni esistenti in `src/components/sections/` per coerenza stile
- Consulta `references/landing-sections.md` per template
- Consulta `references/gsap-patterns.md` e `references/motion-patterns.md`

### Step 3: Genera componente

Crea `src/components/sections/[Nome].tsx` con:

1. **Layout statico** (React + Tailwind, mobile-first)
2. **Animazione scroll-triggered** (Motion useInView o GSAP ScrollTrigger)
3. **Responsive** (griglia adattiva, font scaling)
4. **Accessibilita** (heading hierarchy, reduced-motion, ARIA)
5. **Performance** (lazy load immagini, transform/opacity only)

### Step 4: Integra nella pagina

- Aggiungi import e componente nella pagina principale
- Verifica ordine sezioni e spacing coerente
- Verifica che le animazioni non si sovrappongano

## Output

File: `src/components/sections/[Nome].tsx`
Aggiornato: pagina principale con import e rendering
