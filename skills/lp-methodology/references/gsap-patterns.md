# Pattern GSAP per Landing Page

Reference per le skill landing-craft. Pattern GSAP 3.12+ testati e aggiornati.

---

## Core: Tween

```jsx
// to — anima VERSO i valori
gsap.to(".element", { opacity: 1, y: 0, duration: 0.8, ease: "power2.out" });

// from — anima DA i valori (stato iniziale esplicito)
gsap.from(".element", { opacity: 0, y: 40, duration: 0.8, ease: "power2.out" });

// fromTo — controllo completo
gsap.fromTo(".element",
  { opacity: 0, y: 40 },
  { opacity: 1, y: 0, duration: 0.8, ease: "power2.out" }
);
```

## Timeline: Sequenze

```jsx
const tl = gsap.timeline({ defaults: { duration: 0.6, ease: "power2.out" } });

tl.from(".hero-title", { opacity: 0, y: 60 })
  .from(".hero-subtitle", { opacity: 0, y: 40 }, "-=0.3")  // overlap 0.3s
  .from(".hero-cta", { opacity: 0, scale: 0.95 }, "-=0.2")
  .from(".hero-image", { opacity: 0, x: 60 }, "-=0.4");
```

## ScrollTrigger: Animazioni scroll-driven

```jsx
// Reveal on scroll
gsap.from(".feature-card", {
  scrollTrigger: {
    trigger: ".feature-card",
    start: "top 80%",      // trigger quando il top dell'elemento e all'80% del viewport
    end: "top 20%",
    toggleActions: "play none none reverse"  // enter, leave, enterBack, leaveBack
  },
  opacity: 0,
  y: 60,
  duration: 0.8,
  stagger: 0.15
});

// Pin section (parallax)
gsap.to(".parallax-content", {
  scrollTrigger: {
    trigger: ".parallax-section",
    start: "top top",
    end: "+=200%",
    pin: true,
    scrub: 1            // smooth scrubbing
  },
  y: -200
});

// Progress-based (0-1)
ScrollTrigger.create({
  trigger: ".progress-section",
  start: "top center",
  end: "bottom center",
  onUpdate: (self) => {
    // self.progress va da 0 a 1
    gsap.to(".progress-bar", { width: `${self.progress * 100}%` });
  }
});
```

## Stagger: Animazioni a cascata

```jsx
// Stagger base
gsap.from(".card", {
  opacity: 0, y: 40, duration: 0.6,
  stagger: 0.1    // 0.1s tra ogni elemento
});

// Stagger con griglia
gsap.from(".grid-item", {
  opacity: 0, scale: 0.8, duration: 0.5,
  stagger: {
    grid: [4, 3],      // 4 righe, 3 colonne
    from: "center",     // dal centro verso l'esterno
    amount: 0.8         // durata totale stagger
  }
});
```

## SplitText: Animazione testo

```jsx
// Split per caratteri (heading bold)
const split = new SplitText(".hero-title", { type: "chars,words" });
gsap.from(split.chars, {
  opacity: 0, y: 20, rotateX: -90,
  duration: 0.5, stagger: 0.02, ease: "back.out(1.7)"
});

// Split per righe (paragrafi)
const splitLines = new SplitText(".description", { type: "lines" });
gsap.from(splitLines.lines, {
  opacity: 0, y: 30, duration: 0.6, stagger: 0.1
});
```

## React: Hook useGSAP

```jsx
import { useGSAP } from "@gsap/react";
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

gsap.registerPlugin(ScrollTrigger);

function HeroSection() {
  const containerRef = useRef(null);

  // useGSAP gestisce cleanup automaticamente — MAI usare useEffect per GSAP
  useGSAP(() => {
    const tl = gsap.timeline();
    tl.from(".hero-title", { opacity: 0, y: 60, duration: 0.8 })
      .from(".hero-cta", { opacity: 0, scale: 0.95 }, "-=0.3");
  }, { scope: containerRef }); // scope limita le query al container

  return <section ref={containerRef}>...</section>;
}
```

## Performance: 60fps

| Regola | Cosa fare | Cosa NON fare |
|--------|-----------|---------------|
| GPU compositing | `transform`, `opacity` | `width`, `height`, `top`, `left`, `margin` |
| will-change | Aggiungere prima dell'animazione, rimuovere dopo | Lasciare `will-change` permanente |
| Force3D | `gsap.to(el, { force3D: true })` (default) | Disabilitare force3D |
| Batch | Usare `stagger` invece di N tween separati | Creare un tween per ogni elemento |
| Cleanup | `useGSAP` o `ctx.revert()` | `useEffect` senza cleanup ScrollTrigger |

## Ease Reference

| Ease | Quando usarla | Sensazione |
|------|---------------|------------|
| `power2.out` | Default per entrance | Naturale, decelerazione morbida |
| `power3.out` | Entrance drammatica | Piu veloce all'inizio |
| `back.out(1.7)` | Overshoot giocoso | Rimbalzo leggero |
| `elastic.out(1, 0.3)` | Bounce playful | Elastico, divertente |
| `none` (linear) | Progress bar, scrub | Costante |
| `expo.out` | Apertura menu/modal | Molto veloce → molto lento |

## Anti-pattern da evitare

1. **MAI** `useEffect` + cleanup manuale per GSAP — usa `useGSAP` hook
2. **MAI** animare `width`/`height` — usa `scaleX`/`scaleY`
3. **MAI** dimenticare `ScrollTrigger.refresh()` dopo cambi DOM dinamici
4. **MAI** `will-change: transform` su 50+ elementi — solo sugli elementi animati
5. **MAI** `gsap.killTweensOf()` globale — usa context `ctx.revert()`
