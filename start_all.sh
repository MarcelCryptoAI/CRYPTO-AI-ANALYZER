#!/bin/bash

echo "🚀 Start CryptoAnalyse Pro..."

# 🔥 Start frontend in nieuwe Terminal-tab
osascript <<EOF
tell application "Terminal"
    do script "cd \"$(pwd)/frontend\" && npm run dev"
end tell
EOF

# 🔥 Start backend in nieuwe Terminal-tab (virtualenv activeren)
osascript <<EOF
tell application "Terminal"
    do script "cd \"$(pwd)/backend\" && source venv/bin/activate && python3 main.py"
end tell
EOF

echo "✅ Beide services starten in aparte vensters..."
