#!/bin/bash

echo "🛠️ Injectie van tijdframe-tabstructuur (HTML + JS) in detail.html..."

TARGET="frontend/html/detail.html"

# Injecteer HTML tabstructuur onder de chart container
awk '/<div id="tradingview_chart"/ {
    print;
    print "<div id=\"timeframe-tabs\" class=\"flex justify-center gap-2 mt-6 mb-6\">";
    print "  <button data-tf=\"5m\" class=\"tf-tab px-4 py-1 rounded-full text-slate-300 border border-slate-600 hover:text-cyan-300\">5m</button>";
    print "  <button data-tf=\"15m\" class=\"tf-tab px-4 py-1 rounded-full text-slate-300 border border-slate-600 hover:text-cyan-300\">15m</button>";
    print "  <button data-tf=\"1h\" class=\"tf-tab active-tab px-4 py-1 rounded-full text-cyan-400 border border-cyan-400\">1h</button>";
    print "  <button data-tf=\"4h\" class=\"tf-tab px-4 py-1 rounded-full text-slate-300 border border-slate-600 hover:text-cyan-300\">4h</button>";
    print "  <button data-tf=\"1d\" class=\"tf-tab px-4 py-1 rounded-full text-slate-300 border border-slate-600 hover:text-cyan-300\">1d</button>";
    print "</div>";
    next
} 1' "$TARGET" > tmp && mv tmp "$TARGET"

# Injecteer JS binnen bestaande <script> tag aan het einde
awk '/<\/script>/ {
    print "document.querySelectorAll(\".tf-tab\").forEach(btn => {";
    print "  btn.addEventListener(\"click\", () => {";
    print "    document.querySelectorAll(\".tf-tab\").forEach(b => b.classList.remove(\"active-tab\", \"text-cyan-400\", \"border-cyan-400\"));";
    print "    btn.classList.add(\"active-tab\", \"text-cyan-400\", \"border-cyan-400\");";
    print "    const tf = btn.getAttribute(\"data-tf\");";
    print "    updateChart(tf);";
    print "  });";
    print "});";
    print "";
    print "function updateChart(tf) {";
    print "  document.getElementById(\"tradingview_chart\").innerHTML = \"\";";
    print "  new TradingView.widget({";
    print "    container_id: \"tradingview_chart\",";
    print "    width: \"100%\",";
    print "    height: 400,";
    print "    symbol: \"BYBIT:BTCUSDT.P\",";
    print "    interval: tf === '5m' ? '5' : tf === '15m' ? '15' : tf === '1h' ? '60' : tf === '4h' ? '240' : 'D',";
    print "    timezone: \"Etc/UTC\",";
    print "    theme: \"dark\",";
    print "    style: \"1\",";
    print "    locale: \"nl\",";
    print "    toolbar_bg: \"#f1f3f6\",";
    print "    enable_publishing: false,";
    print "    hide_side_toolbar: false,";
    print "    allow_symbol_change: true,";
    print "    studies: [],";
    print "  });";
    print "}";
    print "";
    next
} 1' "$TARGET" > tmp && mv tmp "$TARGET"

echo "✅ Tijdframe tabs en logica veilig toegevoegd aan $TARGET"
