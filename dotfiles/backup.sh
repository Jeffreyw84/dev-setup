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

# Backup AeroSpace configuratie
if [[ -f "$HOME/.config/aerospace/aerospace.toml" ]]; then
    mkdir -p "$DOTFILES_DIR/config/aerospace"
    cp "$HOME/.config/aerospace/aerospace.toml" "$DOTFILES_DIR/config/aerospace/"
    log "Backed up: AeroSpace config"
fi

# Backup Kanata configuratie
if [[ -d "$HOME/.config/kanata" ]]; then
    mkdir -p "$DOTFILES_DIR/config/kanata"
    cp -r "$HOME/.config/kanata/"* "$DOTFILES_DIR/config/kanata/" 2>/dev/null || true
    log "Backed up: Kanata keyboard config"
fi

# Backup vim configuraties
if [[ -f "$HOME/.vimrc" ]]; then
    cp "$HOME/.vimrc" "$DOTFILES_DIR/vimrc"
    log "Backed up: .vimrc"
fi

if [[ -f "$HOME/.ideavimrc" ]]; then
    cp "$HOME/.ideavimrc" "$DOTFILES_DIR/ideavimrc"
    log "Backed up: .ideavimrc (JetBrains vim)"
fi

# Backup zprofile (als aanwezig)
if [[ -f "$HOME/.zprofile" ]]; then
    cp "$HOME/.zprofile" "$DOTFILES_DIR/zprofile"
    log "Backed up: .zprofile"
fi

log "=== Backup voltooid ==="
log "Vergeet niet te committen: git add dotfiles/ && git commit -m 'Update dotfiles'"