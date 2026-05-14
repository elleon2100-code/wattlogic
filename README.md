# WattLogic.io

**Smart Energy & Solar ROI Calculator** — Static SPA, zero-backend, AdSense-ready.

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Astro 4 (Static output) |
| Styling | Tailwind CSS 3 + custom tokens |
| Calculator | Vanilla JS ES6+ |
| Charts | Chart.js 4 (CDN) |
| PDF Export | jsPDF 2.5 (CDN) |
| i18n | Static JSON translations (EN/ES) |
| Hosting | Any static host (Cloudflare Pages, Netlify, Vercel) |

## Project Structure

```
wattlogic/
├── src/
│   ├── components/
│   │   └── Calculator.astro      ← Core engine: inputs, outputs, chart, PDF
│   ├── layouts/
│   │   └── BaseLayout.astro      ← Nav, AdSense slots, SEO meta, footer
│   ├── pages/
│   │   ├── index.astro           ← Homepage + hero
│   │   ├── privacy.astro         ← AdSense compliance
│   │   ├── cookies.astro         ← GDPR/AdSense compliance
│   │   └── wiki/
│   │       ├── inverters.astro   ← SEO silo: inverters
│   │       ├── batteries.astro   ← SEO silo: lithium batteries
│   │       └── smart-home.astro  ← SEO silo: Zigbee & Matter
│   ├── data/
│   │   └── hsp-cities.json       ← Peak Sun Hours database (35+ cities)
│   └── styles/
│       └── global.css            ← Tailwind + WattLogic design tokens
├── public/                       ← favicon.svg, og-wattlogic.jpg
├── astro.config.mjs
├── tailwind.config.mjs
└── package.json
```

## Quick Start

```bash
npm install
npm run dev       # http://localhost:4321
npm run build     # ./dist/ → deploy anywhere
```

## Solar Formula

```
Panels = (kWh/month × 12) / (HSP × 365 × Wp/1000 × PR)
```

Where:
- **HSP** = Peak Sun Hours for selected city (h/day)
- **Wp** = Panel wattage in Watts
- **PR** = 0.77 Performance Ratio (accounts for inverter losses ~4%, wiring ~2%, soiling ~3%)

## AdSense Setup

Replace all `ca-pub-XXXXXXXXXXXXXXXX` placeholders in `BaseLayout.astro` with your publisher ID.
Activate commented `<ins>` tags at the 3 marked slots:

1. `BELOW_NAV` — 728×90 leaderboard below navigation
2. `BETWEEN_CALC_AND_RESULTS` — 336×280 rectangle between calculator inputs and results
3. `WIKI_SIDEBAR` — 300×250 in-article unit in wiki pages

## SEO Silo Architecture

```
WattLogic.io (DA accumulator)
├── / (calculator — main money page)
├── /wiki/inverters     → internal link to /
├── /wiki/batteries     → internal link to /
└── /wiki/smart-home    → internal link to /
```

Each wiki page links back to the calculator creating a topical authority cluster
around photovoltaic + home energy keywords.

## Deployment (Cloudflare Pages)

```bash
npm run build
# Deploy ./dist to Cloudflare Pages
# Build command: npm run build
# Output directory: dist
```

## i18n

- Language detection: `document.documentElement.lang` or `navigator.language`
- Switcher: EN/ES buttons call `window.wlSetLang(lang)` exposed by Calculator.astro
- Currency auto-detection: driven by HSP city selection (USD/EUR/MXN/AUD)

## Environment

No environment variables needed. 100% client-side. No API keys. No database.
