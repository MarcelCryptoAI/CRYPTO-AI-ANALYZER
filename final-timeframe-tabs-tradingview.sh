#!/bin/bash

echo "🧠 Toevoegen van tijdframe-afhankelijke indicatoren en TradingView-wissel aan detail.html..."

FILE="frontend/html/detail.html"

# Voeg tabs toe boven de chart als ze nog niet bestaan
awk '/<div id="tradingview_chart"/ && !found { print "<div class=\"flex gap-2 justify-center my-4\">"; print "  <button class=\"tf-tab active-tab text-cyan-400 border-b-2 border-cyan-400 px-3 py-1\" data-tf=\"1h\">1H</button>"; print "  <button class=\"tf-tab text-slate-400 hover:text-white px-3 py-1\" data-tf=\"5m\">5M</button>"; print "  <button class=\"tf-tab text-slate-400 hover:text-white px-3 py-1\" data-tf=\"15m\">15M</button>"; print "  <button class=\"tf-tab text-slate-400 hover:text-white px-3 py-1\" data-tf=\"4h\">4H</button>"; print "  <button class=\"tf-tab text-slate-400 hover:text-white px-3 py-1\" data-tf=\"1d\">1D</button>"; print "</div>"; found=1 } { print }' "$FILE" > tmp && mv tmp "$FILE"

# Voeg mockdata en wissellogica in <script>
awk '/<\/script>/ {
  print "";
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
  print "  const tfButtons = document.querySelectorAll('.tf-tab');";
  print "  tfButtons.forEach(btn => btn.addEventListener('click', () => {";
  print "    tfButtons.forEach(b => b.classList.remove('active-tab', 'text-cyan-400', 'border-cyan-400'));";
  print "    btn.classList.add('active-tab', 'text-cyan-400', 'border-cyan-400');";
  print "    currentTimeframe = btn.getAttribute('data-tf');";
  print "    updateTradingView(currentTimeframe);";
  print "    renderIndicators();";
  print "  }));";
  print "";
  print "  function updateTradingView(tf) {";
  print "    const chart = document.getElementById('tradingview_chart');";
  print "    chart.innerHTML = '';";
  print "    new TradingView.widget({";
  print "      container_id: \"tradingview_chart\",";
  print "      width: \"100%\",";
  print "      height: 400,";
  print "      symbol: \"BYBIT:BTCUSDT.P\",";
  print "      interval: tf.replace('m','').replace('h','60').replace('d','1D'),";
  print "      timezone: \"Etc/UTC\",";
  print "      theme: \"dark\",";
  print "      style: \"1\",";
  print "      locale: \"nl\",";
  print "      toolbar_bg: \"#f1f3f6\",";
  print "      enable_publishing: false,";
  print "      hide_side_toolbar: false,";
  print "      allow_symbol_change: true,";
  print "      studies: []";
  print "    });";
  print "  }";
  next } 1' "$FILE" > tmp && mv tmp "$FILE"

echo "✅ Tijdframe tabs, mockdata en TV-widget logica succesvol toegevoegd aan $FILE"
