#!/bin/bash

FRONTEND_DIR="./frontend"
APP_FILE="$FRONTEND_DIR/src/App.jsx"
PAGE_DIR="$FRONTEND_DIR/src/pages"
DETAIL_PAGE="$FRONTEND_DIR/src/components/CoinDetailPage.jsx"
DASHBOARD_FILE="$PAGE_DIR/Dashboard.jsx"

# Check
if [ ! -d "$FRONTEND_DIR" ]; then
  echo "❌ Map 'frontend' niet gevonden. Draai dit script uit de rootmap naast frontend/"
  exit 1
fi

echo "📦 React Router installeren..."
cd "$FRONTEND_DIR" && npm install react-router-dom && cd ..

echo "📁 Pagina map maken..."
mkdir -p "$PAGE_DIR"

echo "✅ App.jsx vervangen met routing setup..."
cat <<EOF > "$APP_FILE"
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Dashboard from './pages/Dashboard'
import CoinDetailPage from './components/CoinDetailPage'

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Dashboard />} />
        <Route path="/coin/:symbol" element={<CoinDetailPage />} />
      </Routes>
    </Router>
  )
}

export default App
EOF

echo "✅ Dashboard.jsx toegevoegd..."
cat <<EOF > "$DASHBOARD_FILE"
import { Link } from 'react-router-dom'

const exampleCoins = ['BTCUSDT', 'ETHUSDT', 'SOLUSDT']

export default function Dashboard() {
  return (
    <div className="p-6 text-white">
      <h1 className="text-2xl font-bold mb-4">Dashboard</h1>
      <ul className="space-y-2">
        {exampleCoins.map(symbol => (
          <li key={symbol}>
            <Link to={\`/coin/\${symbol}\`} className="text-blue-400 underline hover:text-blue-200">
              Bekijk \${symbol}
            </Link>
          </li>
        ))}
      </ul>
    </div>
  )
}
EOF

# Voeg useParams toe in CoinDetailPage.jsx
if grep -q "selectedSymbol" "$DETAIL_PAGE"; then
  echo "🔁 CoinDetailPage aanpassen voor routering..."
  sed -i '' '1a\
import { useParams } from "react-router-dom"
' "$DETAIL_PAGE"

  # Verwijder hardcoded selectedSymbol
  sed -i '' '/selectedSymbol/d' "$DETAIL_PAGE"

  # Voeg symbol afleiding toe
  sed -i '' '/const \[search, setSearch\]/i\
  const { symbol } = useParams()
' "$DETAIL_PAGE"

  # Vervang gebruik van selectedSymbol
  sed -i '' 's/{selectedSymbol}/{symbol}/g' "$DETAIL_PAGE"
fi

echo "🎉 Routing opgezet: / toont dashboard, /coin/BTCUSDT toont details"
