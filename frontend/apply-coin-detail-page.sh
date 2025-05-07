#!/bin/bash

# Script: apply-coin-detail-page.sh
# Doel: Voeg CoinDetailPage.jsx toe en update App.jsx automatisch

COMPONENT_DIR="./src/components"
COMPONENT_FILE="$COMPONENT_DIR/CoinDetailPage.jsx"
APP_FILE="./src/App.jsx"

# Check of we in een React project staan
if [ ! -d "src" ]; then
  echo "❌ Je zit niet in de root van een React project (src/ ontbreekt)"
  exit 1
fi

# Maak componentmap aan als die nog niet bestaat
mkdir -p "$COMPONENT_DIR"

# Stap 1: CoinDetailPage schrijven
cat <<EOF > "$COMPONENT_FILE"
import { useState } from 'react'

const timeframes = ['5m', '15m', '1h', '4h', '12h', '24h']

export default function CoinDetailPage() {
  const [selectedSymbol, setSelectedSymbol] = useState('BTCUSDT')
  const [search, setSearch] = useState('')
  const [selectedTimeframe, setSelectedTimeframe] = useState('1h')

  const coinList = ['BTCUSDT', 'ETHUSDT', 'SOLUSDT', 'XRPUSDT', 'ADAUSDT']

  const filteredCoins = coinList.filter(coin =>
    coin.toLowerCase().includes(search.toLowerCase())
  )

  return (
    <div className="p-4 space-y-4 max-w-screen-xl mx-auto">
      <div className="flex flex-col sm:flex-row items-center justify-between gap-4">
        <div className="flex items-center gap-2 w-full sm:w-auto">
          <label className="text-white font-semibold">Select Coin:</label>
          <select
            value={selectedSymbol}
            onChange={e => setSelectedSymbol(e.target.value)}
            className="p-2 rounded bg-gray-800 text-white border border-gray-600"
          >
            {filteredCoins.map(coin => (
              <option key={coin} value={coin}>{coin}</option>
            ))}
          </select>
        </div>
        <input
          type="text"
          placeholder="Search coin..."
          className="p-2 rounded bg-gray-800 text-white border border-gray-600 w-full sm:w-60"
          value={search}
          onChange={e => setSearch(e.target.value)}
        />
      </div>

      <div className="bg-gray-900 rounded-lg shadow-lg h-80 flex items-center justify-center text-white text-xl">
        [ Chart for {selectedSymbol} - {selectedTimeframe} ]
      </div>

      <div className="flex justify-center gap-2 flex-wrap">
        {timeframes.map(tf => (
          <button
            key={tf}
            onClick={() => setSelectedTimeframe(tf)}
            className={\`px-4 py-2 rounded-full border font-semibold transition \${selectedTimeframe === tf ? 'bg-blue-600 text-white border-blue-700' : 'bg-gray-800 text-gray-300 border-gray-600 hover:bg-gray-700'}\`}
          >
            {tf}
          </button>
        ))}
      </div>

      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 mt-6">
        {/* Hier komen de indicator kaartjes */}
      </div>
    </div>
  )
}
EOF

echo "✅ CoinDetailPage.jsx is aangemaakt in $COMPONENT_DIR"

# Stap 2: Vervang App.jsx met juiste import en render
cat <<EOF > "$APP_FILE"
import React from 'react'
import CoinDetailPage from './components/CoinDetailPage'

function App() {
  return (
    <div className="bg-black min-h-screen text-white">
      <CoinDetailPage />
    </div>
  )
}

export default App
EOF

echo "✅ App.jsx is bijgewerkt om CoinDetailPage te tonen"

# Eindmelding
echo "🎉 Klaar! Start je dev server met: npm run dev of yarn dev"
