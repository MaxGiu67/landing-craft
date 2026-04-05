---
name: lp-animate
description: "Aggiunge animazioni a componenti React esistenti senza ristrutturarli. Tipi: entrance, scroll, hover, stagger, parallax. Usa quando l'utente vuole animare un componente, aggiungere movimento, o dice lp animate, anima, aggiungi animazione, troppo statico."
---

# lp-animate — Aggiungi Animazioni a Componenti Esistenti

Aggiunge un layer di animazione a un componente React esistente senza ristrutturare la logica.

## Workflow

### Step 1: Identifica componente e tipo animazione

Argomenti: `$ARGUMENTS` = `<percorso-file> [tipo]`

| Tipo | Cosa fa | Libreria |
|------|---------|----------|
| **entrance** | Fade-up al mount del componente | Motion.dev |
| **scroll** | Reveal quando entra nel viewport | Motion.dev useInView |
| **hover** | Scale + shadow on hover | Motion.dev whileHover |
| **stagger** | Children appaiono in sequenza | Motion.dev variants |
| **parallax** | Movimento differenziato con scroll | GSAP ScrollTrigger |

Se il tipo non e specificato, analizza il componente e suggerisci il piu appropriato.

### Step 2: Leggi e analizza il componente

- Leggi il file sorgente
- Identifica: elementi principali, children iterati, immagini, testi
- Leggi `src/lib/animation-config.ts` per timing coerente
- Consulta reference GSAP/Motion per il pattern scelto

### Step 3: Aggiungi animazione

**Regole di modifica:**
1. **Non ristrutturare** — aggiungi solo il layer animazione
2. **Preserva tutti i props** e la logica esistente
3. **Importa** da "motion/react" per UI, da "gsap" per scroll-heavy
4. **Wrappa** con `<motion.div>` o `<m.div>` (con LazyMotion)
5. **Aggiungi** `prefers-reduced-motion` check
6. **Usa** timing da `animation-config.ts`

### Step 4: Verifica

- Il build compila senza errori
- L'animazione usa solo transform/opacity
- prefers-reduced-motion rispettato
- Nessun layout shift introdotto

## Output

File: componente aggiornato con animazione
Nessun nuovo file creato (modifica in-place)
