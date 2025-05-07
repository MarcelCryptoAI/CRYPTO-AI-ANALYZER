#!/bin/bash

echo '🚀 Start volledige automatische styling setup...'

# 1. Voeg utility CSS toe
mkdir -p frontend/css

cat <<EOF > frontend/css/style-utils.css
.card {
  @apply relative bg-[#141e30]/60 backdrop-blur-md rounded-2xl p-6 shadow-2xl shadow-cyan-500/30 text-center transform transition-transform duration-500 hover:scale-[1.04] hover:shadow-cyan-300/50 ring-1 ring-cyan-400/30;
}
.card-disabled {
  @apply opacity-50 pointer-events-none;
}
.ibs-badge {
  @apply absolute top-2 left-2 bg-black/80 text-white text-xs px-2 py-1 rounded shadow-md font-semibold;
}
.value-overlay {
  @apply absolute bottom-2 left-1/2 transform -translate-x-1/2 bg-black/70 text-white text-sm px-3 py-1 rounded shadow-md;
}
.card-explainer {
  @apply text-slate-100 text-xs bg-[#1b263b]/80 backdrop-blur-md rounded-xl shadow-inner shadow-black/30 px-4 py-3 leading-snug;
}
EOF

echo "✅ CSS toegevoegd aan frontend/css/style-utils.css"

# 2. tailwind.config.js content array bijwerken als nodig
CONFIG_FILE="tailwind.config.js"
if grep -q "content:" "$CONFIG_FILE"; then
  sed -i '' '/content:/,/]/c\
  content: ["./frontend/html/**/*.html", "./frontend/components/**/*.html", "./frontend/**/*.js"],
  ' "$CONFIG_FILE"
  echo "✅ tailwind.config.js 'content' sectie bijgewerkt"
else
  echo "⚠️  tailwind.config.js bevat geen 'content:' sectie - controleer handmatig"
fi

# 3. Voeg @import toe aan hoofd-CSS bestand
CSS_FILE="frontend/css/index.css"
if ! grep -q "style-utils.css" "$CSS_FILE"; then
  echo "@import './style-utils.css';" >> "$CSS_FILE"
  echo "✅ @import toegevoegd aan $CSS_FILE"
else
  echo "ℹ️  @import al aanwezig in $CSS_FILE"
fi

# 4. Genereer component template met card & card-disabled
mkdir -p frontend/components
cat <<EOF > frontend/components/IndicatorCardTemplate.html
<div class="card {{ ibs < 70 ? 'card-disabled' : '' }}">
  <div class="relative mb-4 rounded-xl overflow-hidden shadow-inner shadow-black/30">
    <img src="{{image}}" alt="{{name}}" class="w-full h-full object-cover" />
    <div class="ibs-badge">IBS: {{ibs}}%</div>
    <div class="value-overlay">{{value}}</div>
  </div>
  <h3 class="text-2xl font-extrabold text-white drop-shadow-sm tracking-wide uppercase">{{advice}}</h3>
  <p class="text-slate-400 text-[13px] italic mb-4">{{name}}</p>
  <p class="{{adviceColor}} text-md font-bold tracking-wider mb-3">Advies: {{advice}}</p>
  <div class="card-explainer">{{explanation}}</div>
</div>
EOF

echo "✅ Nieuwe kaart-template opgeslagen in frontend/components/IndicatorCardTemplate.html"
echo "🎉 Alles succesvol uitgevoerd."
