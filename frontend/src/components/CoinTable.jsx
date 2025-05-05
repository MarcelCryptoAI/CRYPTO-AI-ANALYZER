import React from 'react';

const dummyCoins = [
  { name: 'ADAUSDT', advies: 'LONG', ibs: 88 },
  { name: 'BTCUSDT', advies: 'SHORT', ibs: 71 },
  { name: 'ETHUSDT', advies: 'LONG', ibs: 82 },
  { name: 'XRPUSDT', advies: 'SHORT', ibs: 76 },
  { name: 'SOLUSDT', advies: 'LONG', ibs: 93 },
];

export default function CoinTable({ timeframe }) {
  return (
    <div className="bg-gray-800 p-4 rounded-lg shadow">
      <table className="w-full text-left">
        <thead>
          <tr className="text-gray-400">
            <th className="pb-2">Coin</th>
            <th>Advies</th>
            <th>IBS (%)</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          {dummyCoins
            .sort((a, b) => a.name.localeCompare(b.name))
            .map((coin) => (
              <tr key={coin.name} className="border-t border-gray-700 hover:bg-gray-700 transition">
                <td className="py-2">{coin.name}</td>
                <td>{coin.advies}</td>
                <td>{coin.ibs}%</td>
                <td>
                  <button className="text-sm text-blue-400 hover:underline">Details</button>
                </td>
              </tr>
            ))}
        </tbody>
      </table>
    </div>
  );
}
