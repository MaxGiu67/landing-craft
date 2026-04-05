# Landing Craft — Landing Page Animate per Claude Code

> **Versione: 1.0.0** — 7 skill, 1 agente AI, GSAP + Motion.dev + Tailwind CSS

Plugin Claude Code per creare landing page animate professionali, sezione per sezione, con QA automatica e deploy integrato.

## Il workflow

```
/lp-init
  │  Setup progetto: React + Tailwind + GSAP + Motion
  ▼
/lp-hero [minimal|bold|video-bg|split-screen]
  │  Hero section animata con 4 varianti
  ▼
/lp-section [features|testimonials|stats|pricing|cta|footer]
  │  Sezioni scroll-triggered, una alla volta
  ▼
/lp-animate <file> [entrance|scroll|hover|stagger|parallax]
  │  Aggiungi animazione a componenti esistenti
  ▼
/lp-qa
  │  Lighthouse + A11y + Responsive + Animation check
  ▼
/lp-deploy [vercel|netlify]
  │  Deploy con preview URL
  ▼
Landing page live!
```

## Stack

| Tecnologia | Versione | Uso |
|-----------|---------|-----|
| **React** | 19 | Componenti UI |
| **Tailwind CSS** | v4 | Styling (CSS-first) |
| **GSAP** | 3.12+ | ScrollTrigger, timeline, SplitText, parallax |
| **Motion.dev** | 12+ | Entrance/exit, gesture, layout animation, spring |
| **TypeScript** | 5.x | Type safety |
| **Vite** / **Next.js** | 7 / 16 | Build tool |

## Requisiti

- [Claude Code](https://claude.ai/code) (CLI) oppure [Cowork](https://cowork.ing)
- Node.js 18+ e pnpm
- Nessuna dipendenza npm da installare (il plugin e autosufficiente)

## Installazione

### Opzione 1: Cowork (marketplace) — consigliata

1. Apri **Cowork** nel browser
2. Vai su **Impostazioni** > **Plugin** > **Personale**
3. Clicca **Aggiungi marketplace**
4. Incolla: `MaxGiu67/landing-craft`
5. Clicca **Sincronizza**
6. Installa il plugin dalla lista

### Opzione 2: Download diretto (senza git)

**macOS / Linux:**
```bash
curl -L https://github.com/MaxGiu67/landing-craft/archive/main.tar.gz | tar xz
cd landing-craft-main
bash install.sh
```

**Windows (PowerShell):**
```powershell
Invoke-WebRequest -Uri https://github.com/MaxGiu67/landing-craft/archive/main.zip -OutFile landing-craft.zip
Expand-Archive landing-craft.zip -DestinationPath .
cd landing-craft-main
bash install.sh
```

### Opzione 3: Download manuale (ZIP)

1. Vai su [github.com/MaxGiu67/landing-craft](https://github.com/MaxGiu67/landing-craft)
2. Clicca **Code** > **Download ZIP**
3. Estrai e esegui `bash install.sh --copy`

### Opzioni install.sh

```bash
bash install.sh              # 7 skill base (consigliato)
bash install.sh --full       # + skill esterne (GSAP 8 skill, Impeccable, Motion, Tailwind, React BP)
bash install.sh --mcp        # + MCP server (Playwright, Lighthouse, A11y, Screenshot, GSAP)
bash install.sh --all        # tutto
bash install.sh --copy       # copia indipendente
bash install.sh --uninstall  # rimuovi skill
```

## Le 7 skill

| Skill | Cosa fa |
|-------|---------|
| `/lp-init` | Setup progetto: scaffold, CLAUDE.md, hook QA, struttura cartelle, animation config |
| `/lp-hero` | Hero section con 4 varianti: minimal, bold, video-bg, split-screen |
| `/lp-section` | Sezione scroll-triggered: features, testimonials, stats, pricing, comparison, CTA, footer |
| `/lp-animate` | Aggiungi animazione a componente esistente: entrance, scroll, hover, stagger, parallax |
| `/lp-qa` | QA completa: build, Lighthouse (>90), A11y (>95), responsive 3 viewport, animation check |
| `/lp-deploy` | Deploy su Vercel o Netlify con preview URL |
| `/lp-status` | Dashboard: sezioni completate, score, checklist prossimi passi |

## GSAP vs Motion.dev — quando usare cosa

| Caso d'uso | GSAP | Motion.dev |
|------------|------|------------|
| Entrance/exit UI | | **Si** |
| Hover, tap, drag | | **Si** |
| Layout animation (FLIP) | | **Si** |
| Scroll reveal semplice | | **Si** |
| ScrollTrigger con pin/scrub | **Si** | |
| Timeline sequenziale complessa | **Si** | |
| SplitText animazione testo | **Si** | |
| Parallax multi-layer | **Si** | |
| Counter animato numeri | **Si** | |
| 60+ elementi animati | **Si** | |

## Skill esterne consigliate (opzionali)

Il plugin funziona da solo, ma queste skill aggiungono conoscenza extra:

```bash
npx skills add greensock/gsap-skills                      # 8 skill GSAP ufficiali
npx skills add pbakaus/impeccable                         # Design system + /animate /audit /polish
npx skills add jezweb/claude-skills --skill motion        # Motion.dev 29+ pattern
npx skills add secondsky/claude-skills --skill tailwind-v4-shadcn  # Tailwind v4
npx skills add vercel-labs/agent-skills --skill react-best-practices
npx skills add vercel-labs/agent-skills --skill web-design-guidelines
```

Oppure installa tutto con: `bash install.sh --full`

## MCP Server consigliati (opzionali)

Per QA avanzata e deploy integrato:

```bash
claude mcp add --scope user playwright npx @playwright/mcp@latest    # Visual testing
claude mcp add lighthouse npx @danielsogl/lighthouse-mcp@latest      # Performance
claude mcp add a11y npx -y a11y-mcp-server                          # Accessibility
claude mcp add screenshot-website npx -y @just-every/mcp-screenshot-website-fast
claude plugin install figma@claude-plugins-official                   # Figma → code
```

Oppure installa tutto con: `bash install.sh --mcp`

## Esempio sessione

```
> /lp-init
Nome: acme-saas
Stack: React + Vite
Sezioni: hero, features, pricing, cta, footer
Stile: minimal

[scaffold progetto, CLAUDE.md, hook, animation config]

> /lp-hero minimal
[genera Hero.tsx con fade-up sequenziale, CTA scale, social proof stagger]

> /lp-section features
[genera Features.tsx con grid cards, scroll reveal stagger]

> /lp-section pricing
[genera Pricing.tsx con 3 colonne, toggle annual, stagger cards]

> /lp-section cta
[genera CTA.tsx con gradient bg, fade-up, CTA pulse]

> /lp-animate src/components/sections/Features.tsx parallax
[aggiunge parallax alle immagini features]

> /lp-qa
Performance: 94/100 | Accessibility: 97/100
Responsive: 3/3 OK | Animations: 8/8 OK
SEO: 5/6 (manca og:image)

> /lp-deploy vercel
Deployed! https://acme-saas.vercel.app
```

## Disinstallazione

**Claude Code:**
```bash
bash install.sh --uninstall
```

**Cowork:** Vai su Impostazioni > Plugin > landing-craft > Disinstalla

## Licenza

MIT
