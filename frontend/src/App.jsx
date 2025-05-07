import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Dashboard from './pages/Dashboard';
import CoinDetailPage from './components/CoinDetailPage';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Dashboard />} />
        <Route path="/coin/:symbol" element={<CoinDetailPage />} />
      </Routes>
    </Router>
  );
}

export default App;
