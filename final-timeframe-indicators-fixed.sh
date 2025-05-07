#!/bin/bash

echo "🧠 Toevoegen van tijdframe-afhankelijke indicatoren en logica aan detail.html..."

TARGET="frontend/html/detail.html"

awk '/<\/script>/ {
  print "  // 📦 Mockdata per tijdframe";
  print "  const indicatorDataByTF = {";
  print "    \"5m\": [";
  print "      { name: \"RSI (14)\", value: \"Waarde: 38\", winrate: 0.74, advice: \"Buy\", explanation: \"5m RSI uitleg\", image: \"./media/RSI.png\" },";
  print "      { name: \"MACD (12,26)\", value: \"0.0021\", winrate: 0.81, advice: \"Strong Buy\", explanation: \"5m MACD uitleg\", image: \"./media/MACD.png\" }";
  print "    ],";
  print "    \"15m\": [";
  print "      { name: \"Supertrend (10,3)\", value: \"Uptrend\", winrate: 0.75, advice: \"Buy\", explanation: \"15m Supertrend\", image: \"./media/SUPERTREND.png\" },";
  print "      { name: \"SMA (14)\", value: \"61420.12\", winrate: 0.61, advice: \"Sell\", explanation: \"15m SMA uitleg\", image: \"./media/SMA.png\" }";
  print "    ],";
  print "    \"1h\": [";
  print "      { name: \"RSI (14)\", value: \"Waarde: 29\", winrate: 0.83, advice: \"Strong Buy\", explanation: \"1h RSI uitleg\", image: \"./media/RSI.png\" },";
  print "      { name: \"MACD (12,26)\", value: \"0.0025\", winrate: 0.85, advice: \"Strong Buy\", explanation: \"1h MACD uitleg\", image: \"./media/MACD.png\" },";
  print "      { name: \"Supertrend (10,3)\", value: \"Uptrend\", winrate: 0.75, advice: \"Buy\", explanation: \"1h Supertrend\", image: \"./media/SUPERTREND.png\" },";
  print "      { name: \"SMA (14)\", value: \"61425.10\", winrate: 0.61, advice: \"Sell\", explanation: \"1h SMA uitleg\", image: \"./media/SMA.png\" }";
  print "    ],";
  print "    \"4h\": [";
  print "      { name: \"RSI (14)\", value: \"Waarde: 42\", winrate: 0.79, advice: \"Buy\", explanation: \"4h RSI uitleg\", image: \"./media/RSI.png\" }";
  print "    ],";
  print "    \"1d\": [";
  print "      { name: \"SMA (14)\", value: \"61480.00\", winrate: 0.77, advice: \"Strong Buy\", explanation: \"1d SMA uitleg\", image: \"./media/SMA.png\" }";
  print "    ]";
  print "  };";
  print "";
  print "  let currentTimeframe = \"1h\";";
  print "";
  print "  function renderIndicators() {";
  print "    const sortType = document.getElementById(\"sort\").value;";
  print "    let indicators = [...(indicatorDataByTF[currentTimeframe] || [])];";
  print "    const adviceOrder = { \"Strong Buy\": 5, \"Buy\": 4, \"Neutraal\": 3, \"Sell\": 2, \"Strong Sell\": 1 };";
  print "";
  print "    switch (sortType) {";
  print "      case \"ibs_asc\": indicators.sort((a, b) => a.winrate - b.winrate); break;";
  print "      case \"ibs_desc\": indicators.sort((a, b) => b.winrate - a.winrate); break;";
  print "      case \"advice_buy_first\": indicators.sort((a, b) => adviceOrder[b.advice] - adviceOrder[a.advice]); break;";
  print "      case \"advice_sell_first\": indicators.sort((a, b) => adviceOrder[a.advice] - adviceOrder[b.advice]); break;";
  print "    }";
  print "";
  print "    const container = document.getElementById(\"indicators\");";
  print "    container.innerHTML = \"\";";
  print "";
  print "    indicators.forEach(ind => {";
  print "      const overlay = ind.winrate < 0.7 ? \" opacity-overlay\" : \"\";";
  print "      const adviceColor = ind.advice.includes(\"Buy\") ? \"text-emerald-400\" :";
  print "                          ind.advice.includes(\"Sell\") ? \"text-red-400\" : \"text-yellow-300\";";
  print "      const ibs = (ind.winrate * 100).toFixed(0);";
  print "      const card = document.createElement(\"div\");";
  print "      card.className = \"relative bg-[#141e30]/60 backdrop-blur-md rounded-2xl p-4 shadow-lg shadow-cyan-500/10 text-center\" + overlay;";
  print "      card.innerHTML = \"<div class='image-container'>\" +";
  print "        \"<img src='\" + ind.image + \"' alt='\" + ind.name + \"' />\" +";
  print "        \"<div class='ibs-overlay'>IBS: \" + ibs + \"%</div>\" +";
  print "        \"</div>\" +";
  print "        \"<h4 class='uppercase font-semibold tracking-wider text-md mb-1'>\" + ind.name + \"</h4>\" +";
  print "        \"<p class='text-slate-100 text-sm mb-1'>\" + ind.value + \"</p>\" +";
  print "        \"<p class='\" + adviceColor + \" font-extrabold mb-1'>Advies: \" + ind.advice + \"</p>\" +";
  print "        \"<p class='text-slate-300 text-xs text-justify'>\" + ind.explanation + \"</p>\";";
  print "      container.appendChild(card);";
  print "    });";
  print "  }";
  print "";
  print "  document.querySelectorAll(\".tf-tab\").forEach(btn => {";
  print "    btn.addEventListener(\"click\", () => {";
  print "      document.querySelectorAll(\".tf-tab\").forEach(b => b.classList.remove(\"active-tab\", \"text-cyan-400\", \"border-cyan-400\"));";
  print "      btn.classList.add(\"active-tab\", \"text-cyan-400\", \"border-cyan-400\");";
  print "      currentTimeframe = btn.getAttribute(\"data-tf\");";
  print "      updateChart(currentTimeframe);";
  print "      renderIndicators();";
  print "    });";
  print "  });";
  next
} 1' "$TARGET" > tmp && mv tmp "$TARGET"

echo "✅ Tijdframe mockdata + logica succesvol toegevoegd!"
