import React from 'react';

export default function IndicatorCard({ name, ibs, imageUrl, explanation, signal }) {
  const signalColor = signal === 'LONG' ? 'text-green-400' : signal === 'SHORT' ? 'text-red-400' : 'text-yellow-400';
  return (
    <div className="backdrop-blur bg-[#1e1f24]/80 rounded-xl p-4 border border-[#2c2c34] shadow-xl">
      <div className="flex justify-between items-center mb-2">
        <h2 className="text-cyan-300 font-semibold text-md">{name}</h2>
        <span className="text-xs bg-cyan-500 px-2 py-1 rounded-full text-white">IBS: {ibs}%</span>
      </div>
      <img src={imageUrl} alt={name} className="rounded w-full mb-2 border border-[#3a3a3f]" />
      <p className={`text-sm font-bold mb-1 ${signalColor}`}>Signaal: {signal}</p>
      <p className="text-xs text-gray-400 italic">{explanation}</p>
    </div>
  );
}
