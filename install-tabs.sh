
#!/bin/bash

echo "🛠️ Toevoegen van tabstructuur voor tijdframes aan detail.html..."

TARGET="frontend/html/detail.html"

# Injecteer HTML tabstructuur na de chart sectie
sed -i '' '/<div id="tradingview_chart"/a \
<div id="timeframe-tabs" class="flex justify-center gap-2 mt-6 mb-6">\
  <button data-tf="5m" class="tf-tab px-4 py-1 rounded-full text-slate-300 border border-slate-600 hover:text-cyan-300">5m</button>\
  <button data-tf="15m" class="tf-tab px-4 py-1 rounded-full text-slate-300 border border-slate-600 hover:text-cyan-300">15m</button>\
  <button data-tf="1h" class="tf-tab active-tab px-4 py-1 rounded-full text-cyan-400 border border-cyan-400">1h</button>\
  <button data-tf="4h" class="tf-tab px-4 py-1 rounded-full text-slate-300 border border-slate-600 hover:text-cyan-300">4h</button>\
  <button data-tf="1d" class="tf-tab px-4 py-1 rounded-full text-slate-300 border border-slate-600 hover:text-cyan-300">1d</button>\
</div>' $TARGET

# Voeg script toe onderaan body voor tabs-gedrag
sed -i '' '/renderIndicators()/a \
document.querySelectorAll(".tf-tab").forEach(btn => {\
  btn.addEventListener("click", () => {\
    document.querySelectorAll(".tf-tab").forEach(b => b.classList.remove("active-tab", "text-cyan-400", "border-cyan-400"));\
    btn.classList.add("active-tab", "text-cyan-400", "border-cyan-400");\
    const tf = btn.getAttribute("data-tf");\
    updateChart(tf);\
    // TODO: hier ook indicator data switchen\
  });\
});\

function updateChart(tf) {\
  document.getElementById("tradingview_chart").innerHTML = "";\
  new TradingView.widget({\
    container_id: "tradingview_chart",\
    width: "100%",\
    height: 400,\
    symbol: "BYBIT:BTCUSDT.P",\
    interval: tf.replace("m", "").replace("h", "60").replace("d", "1D"),\
    timezone: "Etc/UTC",\
    theme: "dark",\
    style: "1",\
    locale: "nl",\
    toolbar_bg: "#f1f3f6",\
    enable_publishing: false,\
    hide_side_toolbar: false,\
    allow_symbol_change: true,\
    studies: [],\
  });\
}\
' $TARGET

echo "✅ Tabstructuur en logica succesvol toegevoegd aan: $TARGET"
