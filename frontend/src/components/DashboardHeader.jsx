import React from 'react';

export default function DashboardHeader({ timeframe }) {
  return (
    <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
      <div className="bg-blue-700 rounded-xl p-4 shadow">
        <p className="text-sm text-gray-200">Coins geanalyseerd</p>
        <h2 className="text-2xl font-bold">48</h2>
      </div>
      <div className="bg-green-700 rounded-xl p-4 shadow">
        <p className="text-sm text-gray-200">% Long advies</p>
        <h2 className="text-2xl font-bold">65%</h2>
      </div>
      <div className="bg-red-700 rounded-xl p-4 shadow">
        <p className="text-sm text-gray-200">% Short advies</p>
        <h2 className="text-2xl font-bold">35%</h2>
      </div>
      <div className="bg-yellow-600 rounded-xl p-4 shadow">
        <p className="text-sm text-gray-200">Gem. IBS score</p>
        <h2 className="text-2xl font-bold">78%</h2>
      </div>
    </div>
  );
}
