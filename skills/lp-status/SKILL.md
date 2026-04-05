---
name: lp-status
description: "Dashboard stato landing page: sezioni completate, score Lighthouse, checklist. Usa quando l'utente vuole vedere lo stato, il progresso, o dice lp status, stato, a che punto siamo, progresso landing."
---

# lp-status — Dashboard Stato Landing Page

Mostra lo stato corrente del progetto landing page.

## Workflow

### Step 1: Scansiona progetto

Leggi la directory `src/components/sections/` e identifica le sezioni create.

### Step 2: Genera dashboard

```markdown
# Landing Page Status

## Sezioni
| Sezione | File | Animazione | Responsive | a11y |
|---------|------|------------|------------|------|
| Hero | Hero.tsx | GSAP timeline | OK | OK |
| Features | Features.tsx | Motion stagger | OK | - |
| Pricing | - | - | - | - |
| CTA | - | - | - | - |
| Footer | - | - | - | - |

## Progresso
[████████░░░░░░░░] 40% — 2/5 sezioni

## Ultimo QA
Performance: --/100 | Accessibility: --/100

## Prossimi passi
→ /lp-section pricing
→ /lp-section cta
→ /lp-qa (dopo tutte le sezioni)
```

### Step 3: Suggerimenti

Basandosi sullo stato, suggerisci:
- Sezioni mancanti da creare
- Sezioni senza animazione da animare (`/lp-animate`)
- QA da eseguire se tutte le sezioni sono pronte

## Output

Dashboard in console
