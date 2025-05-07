#!/bin/bash

echo '📦 Start CSS & Tailwind visual update voor indicator cards...'

# 1. Voeg Tailwind style-utils toe
mkdir -p frontend/css

cat <<EOF > frontend/css/style-utils.css
/* Reusable Tailwind utility classes via @apply */
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

# 2. Meld dat gebruiker Tailwind moet configureren om CSS bestand te includen
echo "✅ style-utils.css geplaatst in frontend/css/"
echo "👉 Vergeet niet in je tailwind.config.js 'content' de juiste HTML-paden op te geven."
echo "👉 Voeg desnoods handmatig import toe in je main CSS: @import './css/style-utils.css';"

# 3. Optioneel: melding dat kaart-HTML nu classes zoals 'card', 'ibs-badge', 'card-disabled' moet gebruiken
echo "📌 Gebruik classes zoals 'card' en 'card-disabled' op je kaarten afhankelijk van IBS score."
