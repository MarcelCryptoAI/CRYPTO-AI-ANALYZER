#!/bin/bash

echo "📦 Plaatsen van aangepaste IndicatorCard in frontend/components..."

mkdir -p frontend/components

cat <<EOT > frontend/components/IndicatorCard.html
<div class="relative bg-[#141e30]/60 backdrop-blur-md rounded-2xl p-6 shadow-2xl shadow-cyan-500/30 text-center transform transition-transform duration-300 hover:scale-[1.03] hover:shadow-cyan-300/40 ring-1 ring-cyan-500/20">
  <!-- Afbeelding met overlay -->
  <div class="image-container relative mb-4 rounded-xl overflow-hidden shadow-inner shadow-black/30">
    <img src="{{image}}" alt="{{name}}" class="w-full h-full object-cover" />
    <!-- IBS Badge -->
    <div class="absolute top-2 left-2 bg-black/70 text-white text-xs px-2 py-1 rounded-lg shadow-md">
      IBS: {{ibs}}%
    </div>
    <!-- Waarde onderin op afbeelding -->
    <div class="absolute bottom-2 left-1/2 transform -translate-x-1/2 bg-black/70 text-white text-sm px-3 py-1 rounded shadow-md">
      {{value}}
    </div>
  </div>

  <!-- Titel & Parameters -->
  <h3 class="text-xl font-bold text-white mb-1 drop-shadow">{{advice}}</h3>
  <p class="text-slate-400 text-xs italic mb-3">{{name}}</p>

  <!-- Advies -->
  <p class="{{adviceColor}} text-md font-extrabold tracking-wide mb-2">Advies: {{advice}}</p>

  <!-- Uitleg -->
  <div class="text-slate-300 text-xs italic leading-snug bg-[#0f192a]/60 backdrop-blur rounded-lg shadow-inner shadow-black/30 p-4">
    {{explanation}}
  </div>
</div>
EOT

echo "✅ IndicatorCard.html bijgewerkt in frontend/components/"
