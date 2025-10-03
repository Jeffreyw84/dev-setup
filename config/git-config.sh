#!/usr/bin/env bash
# git-config.sh — Git globale configuratie instellen
set -euo pipefail

echo "=== Git configuratie ==="

# Vraag gebruiker om gegevens
read -p "Git naam (bijv. 'John Doe'): " GIT_NAME
read -p "Git email (bijv. 'john@example.com'): " GIT_EMAIL

# Stel globale git config in
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

# Handige aliases en instellingen
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm commit
git config --global alias.lg "log --oneline --graph --decorate"

# Default branch en push gedrag
git config --global init.defaultBranch main
git config --global push.default simple

# Pull strategy
git config --global pull.rebase false

echo "Git configuratie voltooid!"
echo "Naam: $(git config --global user.name)"
echo "Email: $(git config --global user.email)"