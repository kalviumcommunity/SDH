# Next.js App Router Rendering Demo

## Routes

- /about — Static Rendering (SSG)
- /dashboard — Dynamic Rendering (SSR)
- /news — Hybrid Rendering (ISR)

## Rendering Choices

- SSG for content that rarely changes
- SSR for real-time data
- ISR for performance + freshness balance

## Trade-offs

- SSG is fastest but not dynamic
- SSR is accurate but server-heavy
- ISR requires revalidation tuning
