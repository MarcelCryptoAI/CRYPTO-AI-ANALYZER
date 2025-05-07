#!/bin/bash

echo "📦 Controleren van vereiste projectstructuur voor Tailwind-integratie..."

ROOT=$(pwd)

check_file() {
  if [ -f "$1" ]; then
    echo "✅ Bestand gevonden: $1"
  else
    echo "❌ Ontbrekend bestand: $1"
  fi
}

check_dir() {
  if [ -d "$1" ]; then
    echo "✅ Map gevonden: $1"
  else
    echo "❌ Ontbrekende map: $1"
  fi
}

check_file "tailwind.config.js"
check_dir "frontend"
check_dir "frontend/html"
check_dir "frontend/css"
check_file "frontend/css/index.css"
check_dir "frontend/components"
check_file "frontend/html/detail.html"

echo ""
echo "💡 Als je een ander pad gebruikt, pas dit script dan aan of verplaats je bestanden naar de standaardstructuur."
