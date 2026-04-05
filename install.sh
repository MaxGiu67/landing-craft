#!/bin/bash
# install.sh — Installa landing-craft come plugin Claude Code
#
# Uso:
#   bash install.sh              # installa 7 skill (base)
#   bash install.sh --full       # + skill esterne consigliate
#   bash install.sh --mcp        # + MCP server (Playwright, Lighthouse, A11y)
#   bash install.sh --all        # tutto (skill + esterne + MCP)
#   bash install.sh --copy       # copia indipendente
#   bash install.sh --uninstall  # rimuovi skill installate

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"
SKILLS=("lp-methodology" "lp-init" "lp-hero" "lp-section" "lp-animate" "lp-qa" "lp-deploy" "lp-status")
MODE="symlink"
INSTALL_EXTERNAL=false
INSTALL_MCP=false

# Parse argomenti
for arg in "$@"; do
  case $arg in
    --copy) MODE="copy" ;;
    --full) INSTALL_EXTERNAL=true ;;
    --mcp) INSTALL_MCP=true ;;
    --all) INSTALL_EXTERNAL=true; INSTALL_MCP=true ;;
    --uninstall) MODE="uninstall" ;;
    --help|-h)
      echo ""
      echo "  landing-craft installer"
      echo ""
      echo "  Uso: bash install.sh [opzioni]"
      echo ""
      echo "  Opzioni:"
      echo "    (default)     Installa 7 skill con symlink"
      echo "    --copy        Copia indipendente (senza symlink)"
      echo "    --full        + installa skill esterne (GSAP, Impeccable, Motion)"
      echo "    --mcp         + installa MCP server (Playwright, Lighthouse, A11y)"
      echo "    --all         Tutto: skill + esterne + MCP"
      echo "    --uninstall   Rimuovi skill installate"
      echo ""
      exit 0
      ;;
  esac
done

mkdir -p "$SKILLS_DIR"

# ── Disinstallazione ──
if [ "$MODE" = "uninstall" ]; then
  echo ""
  echo "  Disinstallazione landing-craft..."
  echo ""
  for skill in "${SKILLS[@]}"; do
    if [ -L "$SKILLS_DIR/$skill" ] || [ -d "$SKILLS_DIR/$skill" ]; then
      rm -rf "$SKILLS_DIR/$skill"
      echo "  ✓ Rimosso $skill"
    fi
  done
  echo ""
  echo "  ✅ Disinstallazione completata!"
  echo "  → Riavvia Claude Code per applicare le modifiche."
  echo ""
  exit 0
fi

# ── Installazione skill base ──
echo ""
echo "  ╔═══════════════════════════════════════╗"
echo "  ║   landing-craft — Installer v1.0.0    ║"
echo "  ║   Landing Page Animate per Claude Code ║"
echo "  ╚═══════════════════════════════════════╝"
echo ""
echo "  Installazione 7 skill (modalita: $MODE)..."
echo ""

for skill in "${SKILLS[@]}"; do
  src="$SCRIPT_DIR/skills/$skill"
  dst="$SKILLS_DIR/$skill"

  if [ -L "$dst" ] || [ -d "$dst" ]; then
    rm -rf "$dst"
  fi

  if [ "$MODE" = "symlink" ]; then
    ln -sf "$src" "$dst"
    echo "  ✓ $skill → symlink"
  else
    cp -r "$src" "$dst"
    echo "  ✓ $skill → copiato"
  fi
done

echo ""
echo "  ✅ 7 skill installate!"
echo ""

# ── Skill esterne (opzionali) ──
if [ "$INSTALL_EXTERNAL" = true ]; then
  echo "  ── Skill esterne consigliate ──"
  echo ""

  if command -v npx &>/dev/null; then
    echo "  Installazione GSAP skills (8 skill)..."
    npx skills add greensock/gsap-skills 2>/dev/null && echo "  ✓ GSAP skills installate" || echo "  ⚠ GSAP skills: errore (installa manualmente: npx skills add greensock/gsap-skills)"

    echo "  Installazione Impeccable (20 commands)..."
    npx skills add pbakaus/impeccable 2>/dev/null && echo "  ✓ Impeccable installato" || echo "  ⚠ Impeccable: errore (installa manualmente: npx skills add pbakaus/impeccable)"

    echo "  Installazione Motion skill..."
    npx skills add jezweb/claude-skills --skill motion 2>/dev/null && echo "  ✓ Motion skill installata" || echo "  ⚠ Motion: errore (installa manualmente: npx skills add jezweb/claude-skills --skill motion)"

    echo "  Installazione Tailwind v4 + shadcn..."
    npx skills add secondsky/claude-skills --skill tailwind-v4-shadcn 2>/dev/null && echo "  ✓ Tailwind v4 + shadcn installati" || echo "  ⚠ Tailwind: errore"

    echo "  Installazione React best practices..."
    npx skills add vercel-labs/agent-skills --skill react-best-practices 2>/dev/null && echo "  ✓ React best practices installate" || echo "  ⚠ React BP: errore"

    echo "  Installazione Web design guidelines..."
    npx skills add vercel-labs/agent-skills --skill web-design-guidelines 2>/dev/null && echo "  ✓ Web design guidelines installate" || echo "  ⚠ Web design: errore"
  else
    echo "  ⚠ npx non trovato — installa Node.js per le skill esterne"
  fi
  echo ""
fi

# ── MCP Server (opzionali) ──
if [ "$INSTALL_MCP" = true ]; then
  echo "  ── MCP Server ──"
  echo ""

  if command -v claude &>/dev/null; then
    echo "  Installazione Playwright MCP..."
    claude mcp add --scope user playwright npx @playwright/mcp@latest 2>/dev/null && echo "  ✓ Playwright MCP installato" || echo "  ⚠ Playwright MCP: errore"
    npx playwright install chromium 2>/dev/null || true

    echo "  Installazione Lighthouse MCP..."
    claude mcp add lighthouse npx @danielsogl/lighthouse-mcp@latest 2>/dev/null && echo "  ✓ Lighthouse MCP installato" || echo "  ⚠ Lighthouse MCP: errore"

    echo "  Installazione A11y MCP..."
    claude mcp add a11y npx -y a11y-mcp-server 2>/dev/null && echo "  ✓ A11y MCP installato" || echo "  ⚠ A11y MCP: errore"

    echo "  Installazione Screenshot MCP..."
    claude mcp add screenshot-website npx -y @just-every/mcp-screenshot-website-fast 2>/dev/null && echo "  ✓ Screenshot MCP installato" || echo "  ⚠ Screenshot MCP: errore"

    echo "  Installazione GSAP MCP Server..."
    claude mcp add-json gsap-master '{"command":"npx","args":["bruzethegreat-gsap-master-mcp-server@latest"]}' 2>/dev/null && echo "  ✓ GSAP MCP installato" || echo "  ⚠ GSAP MCP: errore"
  else
    echo "  ⚠ Claude Code CLI non trovato — installa MCP manualmente"
  fi
  echo ""
fi

# ── Riepilogo ──
echo "  Skill disponibili:"
echo "    /lp-init       — Inizializza progetto landing page"
echo "    /lp-hero       — Genera hero section animata (4 varianti)"
echo "    /lp-section    — Genera sezione scroll-triggered (7 tipi)"
echo "    /lp-animate    — Aggiungi animazione a componente esistente"
echo "    /lp-qa         — QA completa (Lighthouse, A11y, responsive)"
echo "    /lp-deploy     — Deploy su Vercel/Netlify"
echo "    /lp-status     — Dashboard stato landing"
echo ""

if [ "$INSTALL_EXTERNAL" = false ] && [ "$INSTALL_MCP" = false ]; then
  echo "  Skill esterne e MCP server (opzionali):"
  echo "    bash install.sh --full   # GSAP, Impeccable, Motion, Tailwind, React BP"
  echo "    bash install.sh --mcp    # Playwright, Lighthouse, A11y, Screenshot, GSAP MCP"
  echo "    bash install.sh --all    # tutto"
  echo ""
fi

echo "  → Riavvia Claude Code, poi esegui /lp-init per iniziare."
echo ""
