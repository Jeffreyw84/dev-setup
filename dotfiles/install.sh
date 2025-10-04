#!/usr/bin/env bash
# dotfiles-install.sh — Installeer dotfiles en configuraties
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

log() { echo "[dotfiles] $*"; }

# Maak backup directory
mkdir -p "$BACKUP_DIR"
log "Backup directory: $BACKUP_DIR"

# Functie om bestand veilig te linken
link_dotfile() {
    local src="$1"
    local dest="$2"
    
    if [[ -e "$dest" || -L "$dest" ]]; then
        log "Backup: $dest -> $BACKUP_DIR/"
        mv "$dest" "$BACKUP_DIR/"
    fi
    
    ln -sf "$src" "$dest"
    log "Linked: $src -> $dest"
}

# Installeer zshrc
log "=== zsh configuratie ==="
if [[ -f "$DOTFILES_DIR/zshrc" ]]; then
    link_dotfile "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
else
    log "Geen zshrc gevonden in dotfiles"
fi

# Installeer custom hosts entries
log "=== hosts bestand ==="
if [[ -f "$DOTFILES_DIR/hosts-custom" ]] && [[ -s "$DOTFILES_DIR/hosts-custom" ]]; then
    log "Custom hosts entries gevonden..."
    
    # Check of entries al bestaan
    NEEDS_UPDATE=false
    while IFS= read -r line; do
        if [[ "$line" =~ ^[^#] ]] && ! grep -Fq "$line" /etc/hosts; then
            NEEDS_UPDATE=true
            break
        fi
    done < "$DOTFILES_DIR/hosts-custom"
    
    if [[ "$NEEDS_UPDATE" == "true" ]]; then
        log "Hosts update nodig - voeg custom entries toe..."
        echo "" | sudo tee -a /etc/hosts >/dev/null
        echo "# Custom entries from dotfiles ($(date))" | sudo tee -a /etc/hosts >/dev/null
        sudo tee -a /etc/hosts < "$DOTFILES_DIR/hosts-custom" >/dev/null
        log "Custom hosts entries toegevoegd"
    else
        log "Alle custom hosts entries zijn al aanwezig"
    fi
else
    log "Geen custom hosts entries gevonden"
fi

# Git configuratie
log "=== git configuratie ==="
if [[ -f "$DOTFILES_DIR/gitconfig" ]]; then
    link_dotfile "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
else
    log "Geen gitconfig gevonden - gebruik git-config.sh script"
fi

# SSH configuratie
log "=== ssh configuratie ==="
if [[ -d "$DOTFILES_DIR/ssh" ]]; then
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
    
    # Kopieer config bestanden (geen keys!)
    if [[ -f "$DOTFILES_DIR/ssh/config" ]]; then
        link_dotfile "$DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"
        chmod 600 "$HOME/.ssh/config"
    fi
else
    log "Geen ssh configuratie gevonden"
fi

# AeroSpace configuratie
log "=== aerospace configuratie ==="
if [[ -f "$DOTFILES_DIR/config/aerospace/aerospace.toml" ]]; then
    mkdir -p "$HOME/.config/aerospace"
    link_dotfile "$DOTFILES_DIR/config/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"
else
    log "Geen AeroSpace configuratie gevonden"
fi

# Kanata configuratie
log "=== kanata keyboard configuratie ==="
if [[ -d "$DOTFILES_DIR/config/kanata" ]]; then
    mkdir -p "$HOME/.config/kanata"
    # Kopieer alle kanata bestanden
    for file in "$DOTFILES_DIR/config/kanata/"*; do
        if [[ -f "$file" ]]; then
            filename=$(basename "$file")
            link_dotfile "$file" "$HOME/.config/kanata/$filename"
        fi
    done
    log "Kanata configuratie geïnstalleerd"
else
    log "Geen Kanata configuratie gevonden"
fi

# Vim configuraties
log "=== vim configuraties ==="
if [[ -f "$DOTFILES_DIR/vimrc" ]]; then
    link_dotfile "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"
fi

if [[ -f "$DOTFILES_DIR/ideavimrc" ]]; then
    link_dotfile "$DOTFILES_DIR/ideavimrc" "$HOME/.ideavimrc"
fi

# zprofile
if [[ -f "$DOTFILES_DIR/zprofile" ]]; then
    link_dotfile "$DOTFILES_DIR/zprofile" "$HOME/.zprofile"
fi

# VS Code settings
log "=== vs code configuratie ==="
if [[ -f "$DOTFILES_DIR/vscode/settings.json" ]]; then
    mkdir -p "$HOME/Library/Application Support/Code/User"
    link_dotfile "$DOTFILES_DIR/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
    log "VS Code settings geïnstalleerd"
fi

log "=== dotfiles installatie voltooid ==="
log "Herstart terminal of run: source ~/.zshrc"