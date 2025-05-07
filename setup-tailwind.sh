#!/bin/bash

echo "🔧 Initialiseren van Tailwind + PostCSS omgeving..."

# Init npm en install dependencies
npm init -y
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

# Tailwind config
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

# PostCSS config
cat <<EOT > postcss.config.js
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOT

# Input Tailwind bestand
mkdir -p frontend/css
cat <<EOT > frontend/css/input.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOT

# Output CSS aanmaken
npx tailwindcss -i ./frontend/css/input.css -o ./frontend/css/output.css --minify

# Script toevoegen aan package.json
node -e "let pkg=require('./package.json'); pkg.scripts = pkg.scripts || {}; pkg.scripts['build:css']='npx tailwindcss -i ./frontend/css/input.css -o ./frontend/css/output.css --minify'; require('fs').writeFileSync('package.json', JSON.stringify(pkg, null, 2));"

echo "✅ Setup compleet. Voeg deze regel toe aan je HTML-bestanden:"
echo '<link rel="stylesheet" href="../css/output.css">'
