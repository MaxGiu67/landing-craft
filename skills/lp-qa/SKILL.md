---
name: lp-qa
description: "QA completa landing page: build, Lighthouse, accessibilita, visual check 3 viewport, reduced-motion, CLS. Usa quando l'utente vuole verificare la qualita, testare la landing, o dice lp qa, controlla, verifica, test landing, qualita, lighthouse."
---

# lp-qa — Quality Assurance Landing Page

Esegue una QA completa della landing page coprendo performance, accessibilita, responsive, animazioni e SEO.

## Workflow

### Step 1: Build check

```bash
pnpm build
```
DEVE passare senza errori. Se fallisce, correggi prima di continuare.

```bash
pnpm tsc --noEmit
```
DEVE passare senza errori TypeScript.

### Step 2: Performance (Lighthouse)

Se MCP Lighthouse disponibile, usalo. Altrimenti:
```bash
npx lighthouse http://localhost:5173 --output=json --output-path=./lighthouse-report.json --chrome-flags="--headless"
```

Verifica target (da `references/landing-qa-checklist.md`):
- Performance Score > 90
- LCP < 2.5s
- CLS < 0.1
- TBT < 200ms

### Step 3: Accessibilita

Se MCP A11y disponibile, usalo. Altrimenti analizza manualmente:
- Heading hierarchy (h1 → h2 → h3)
- Alt text su tutte le immagini
- Color contrast (4.5:1 testo, 3:1 large)
- Focus visible su interattivi
- ARIA labels su icone/bottoni senza testo

### Step 4: Responsive check

Se MCP Playwright disponibile, cattura screenshot a 3 viewport:
- Mobile: 375x812
- Tablet: 768x1024
- Desktop: 1440x900

Verifica:
- Nessun overflow orizzontale
- Testo leggibile su ogni viewport
- CTA raggiungibili (touch target 44x44px)
- Griglia adattiva (colonne ridotte su mobile)

### Step 5: Animation check

Verifica:
- `prefers-reduced-motion` rispettato in OGNI componente animato
- Animazioni usano solo `transform` e `opacity`
- Nessun layout shift da animazioni (CLS)
- GSAP usa `useGSAP` hook (non useEffect)
- Motion usa LazyMotion con domAnimation
- Timing coerente (stessi ease in tutta la pagina)

### Step 6: SEO check

Verifica:
- Meta title e description presenti
- OG tags (title, description, image)
- Heading h1 unico
- Schema.org JSON-LD (se applicabile)

### Step 7: Report

Genera report strutturato:

```markdown
# QA Report — [Nome Progetto]

## Risultati

| Area | Score | Status |
|------|-------|--------|
| Build | Pass/Fail | OK/FIX |
| Performance | XX/100 | OK/WARN/FIX |
| Accessibility | XX/100 | OK/WARN/FIX |
| Responsive | 3/3 viewport | OK/FIX |
| Animations | X/Y check | OK/FIX |
| SEO | X/Y check | OK/FIX |

## Azioni correttive
1. [problema] → [soluzione]
2. ...
```

## Output

Report in console + file `qa-report.md` se richiesto
