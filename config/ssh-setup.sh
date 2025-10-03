#!/usr/bin/env bash
# ssh-setup.sh — SSH keys en GitHub configuratie
set -euo pipefail

echo "=== SSH Keys Setup ==="

SSH_DIR="$HOME/.ssh"
KEY_FILE="$SSH_DIR/id_ed25519"

# Maak .ssh directory aan als deze niet bestaat
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

if [[ -f "$KEY_FILE" ]]; then
    echo "SSH key bestaat al: $KEY_FILE"
else
    echo "Genereren nieuwe SSH key..."
    read -p "Email voor SSH key: " SSH_EMAIL
    ssh-keygen -t ed25519 -C "$SSH_EMAIL" -f "$KEY_FILE" -N ""
    echo "SSH key gegenereerd: $KEY_FILE"
fi

# Start ssh-agent en voeg key toe
eval "$(ssh-agent -s)"
ssh-add "$KEY_FILE"

# Toon publieke key
echo ""
echo "=== Publieke SSH Key (kopieer naar GitHub) ==="
cat "$KEY_FILE.pub"
echo ""
echo "Ga naar: https://github.com/settings/ssh/new"
echo "Plak bovenstaande key en geef het een naam zoals: 'MacBook Pro 2024'"
echo ""
read -p "Druk Enter nadat je de key hebt toegevoegd aan GitHub..."

# Test GitHub connectie
echo "Testen GitHub SSH verbinding..."
ssh -T git@github.com || true

echo "SSH setup voltooid!"