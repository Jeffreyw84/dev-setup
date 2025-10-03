#!/usr/bin/env bash  
# dotfiles-backup.sh — Backup huidige configuraties naar dotfiles
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() { echo "[backup] $*"; }

log "=== Backup configuraties naar dotfiles ==="

# Backup zshrc
if [[ -f "$HOME/.zshrc" ]]; then
    cp "$HOME/.zshrc" "$DOTFILES_DIR/zshrc"
    log "Backed up: ~/.zshrc"
fi

# Backup gitconfig  
if [[ -f "$HOME/.gitconfig" ]]; then
    cp "$HOME/.gitconfig" "$DOTFILES_DIR/gitconfig"
    log "Backed up: ~/.gitconfig"
fi

# Backup SSH config (geen keys!)
if [[ -f "$HOME/.ssh/config" ]]; then
    mkdir -p "$DOTFILES_DIR/ssh"
    cp "$HOME/.ssh/config" "$DOTFILES_DIR/ssh/config"
    log "Backed up: ~/.ssh/config"
fi

# Backup custom hosts entries
log "Extracting custom hosts entries..."
grep -E "(\.local|custom|development)" /etc/hosts 2>/dev/null > "$DOTFILES_DIR/hosts-custom" || true

if [[ -s "$DOTFILES_DIR/hosts-custom" ]]; then
    log "Backed up: custom hosts entries"
else
    echo "# Custom hosts entries" > "$DOTFILES_DIR/hosts-custom"
    log "No custom hosts entries found"
fi

# Backup VS Code settings (als aanwezig)
VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"
if [[ -f "$VSCODE_SETTINGS" ]]; then
    mkdir -p "$DOTFILES_DIR/vscode"
    cp "$VSCODE_SETTINGS" "$DOTFILES_DIR/vscode/settings.json"
    log "Backed up: VS Code settings"
fi

log "=== Backup voltooid ==="
log "Vergeet niet te committen: git add dotfiles/ && git commit -m 'Update dotfiles'"