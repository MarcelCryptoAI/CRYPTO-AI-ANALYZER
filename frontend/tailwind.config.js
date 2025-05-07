// tailwind.config.js
module.exports = {
  content: [
    "./frontend/html/**/*.html",
    // voeg hier al je template-locaties toe
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', 'ui-sans-serif', 'system-ui'],
      },
      colors: {
        primary: '#0e1726',
        secondary: '#0f192a',
        accent: {
          cyan: '#2dd4bf',
          emerald: '#10b981',
          red:   '#ef4444',
        },
      }
    }
  },
  plugins: [],
}
