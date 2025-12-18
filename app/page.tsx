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
