#!/bin/bash
set -e
set -x

# 1. Verwijder alle lockfiles (package-lock.json, yarn.lock, etc.)
find . -name "package-lock.json" -type f -delete
find . -name "yarn.lock" -type f -delete
find . -name "pnpm-lock.yaml" -type f -delete

# 2. Zorg ervoor dat je de nieuwste wijzigingen van de remote haalt
git fetch origin

# 3. Reset lokale bestanden naar de laatste commit
git reset --hard origin/main

# 4. Voeg alle wijzigingen toe (inclusief verwijderde lockfiles)
git add -A

# 5. Forceer een commit met een standaardbericht
git commit -m "Force sync: verwijder lockfiles en update naar nieuwste versie" || echo "Niets om te committen"

# 6. Forceer een push naar de remote repository en log de uitvoer
echo "Pushen naar GitHub..."
PUSH_LOG=$(git push origin main --force 2>&1)

# 7. Controleer of de push succesvol was
if [[ "$PUSH_LOG" == *"Everything up-to-date"* ]]; then
  echo "De repository was al up-to-date. Geen wijzigingen gepusht."
else
  echo "Push uitgevoerd. Log:"
  echo "$PUSH_LOG"
fi

# 8. Klaar
echo "De lokale repository is gesynchroniseerd met GitHub."