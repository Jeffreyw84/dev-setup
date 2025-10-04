#!/usr/bin/env bash
# check-completeness.sh — Check wat er nog mist in je dev-setup
set -euo pipefail

log() { echo "[check] $*"; }
warn() { echo "[WARN] $*"; }
good() { echo "[OK] $*"; }

log "=== Dev Setup Completeness Check ==="

# Check dotfiles
log "Checking dotfiles..."
MISSING_CONFIGS=()

[[ -f "$HOME/dev-setup/dotfiles/zshrc" ]] && good "zshrc" || MISSING_CONFIGS+=("zshrc")
[[ -f "$HOME/dev-setup/dotfiles/gitconfig" ]] && good "gitconfig" || MISSING_CONFIGS+=("gitconfig")  
[[ -f "$HOME/dev-setup/dotfiles/ssh/config" ]] && good "ssh/config" || MISSING_CONFIGS+=("ssh/config")
[[ -f "$HOME/dev-setup/dotfiles/hosts-custom" ]] && good "hosts-custom" || MISSING_CONFIGS+=("hosts-custom")
[[ -f "$HOME/dev-setup/dotfiles/config/aerospace/aerospace.toml" ]] && good "AeroSpace config" || MISSING_CONFIGS+=("aerospace.toml")
[[ -f "$HOME/dev-setup/dotfiles/config/kanata/config.kbd" ]] && good "Kanata config" || MISSING_CONFIGS+=("kanata config")
[[ -f "$HOME/dev-setup/dotfiles/vscode/settings.json" ]] && good "VS Code settings" || MISSING_CONFIGS+=("VS Code settings")

# Check optionele configuraties
[[ -f "$HOME/dev-setup/dotfiles/vimrc" ]] && good "vimrc" || warn "vimrc (optioneel)"
[[ -f "$HOME/dev-setup/dotfiles/ideavimrc" ]] && good "ideavimrc" || warn "ideavimrc (optioneel)"

# Check belangrijke directories
log "Checking project structure..."
[[ -d "$HOME/Documents/Projects" ]] && good "~/Documents/Projects directory" || warn "~/Documents/Projects directory missing"

# Check services die moeten draaien
log "Checking services..."
brew services list | grep postgresql@14 | grep started >/dev/null && good "PostgreSQL running" || warn "PostgreSQL not running"
brew services list | grep redis | grep started >/dev/null && good "Redis running" || warn "Redis not running"

# Check LaunchDaemon
[[ -f "/Library/LaunchDaemons/com.jeffrey.kanata.plist" ]] && good "Kanata LaunchDaemon" || warn "Kanata LaunchDaemon not installed"

# Check command line tools
log "Checking command availability..."
command -v aerospace >/dev/null && good "aerospace" || warn "aerospace command missing"
command -v kanata >/dev/null && good "kanata" || warn "kanata command missing"  
command -v code >/dev/null && good "code (VS Code CLI)" || warn "VS Code CLI missing"
command -v rubymine >/dev/null && good "rubymine CLI" || warn "RubyMine CLI missing"

# Summary
log "=== Summary ==="
if [[ ${#MISSING_CONFIGS[@]} -eq 0 ]]; then
    good "All essential dotfiles are present!"
else
    warn "Missing configurations: ${MISSING_CONFIGS[*]}"
    log "Run: ./dotfiles/backup.sh to backup current configs"
fi

log ""
log "To update all configurations:"
log "  ./dotfiles/backup.sh && git add dotfiles/ && git commit -m 'Update dotfiles' && git push"