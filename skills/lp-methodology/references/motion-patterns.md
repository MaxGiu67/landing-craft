# Pattern Motion.dev (ex Framer Motion) per Landing Page

Reference per le skill landing-craft. Pattern Motion 12+ per React.

---

## Base: motion component

```jsx
import { motion } from "motion/react";

// Entrance animation
<motion.div
  initial={{ opacity: 0, y: 40 }}
  animate={{ opacity: 1, y: 0 }}
  transition={{ duration: 0.6, ease: [0.25, 0.46, 0.45, 0.94] }}
>
  Contenuto
</motion.div>
```

## Scroll-triggered: useInView

```jsx
import { motion, useInView } from "motion/react";

function ScrollReveal({ children }) {
  const ref = useRef(null);
  const isInView = useInView(ref, { once: true, margin: "-100px" });

  return (
    <motion.div
      ref={ref}
      initial={{ opacity: 0, y: 40 }}
      animate={isInView ? { opacity: 1, y: 0 } : {}}
      transition={{ duration: 0.6, ease: "easeOut" }}
    >
      {children}
    </motion.div>
  );
}
```

## Stagger children

```jsx
const containerVariants = {
  hidden: { opacity: 0 },
  visible: {
    opacity: 1,
    transition: {
      staggerChildren: 0.1,
      delayChildren: 0.2
    }
  }
};

const itemVariants = {
  hidden: { opacity: 0, y: 20 },
  visible: { opacity: 1, y: 0, transition: { duration: 0.5 } }
};

<motion.div variants={containerVariants} initial="hidden" animate="visible">
  {items.map((item) => (
    <motion.div key={item.id} variants={itemVariants}>
      {item.content}
    </motion.div>
  ))}
</motion.div>
```

## Gesture: hover, tap, drag

```jsx
// CTA button con hover
<motion.button
  whileHover={{ scale: 1.05, boxShadow: "0 10px 30px rgba(0,0,0,0.15)" }}
  whileTap={{ scale: 0.98 }}
  transition={{ type: "spring", stiffness: 400, damping: 17 }}
>
  Get Started
</motion.button>

// Magnetic button (segue il mouse)
function MagneticButton({ children }) {
  const [position, setPosition] = useState({ x: 0, y: 0 });
  const ref = useRef(null);

  const handleMouse = (e) => {
    const { left, top, width, height } = ref.current.getBoundingClientRect();
    setPosition({
      x: (e.clientX - left - width / 2) * 0.3,
      y: (e.clientY - top - height / 2) * 0.3
    });
  };

  return (
    <motion.button
      ref={ref}
      animate={{ x: position.x, y: position.y }}
      transition={{ type: "spring", stiffness: 150, damping: 15 }}
      onMouseMove={handleMouse}
      onMouseLeave={() => setPosition({ x: 0, y: 0 })}
    >
      {children}
    </motion.button>
  );
}
```

## Layout animation (FLIP)

```jsx
// Shared layout animation tra componenti
<motion.div layout layoutId="card-highlight">
  {/* si anima automaticamente quando cambia posizione */}
</motion.div>

// Expand/collapse
<motion.div layout style={{ borderRadius: 12 }}>
  <motion.h3 layout="position">Titolo</motion.h3>
  {isOpen && (
    <motion.p
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
    >
      Contenuto espanso
    </motion.p>
  )}
</motion.div>
```

## AnimatePresence: exit animation

```jsx
import { AnimatePresence, motion } from "motion/react";

<AnimatePresence mode="wait">
  {isVisible && (
    <motion.div
      key="modal"
      initial={{ opacity: 0, scale: 0.95 }}
      animate={{ opacity: 1, scale: 1 }}
      exit={{ opacity: 0, scale: 0.95 }}
      transition={{ duration: 0.3 }}
    >
      Modal content
    </motion.div>
  )}
</AnimatePresence>
```

## Spring physics

```jsx
// Spring naturale (default consigliato per UI)
transition={{ type: "spring", stiffness: 100, damping: 15 }}

// Spring veloce (button, toggle)
transition={{ type: "spring", stiffness: 400, damping: 25 }}

// Spring morbida (modal, overlay)
transition={{ type: "spring", stiffness: 80, damping: 20 }}

// Spring bouncy (playful)
transition={{ type: "spring", stiffness: 300, damping: 10 }}
```

## Scroll progress (parallax)

```jsx
import { motion, useScroll, useTransform } from "motion/react";

function ParallaxHero() {
  const ref = useRef(null);
  const { scrollYProgress } = useScroll({
    target: ref,
    offset: ["start start", "end start"]
  });

  const y = useTransform(scrollYProgress, [0, 1], [0, -200]);
  const opacity = useTransform(scrollYProgress, [0, 0.5], [1, 0]);

  return (
    <section ref={ref} style={{ position: "relative", height: "100vh" }}>
      <motion.div style={{ y, opacity }}>
        <h1>Parallax Hero</h1>
      </motion.div>
    </section>
  );
}
```

## LazyMotion: Bundle optimization

```jsx
// SEMPRE usare LazyMotion per landing page — riduce bundle da 34KB a 6KB
import { LazyMotion, domAnimation, m } from "motion/react";

function App() {
  return (
    <LazyMotion features={domAnimation}>
      <m.div animate={{ opacity: 1 }}>
        {/* usa m.div invece di motion.div con LazyMotion */}
      </m.div>
    </LazyMotion>
  );
}
```

## prefers-reduced-motion

```jsx
import { useReducedMotion } from "motion/react";

function AnimatedSection({ children }) {
  const shouldReduceMotion = useReducedMotion();

  return (
    <motion.div
      initial={shouldReduceMotion ? {} : { opacity: 0, y: 40 }}
      animate={{ opacity: 1, y: 0 }}
      transition={shouldReduceMotion ? { duration: 0 } : { duration: 0.6 }}
    >
      {children}
    </motion.div>
  );
}
```

## Quando usare Motion vs GSAP

| Caso d'uso | Motion | GSAP |
|------------|--------|------|
| Entrance/exit UI | **Si** | No |
| Hover/tap/drag | **Si** | No |
| Layout animation (FLIP) | **Si** | No |
| Scroll reveal semplice | **Si** | No |
| ScrollTrigger complesso (pin, scrub) | No | **Si** |
| Timeline sequenziale complessa | No | **Si** |
| SplitText animazione testo | No | **Si** |
| Parallax multi-layer | Possibile | **Si** (migliore) |
| SVG morphing | Possibile | **Si** (MorphSVG) |
| Performance-critical (60+ elementi) | No | **Si** |
