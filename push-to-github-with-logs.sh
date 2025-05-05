#!/bin/bash
set -e

# Logbestand instellen
LOGFILE="push-log.txt"
echo "==> Start van het script: $(date)" > "$LOGFILE"

# 1. Controleer of Git is geïnitieerd
if [ ! -d ".git" ]; then
  echo "==> Initialiseren van een nieuwe Git-repository..." | tee -a "$LOGFILE"
  git init | tee -a "$LOGFILE"
fi

# 2. Stel de remote repository in als deze nog niet bestaat
REMOTE_URL=$(git remote get-url origin 2>/dev/null || echo "")

if [ -z "$REMOTE_URL" ]; then
  echo "==> Geen remote gevonden. Remote instellen op: git@github.com:MarcelCryptoAI/CRYPTO-AI-ANALYZER.git" | tee -a "$LOGFILE"
  git remote add origin git@github.com:MarcelCryptoAI/CRYPTO-AI-ANALYZER.git | tee -a "$LOGFILE"
fi

# 3. Verwijder lockfiles (optioneel)
echo "==> Verwijderen van lockfiles..." | tee -a "$LOGFILE"
find . -name "package-lock.json" -type f -delete | tee -a "$LOGFILE"
find . -name "yarn.lock" -type f -delete | tee -a "$LOGFILE"
find . -name "pnpm-lock.yaml" -type f -delete | tee -a "$LOGFILE"

# 4. Voeg alle bestanden toe en maak een commit
echo "==> Toevoegen van alle bestanden aan een commit..." | tee -a "$LOGFILE"
git add -A | tee -a "$LOGFILE"
git commit -m "Automatische synchronisatie met GitHub" || echo "==> Geen wijzigingen om te committen." | tee -a "$LOGFILE"

# 5. Push naar de remote repository
echo "==> Pushen naar de repository..." | tee -a "$LOGFILE"
git branch -M main | tee -a "$LOGFILE"
git push -u origin main --force | tee -a "$LOGFILE"

# 6. Klaar
echo "==> Klaar! Alles is succesvol gepusht naar de repository: git@github.com:MarcelCryptoAI/CRYPTO-AI-ANALYZER.git" | tee -a "$LOGFILE"
echo "==> Einde van het script: $(date)" >> "$LOGFILE"