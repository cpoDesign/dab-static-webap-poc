'use client';

import { useEffect, useState } from 'react';

interface Title {
  title_id: string;
  title: string;
  type: string;
  price: number;
  pubdate: string;
}

export default function Home() {
  const [titles, setTitles] = useState<Title[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchTitles = async () => {
      try {
        const response = await fetch('/api/titles');
        if (!response.ok) {
          throw new Error('Failed to fetch titles');
        }
        const data = await response.json();
        setTitles(data.value || []);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'An error occurred');
      } finally {
        setLoading(false);
      }
    };

    fetchTitles();
  }, []);

  if (loading) {
    return <div className="p-4">Loading titles...</div>;
  }

  if (error) {
    return <div className="p-4 text-red-500">Error: {error}</div>;
  }

  return (
    <div className="p-4">
      <h1 className="text-2xl font-bold mb-4">Pubs Database - Titles</h1>
      <div className="grid gap-4">
        {titles.map((title) => (
          <div key={title.title_id} className="border p-4 rounded shadow">
            <h2 className="text-xl font-semibold">{title.title}</h2>
            <p className="text-gray-600">Type: {title.type}</p>
            <p className="text-gray-600">Price: ${title.price.toFixed(2)}</p>
            <p className="text-gray-600">Publication Date: {new Date(title.pubdate).toLocaleDateString()}</p>
          </div>
        ))}
      </div>
    </div>
  );
} 