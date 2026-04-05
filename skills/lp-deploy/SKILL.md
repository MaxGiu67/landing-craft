---
name: lp-deploy
description: "Deploy landing page su Vercel o Netlify con preview URL. Usa quando l'utente vuole pubblicare, fare deploy, mettere online la landing, o dice lp deploy, deploy, pubblica, metti online, vercel, netlify."
---

# lp-deploy — Deploy Landing Page

Deploy della landing page su Vercel o Netlify con preview URL.

## Workflow

### Step 1: Pre-deploy check

1. Esegui `pnpm build` — DEVE passare
2. Verifica `.env.production` se necessario
3. Suggerisci `/lp-qa` se non ancora eseguito

### Step 2: Scegli piattaforma

Se `$ARGUMENTS` specifica la piattaforma, usala. Altrimenti chiedi:

| Piattaforma | Quando | Come |
|-------------|--------|------|
| **Vercel** | React/Next.js, preview deploy automatici | MCP Vercel o `npx vercel` |
| **Netlify** | Vite, form handling, split testing | MCP Netlify o `npx netlify deploy` |

### Step 3: Deploy

**Vercel (se MCP disponibile):**
Usa gli strumenti MCP Vercel per creare progetto e deployare.

**Vercel (CLI):**
```bash
npx vercel --prod    # produzione
npx vercel           # preview
```

**Netlify (se MCP disponibile):**
Usa gli strumenti MCP Netlify.

**Netlify (CLI):**
```bash
npx netlify deploy --prod --dir=dist    # produzione
npx netlify deploy --dir=dist           # preview (draft)
```

### Step 4: Verifica post-deploy

- Apri la URL di preview
- Verifica che le animazioni funzionino in produzione
- Verifica HTTPS attivo
- Verifica meta tags visibili (OG debug: opengraph.xyz)

## Output

URL di deploy (preview o produzione)
