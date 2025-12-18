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
