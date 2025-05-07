#!/bin/bash

# Script: fix-layout.sh
# Doel: Herstructureert CoinDetailPage.jsx met correcte volgorde + indicatorList

TARGET_FILE="./src/components/CoinDetailPage.jsx"

if [ ! -f "$TARGET_FILE" ]; then
  echo "❌ Bestand $TARGET_FILE niet gevonden. Draai eerst het hoofdscript."
  exit 1
fi

echo "🔧 Aanpassen van CoinDetailPage.jsx..."

# 1. Voeg indicatorList bovenaan toe (na useState imports)
sed -i '' '/useState/ a\
\
const indicatorList = [\
  { name: "RSI", color: "blue", value: "48.3", status: "Neutral" },\
  { name: "MACD", color: "green", value: "Bullish", status: "Cross Above Signal" },\
  { name: "KDJ", color: "purple", value: "61.5", status: "Mild Overbought" },\
];\
' "$TARGET_FILE"

# 2. Vervang de oude kaartjes met een dynamische .map()
sed -i '' '/{\/\* Hier komen de indicator kaartjes \*\/}/,/<\/div>/c\
{indicatorList.map((indicator, i) => (\
  <div key={i} className="bg-gray-800 rounded-lg p-4 text-center shadow">\
    <h4 className={\`text-md font-bold text-\${indicator.color}-400\`}>{indicator.name}</h4>\
    <p className="text-white text-xl mt-2">{indicator.value}</p>\
    <p className="text-sm text-gray-400">{indicator.status}</p>\
  </div>\
))}
' "$TARGET_FILE"

echo "✅ IndicatorList geïntegreerd."

# 3. Verplaats tijdframes ONDER de chart door code om te wisselen

# Verwijder de huidige timeframe-block tijdelijk naar bestand
sed -n '/{timeframes\.map/,/<\/button>/{p;}' "$TARGET_FILE" > .timeframe-block.tmp

# Verwijder diezelfde regels uit originele bestand
sed -i '' '/{timeframes\.map/,/<\/button>/d' "$TARGET_FILE"

# Voeg het blok toe NA de chart-div
sed -i '' '/Chart for .* selectedTimeframe \] /a\
'"$(cat .timeframe-block.tmp | sed 's/\\/\\\\/g' | sed 's/$/\\/')"'
' "$TARGET_FILE"

rm .timeframe-block.tmp

echo "✅ Tijdframes staan nu onder de chart."
echo "🎉 Layout van CoinDetailPage.jsx is succesvol aangepast!"
