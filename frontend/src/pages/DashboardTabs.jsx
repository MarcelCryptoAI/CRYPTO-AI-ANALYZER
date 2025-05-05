import React, { useState } from 'react';
import { Link } from 'react-router-dom';

const tijdframes = ['5m', '15m', '1h', '4h', '1d'];
const coins = ['BTCUSDT', 'ETHUSDT', 'SOLUSDT', 'ADAUSDT'];

export default function DashboardTabs() {
  const [active, setActive] = useState('5m');
  return (
    <div className="p-6">
      <h1 className="text-4xl font-bold text-cyan-400 mb-6">Crypto Analyse Pro</h1>

      <div className="flex space-x-3 mb-8">
        {tijdframes.map(tf => (
          <button
            key={tf}
            onClick={() => setActive(tf)}
            className={`px-4 py-2 rounded-full font-semibold transition-all border ${active === tf ? 'bg-cyan-500 text-white border-cyan-400' : 'bg-[#1a1a1e] text-gray-300 border-gray-700 hover:bg-[#2a2a2f]'}`}
          >{tf}</button>
        ))}
      </div>

      <div className="grid grid-cols-2 md:grid-cols-4 gap-6 mb-6">
        <div className="backdrop-blur bg-[#1e1f24]/80 rounded-2xl shadow p-4 text-center">
          <p className="text-sm text-gray-400">Totale munten</p>
          <h2 className="text-2xl font-bold text-purple-300">24</h2>
        </div>
        <div className="backdrop-blur bg-[#1e1f24]/80 rounded-2xl shadow p-4 text-center">
          <p className="text-sm text-gray-400">% Long</p>
          <h2 className="text-2xl font-bold text-green-400">61.5%</h2>
        </div>
        <div className="backdrop-blur bg-[#1e1f24]/80 rounded-2xl shadow p-4 text-center">
          <p className="text-sm text-gray-400">% Short</p>
          <h2 className="text-2xl font-bold text-red-400">38.5%</h2>
        </div>
        <div className="backdrop-blur bg-[#1e1f24]/80 rounded-2xl shadow p-4 text-center">
          <p className="text-sm text-gray-400">Gem. IBS</p>
          <h2 className="text-2xl font-bold text-yellow-400">72%</h2>
        </div>
      </div>

      <div className="overflow-hidden rounded-xl shadow-lg backdrop-blur bg-[#1e1f24]/80">
        <table className="w-full text-left">
          <thead className="text-cyan-300 bg-[#16161a]">
            <tr><th className="p-3">Coin</th><th>Advies</th><th>IBS</th><th>Details</th></tr>
          </thead>
          <tbody>
            {coins.map(coin => (
              <tr key={coin} className="border-t border-gray-700 hover:bg-[#2a2a2f]">
                <td className="p-3">{coin}</td>
                <td className="text-green-400">LONG</td>
                <td className="text-yellow-300">89%</td>
                <td><Link to={`/details/${coin}`} className="text-cyan-400 hover:underline">Details</Link></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
