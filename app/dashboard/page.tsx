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
