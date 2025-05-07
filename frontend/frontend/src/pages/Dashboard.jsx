import { Link } from 'react-router-dom'

const exampleCoins = ['BTCUSDT', 'ETHUSDT', 'SOLUSDT']

export default function Dashboard() {
  return (
    <div className="p-6 text-white">
      <h1 className="text-2xl font-bold mb-4">Dashboard</h1>
      <ul className="space-y-2">
        {exampleCoins.map(symbol => (
          <li key={symbol}>
            <Link to={`/coin/${symbol}`} className="text-blue-400 underline hover:text-blue-200">
              Bekijk ${symbol}
            </Link>
          </li>
        ))}
      </ul>
    </div>
  )
}
