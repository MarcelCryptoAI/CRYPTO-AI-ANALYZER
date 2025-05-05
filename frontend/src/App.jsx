import React from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import DashboardTabs from './pages/DashboardTabs';
import CoinDetails from './pages/CoinDetails';

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<DashboardTabs />} />
        <Route path="/details/:coin" element={<CoinDetails />} />
      </Routes>
    </BrowserRouter>
  );
}
