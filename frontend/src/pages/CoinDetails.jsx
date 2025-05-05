import React from 'react';
import { useParams } from 'react-router-dom';
import IndicatorCard from '../components/IndicatorCard';

const indicators = Array.from({ length: 40 }, (_, i) => ({
  name: `Indicator ${i + 1}`,
  ibs: Math.floor(70 + Math.random() * 30),
  explanation: 'AI analyse van historische data geeft dit signaal.',
  imageUrl: `https://dummyimage.com/600x250/18181b/f0f0f0&text=Chart+${i + 1}`,
  signal: ['LONG', 'SHORT', 'NEUTRAAL'][Math.floor(Math.random() * 3)]
}));

export default function CoinDetails() {
  const { coin } = useParams();
  return (
    <div className="p-6">
      <h1 className="text-3xl font-bold text-cyan-400 mb-6">{coin} - Analyse</h1>
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        {indicators.map((ind, i) => (
          <IndicatorCard key={i} {...ind} />
        ))}
      </div>
    </div>
  );
}
