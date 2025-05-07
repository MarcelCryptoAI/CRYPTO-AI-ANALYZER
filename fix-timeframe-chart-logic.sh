#!/bin/bash

echo "🧠 Injecteren van correcte tijdframe-logica in detail.html..."

TARGET="frontend/html/detail.html"
TMP_FILE="tmp_detail.html"

# Verwijder oude dubbele scripts indien aanwezig
sed '/document.querySelectorAll(\\".tf-tab\\")/d' "$TARGET" > "$TMP_FILE"

# Voeg na het TradingView-widget script de nieuwe correcte logica in
awk '
/<\/script>/ {
    print "  <script>";
    print "    document.querySelectorAll(\".tf-tab\").forEach(btn => {";
    print "      btn.addEventListener(\"click\", () => {";
    print "        document.querySelectorAll(\".tf-tab\").forEach(b => b.classList.remove(\"active-tab\", \"text-cyan-400\", \"border-cyan-400\"));";
    print "        btn.classList.add(\"active-tab\", \"text-cyan-400\", \"border-cyan-400\");";
    print "        const tf = btn.getAttribute(\"data-tf\");";
    print "        updateChart(tf);";
    print "      });";
    print "    });";
    print "";
    print "    function updateChart(tf) {";
    print "      document.getElementById(\"tradingview_chart\").innerHTML = \"\";";
    print "      new TradingView.widget({";
    print "        container_id: \"tradingview_chart\",";
    print "        width: \"100%\",";
    print "        height: 400,";
    print "        symbol: \"BYBIT:BTCUSDT.P\",";
    print "        interval: tf === \"5m\" ? 5 : tf === \"15m\" ? 15 : tf === \"1h\" ? 60 : tf === \"4h\" ? 240 : \"D\",";
    print "        timezone: \"Etc/UTC\",";
    print "        theme: \"dark\",";
    print "        style: \"1\",";
    print "        locale: \"nl\",";
    print "        toolbar_bg: \"#f1f3f6\",";
    print "        enable_publishing: false,";
    print "        hide_side_toolbar: false,";
    print "        allow_symbol_change: true,";
    print "        studies: []";
    print "      });";
    print "    }";
    print "  </script>";
}
{ print }
' "$TMP_FILE" > "$TARGET"

rm "$TMP_FILE"

echo "✅ Tijdframe-logica correct geïnjecteerd in: $TARGET"
