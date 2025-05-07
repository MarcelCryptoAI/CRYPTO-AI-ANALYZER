#!/bin/bash

echo "🚀 Installeert Vite + Tailwind setup..."

# Initialiseer npm indien nog niet gedaan
npm init -y

# Installeer Vite en Tailwind stack
npm install -D vite tailwindcss postcss autoprefixer

# Initialiseer Tailwind
npx tailwindcss init -p

# Maak projectstructuur aan
mkdir -p frontend/css frontend/html frontend/js

# input.css voor Tailwind
cat <<EOT > frontend/css/input.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOT

# tailwind.config.js
cat <<EOT > tailwind.config.js
module.exports = {
  content: [
    "./frontend/html/**/*.{html,js}",
    "./frontend/components/**/*.{html,js}",
    "./frontend/js/**/*.{html,js}"
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', 'ui-sans-serif', 'system-ui'],
      },
      colors: {
        background: '#0e1726',
        card: '#141e30',
        accent: '#00ffff',
        long: '#10b981',
        short: '#ef4444',
        neutral: '#facc15',
      },
    },
  },
  plugins: [],
}
EOT

# postcss.config.js
cat <<EOT > postcss.config.js
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOT

# Vite config
cat <<EOT > vite.config.js
import { defineConfig } from 'vite'

export default defineConfig({
  root: './frontend',
  server: {
    port: 5173,
    open: true,
  }
})
EOT

# HTML template voor test
cat <<EOT > frontend/html/index.html
<!DOCTYPE html>
<html lang="nl">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Vite + Tailwind Test</title>
  <link href="/css/input.css" rel="stylesheet">
</head>
<body class="bg-background text-white font-sans p-8">
  <h1 class="text-4xl font-bold text-accent mb-4">✅ Vite werkt!</h1>
  <p class="text-slate-300">Deze pagina draait op Vite met Tailwind CSS.</p>
</body>
</html>
EOT

# package.json scripts
node -e "let pkg=require('./package.json'); pkg.scripts = pkg.scripts || {}; pkg.scripts['dev']='vite'; require('fs').writeFileSync('package.json', JSON.stringify(pkg, null, 2));"

echo "✅ Vite setup compleet! Start nu je dev server met:"
echo "npm run dev"
