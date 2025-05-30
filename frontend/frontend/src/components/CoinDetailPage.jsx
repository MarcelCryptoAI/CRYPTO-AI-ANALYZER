import { useState } from 'react'
import { useParams } from "react-router-dom"

const timeframes = ['5m', '15m', '1h', '4h', '12h', '24h']

const indicatorList = [
  { name: 'RSI', color: 'blue', value: '48.3', status: 'Neutral' },
  { name: 'MACD', color: 'green', value: 'Bullish', status: 'Cross Above Signal' },
  { name: 'KDJ', color: 'purple', value: '61.5', status: 'Mild Overbought' },
]

export default function CoinDetailPage() {
  const { symbol } = useParams()
  const [search, setSearch] = useState('')
  const [selectedTimeframe, setSelectedTimeframe] = useState('1h')

  const coinList = ['BTCUSDT', 'ETHUSDT', 'SOLUSDT', 'XRPUSDT', 'ADAUSDT']
  const filteredCoins = coinList.filter(coin =>
    coin.toLowerCase().includes(search.toLowerCase())
  )

  return (
    <div className="p-4 space-y-4 max-w-screen-xl mx-auto">
      {/* Munt selectie */}
      <div className="flex flex-col sm:flex-row items-center justify-between gap-4">
        <div className="flex items-center gap-2 w-full sm:w-auto">
          <label className="text-white font-semibold">Select Coin:</label>
          <select
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

      {/* Chart */}
      <div className="bg-gray-900 rounded-lg shadow-lg h-80 flex items-center justify-center text-white text-xl">
      </div>

      {/* Tijdframe-tabs */}
      <div className="flex justify-center gap-2 flex-wrap">
        {timeframes.map(tf => (
          <button
            key={tf}
            onClick={() => setSelectedTimeframe(tf)}
            className={`px-4 py-2 rounded-full border font-semibold transition ${selectedTimeframe === tf ? 'bg-blue-600 text-white border-blue-700' : 'bg-gray-800 text-gray-300 border-gray-600 hover:bg-gray-700'}`}
          >
            {tf}
          </button>
        ))}
      </div>

      {/* Indicatoren */}
      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 mt-6">
        {indicatorList.map((indicator, i) => (
          <div key={i} className="bg-gray-800 rounded-lg p-4 text-center shadow">
            <h4 className={`text-md font-bold text-${indicator.color}-400`}>{indicator.name}</h4>
            <p className="text-white text-xl mt-2">{indicator.value}</p>
            <p className="text-sm text-gray-400">{indicator.status}</p>
          </div>
        ))}
      </div>
    </div>
  )
}
