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
git commit -m "Force sync: verwijder lockfiles en update naar nieuwste versie"

# 6. Forceer een push naar de remote repository
git push origin main --force

# 7. Klaar
echo "De lokale versie is nu gesynchroniseerd met de nieuwste versie."
echo "Alle lockfiles zijn verwijderd en wijzigingen zijn gepusht naar de remote repository."