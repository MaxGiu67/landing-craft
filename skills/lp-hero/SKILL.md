---
name: lp-hero
description: "Genera hero section animata per landing page. Supporta 4 varianti: minimal, bold, video-bg, split-screen. Usa quando l'utente vuole creare la hero, la sezione principale, o dice lp hero, crea hero, hero section, sezione principale."
---

# lp-hero — Generatore Hero Section

Genera una hero section animata completa con React, Tailwind CSS e GSAP/Motion.

## Workflow

### Step 1: Scegli variante

Se `$ARGUMENTS` specifica uno stile, usalo. Altrimenti chiedi:

| Variante | Descrizione | Quando usarla |
|----------|-------------|---------------|
| **minimal** | Testo centrato, fade-up sequenziale, social proof | SaaS, tool, app |
| **bold** | Heading enorme (8-12vw), SplitText char-by-char | Brand, statement |
| **video-bg** | Video background con overlay, testo sovrapposto | Prodotto fisico, lifestyle |
| **split-screen** | Testo a sinistra, immagine/demo a destra | App con screenshot, dashboard |

### Step 2: Leggi contesto

- Leggi `CLAUDE.md` per stack e convenzioni
- Leggi `src/lib/animation-config.ts` per timing coerente
- Consulta `references/landing-sections.md` per il template della variante
- Consulta `references/gsap-patterns.md` e `references/motion-patterns.md`

### Step 3: Genera componente

Crea `src/components/sections/Hero.tsx` con:

1. **Layout statico** (React + Tailwind, mobile-first)
   - Heading h1 semantico
   - Sottotitolo p
   - CTA primario + secondario
   - Social proof o elemento visivo
   - Responsive: stack su mobile, layout su desktop

2. **Animazione** (scelta in base alla variante)
   - **minimal**: Motion.dev fade-up sequenziale con stagger
   - **bold**: GSAP SplitText per heading + Motion per CTA
   - **video-bg**: Video lazy load + Motion fade per overlay content
   - **split-screen**: GSAP timeline (testo da sinistra, immagine da destra)

3. **Performance**
   - Hero image: preload o eager (e LCP)
   - Font heading: preload
   - No blocking resources
   - `will-change` solo durante animazione

4. **Accessibilita**
   - `prefers-reduced-motion` rispettato
   - Heading h1 unico nella pagina
   - CTA con focus visible
   - Alt text per immagini

### Step 4: Verifica

- Il componente compila senza errori TypeScript
- Responsive su 3 viewport (375, 768, 1440)
- Animazione fluida (transform/opacity only)
- reduced-motion disabilita le animazioni

## Output

File: `src/components/sections/Hero.tsx`
Stile: componente autonomo, importabile in App/page
