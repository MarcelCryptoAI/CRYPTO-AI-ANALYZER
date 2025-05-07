module.exports = {
  content: ["./frontend/html/**/*.html", "./frontend/components/**/*.html", "./frontend/**/*.js"],
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
