---
name: lp-init
description: "Inizializza progetto landing page animata: scaffold React+Tailwind+GSAP+Motion, genera CLAUDE.md, hook QA, struttura cartelle. Usa quando l'utente vuole creare una nuova landing page, setup progetto landing, o dice lp init, nuova landing, setup landing, crea landing page."
---

# lp-init — Setup Progetto Landing Page

Inizializza un progetto landing page completo con React, Tailwind CSS v4, GSAP, Motion.dev, e configurazione Claude Code ottimizzata.

## Workflow

### Step 1: Chiedi info progetto

Chiedi all'utente (o inferisci dal contesto):
- **Nome progetto** (es. "acme-landing")
- **Stack**: React+Vite (default) o Next.js
- **Sezioni previste**: hero, features, testimonials, pricing, CTA, footer
- **Stile**: minimal, bold, corporate, playful
- **Deploy target**: Vercel, Netlify, altro

### Step 2: Scaffold progetto

Se il progetto non esiste ancora, crea con:

**React + Vite (default):**
```bash
pnpm create vite@latest [nome] --template react-ts
cd [nome]
pnpm add gsap @gsap/react motion tailwindcss @tailwindcss/vite
pnpm add -D prettier eslint typescript
```

**Next.js:**
```bash
pnpm create next-app@latest [nome] --typescript --tailwind --app --src-dir
cd [nome]
pnpm add gsap @gsap/react motion
```

### Step 3: Struttura cartelle

Crea la struttura:
```
src/
├── components/
│   ├── sections/          # Hero.tsx, Features.tsx, Pricing.tsx, CTA.tsx, Footer.tsx
│   ├── ui/                # Button.tsx, Badge.tsx, Card.tsx (shadcn-style)
│   └── animations/        # ScrollReveal.tsx, StaggerContainer.tsx, CountUp.tsx
├── hooks/
│   ├── useScrollProgress.ts
│   ├── useReducedMotion.ts
│   └── useInView.ts
├── lib/
│   ├── utils.ts           # cn(), constants
│   └── animation-config.ts # durate, ease, stagger values centralizzati
└── styles/
    └── globals.css         # Tailwind v4 @import, font, base styles
```

### Step 4: File di configurazione animazione

Crea `src/lib/animation-config.ts`:
```typescript
export const ANIMATION = {
  duration: { fast: 0.3, normal: 0.6, slow: 0.8 },
  ease: { default: "power2.out", bounce: "back.out(1.7)", smooth: [0.25, 0.46, 0.45, 0.94] },
  stagger: { fast: 0.05, normal: 0.1, slow: 0.15 },
  scroll: { start: "top 80%", end: "top 20%" }
} as const;
```

### Step 5: Componenti base animazione

Crea wrapper riutilizzabili in `src/components/animations/`:
- `ScrollReveal.tsx` — wrapper Motion.dev con useInView
- `StaggerContainer.tsx` — container con stagger children
- `CountUp.tsx` — counter animato GSAP per numeri/stats

### Step 6: Genera CLAUDE.md

Crea `CLAUDE.md` nella root del progetto con:
- Stack e versioni
- Struttura progetto
- Comandi dev/build/lint
- Regole critiche (reduced-motion, performance, mobile-first)
- Istruzioni di compattazione

### Step 7: Genera hook QA

Crea `.claude/settings.json` con:
- PostToolUse: Prettier auto-format su ogni edit
- PostToolUse: ESLint auto-fix su ogni edit
- PreToolUse: blocca modifica config senza approvazione
- Stop: type-check TypeScript a fine risposta

### Step 8: Mostra prossimi passi

```
Progetto inizializzato! Prossimi passi:
1. /lp-hero [stile]     — genera la hero section
2. /lp-section [tipo]   — genera sezioni (features, pricing, etc.)
3. /lp-qa               — verifica qualita completa
```

## Output

- Progetto scaffold con dipendenze installate
- Struttura cartelle pronta
- CLAUDE.md ottimizzato per landing page
- Hook QA configurati
- Componenti animazione base
