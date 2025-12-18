#!/bin/bash
set -e

echo "Creating App Router rendering examples (no src directory)..."

# Static Rendering (SSG)
mkdir -p app/about
cat <<EOF > app/about/page.tsx
export const revalidate = false;

export default function AboutPage() {
  return (
    <main>
      <h1>Static Rendering (SSG)</h1>
      <p>This page is rendered at build time.</p>
    </main>
  );
}
EOF

# Dynamic Rendering (SSR)
mkdir -p app/dashboard
cat <<EOF > app/dashboard/page.tsx
export const dynamic = 'force-dynamic';

async function getMetrics() {
  const res = await fetch('https://jsonplaceholder.typicode.com/todos/1', {
    cache: 'no-store',
  });
  return res.json();
}

export default async function DashboardPage() {
  const data = await getMetrics();

  return (
    <main>
      <h1>Dynamic Rendering (SSR)</h1>
      <pre>{JSON.stringify(data, null, 2)}</pre>
    </main>
  );
}
EOF

# Hybrid Rendering (ISR)
mkdir -p app/news
cat <<EOF > app/news/page.tsx
export const revalidate = 60;

async function getNews() {
  const res = await fetch('https://jsonplaceholder.typicode.com/posts/1');
  return res.json();
}

export default async function NewsPage() {
  const data = await getNews();

  return (
    <main>
      <h1>Hybrid Rendering (ISR)</h1>
      <p>This page revalidates every 60 seconds.</p>
      <pre>{JSON.stringify(data, null, 2)}</pre>
    </main>
  );
}
EOF

# Home Page
cat <<EOF > app/page.tsx
export default function HomePage() {
  return (
    <main>
      <h1>Next.js App Router Rendering Demo</h1>
      <ul>
        <li><a href="/about">Static (SSG)</a></li>
        <li><a href="/dashboard">Dynamic (SSR)</a></li>
        <li><a href="/news">Hybrid (ISR)</a></li>
      </ul>
    </main>
  );
}
EOF

# README
cat <<EOF > README.md
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
EOF

echo "Setup complete."
echo "Run: npm run dev"
