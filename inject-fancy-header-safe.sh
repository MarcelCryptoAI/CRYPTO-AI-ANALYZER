#!/bin/bash

echo "🎯 Injecteren van fancy header vóór de chart-container..."

FILE="frontend/html/detail.html"
BACKUP="frontend/html/detail.html.bak"

# Backup maken
cp "$FILE" "$BACKUP"

# Fancy header HTML (escaped voor sed)
HEADER='<div class="relative w-full py-10 px-6 mb-8 text-center bg-gradient-to-r from-cyan-500/10 via-[#0e1726] to-indigo-500/10 backdrop-blur-xl rounded-3xl shadow-2xl shadow-cyan-500/10 border border-cyan-500/20">\
  <h1 class="text-4xl md:text-5xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-cyan-400 via-emerald-300 to-blue-500 drop-shadow-xl tracking-wide animate-pulse">\
    Bitcoin (BTC/USDT) — 1Uur Analyse\
  </h1>\
  <p class="text-slate-400 text-sm mt-2 italic font-medium">Live marktinzichten & indicator score analyse</p>\
</div>'

# Injecteer vóór eerste TradingView <div>
sed -i '' "/<!-- TradingView Chart -->/i\
$HEADER
" "$FILE"

echo "✅ Fancy header toegevoegd net vóór de chart."
