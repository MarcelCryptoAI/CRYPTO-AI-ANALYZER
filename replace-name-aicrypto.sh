#!/bin/bash
echo "🔁 Vervangen van 'Crypto Analyse Pro' naar 'Ai Crypto Analyser'..."

# Vervang in alle HTML-bestanden onder de frontend/html map
find frontend/html -type f -name "*.html" -exec sed -i '' 's/Crypto Analyse Pro/Ai Crypto Analyser/g' {} +

# Vervang ook in eventuele andere mappen (indien van toepassing)
find frontend -type f -name "*.html" -exec sed -i '' 's/Crypto Analyse Pro/Ai Crypto Analyser/g' {} +

echo "✅ Naam vervangen in alle relevante HTML-bestanden."
