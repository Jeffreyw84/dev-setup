#!/usr/bin/env bash
# setup.sh — bootstrap met DRY_RUN support
set -euo pipefail

DRY_RUN="${DRY_RUN:-true}"  # zet op "false" om echt te installeren later
BREWFILE="$HOME/dev-setup/bootstrap/Brewfile"

log()  { printf '%s\n' "$*"; }
run()  { if [[ "$DRY_RUN" == "true" ]]; then log "[DRY] $*"; else eval "$*"; fi; }
need() { command -v "$1" >/dev/null 2>&1; }

log "== dev-setup bootstrap (DRY_RUN=$DRY_RUN) =="

# 1) Brew aanwezig?
if need brew; then
  log "brew: OK ($(brew --version | head -n1))"
else
  log "brew: NIET gevonden. In echte run installeer ik Homebrew."
  log "cmd: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
fi

# 2) Brewfile check
if [[ -f "$BREWFILE" ]]; then
  log "Brewfile: OK ($BREWFILE)"
  log "-> Validatie zonder install:"
  run "brew bundle check --file=\"$BREWFILE\" --verbose || true"
else
  log "Brewfile: MISS ($BREWFILE)"
fi

# 3) PATH naar dev-setup/bin
if ! grep -q 'dev-setup/bin' "$HOME/.zshrc" 2>/dev/null; then
  log "PATH: dev-setup/bin nog niet in ~/.zshrc"
  run "echo 'export PATH=\"\$HOME/dev-setup/bin:\$PATH\"' >> ~/.zshrc"
else
  log "PATH: dev-setup/bin staat al in ~/.zshrc"
fi

# 4) NVM snippet (alleen check)
if ! grep -q 'NVM_DIR' "$HOME/.zshrc" 2>/dev/null; then
  log "nvm: snippet ontbreekt in ~/.zshrc (voeg ik toe in echte run)"
  run "cat >> ~/.zshrc <<'EOT'
# nvm
export NVM_DIR=\"\$HOME/.nvm\"
[ -s \"/opt/homebrew/opt/nvm/nvm.sh\" ] && . \"/opt/homebrew/opt/nvm/nvm.sh\"
[ -s \"/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm\" ] && . \"/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm\"
EOT"
else
  log "nvm: snippet aanwezig"
fi

# 5) Services (alleen tonen wat ik later zou doen)
log "Services die ik later kan starten (indien geïnstalleerd):"
log " - postgresql@14, redis, (optioneel mysql@8.4, mailhog)"
run "echo 'brew services start postgresql@14 || true'"
run "echo 'brew services start redis || true'"

# 6) Git configuratie
if [[ "$DRY_RUN" == "false" ]]; then
  log "Git configuratie..."
  run "$HOME/dev-setup/config/git-config.sh"
fi

# 7) SSH keys setup
if [[ "$DRY_RUN" == "false" ]]; then
  log "SSH configuratie..."
  run "$HOME/dev-setup/config/ssh-setup.sh"
fi

# 8) Dotfiles installatie
if [[ "$DRY_RUN" == "false" ]]; then
  log "Dotfiles installeren..."
  run "$HOME/dev-setup/dotfiles/install.sh"
else
  log "Dotfiles: zou ~/.zshrc, hosts, git config installeren"
fi

# 9) macOS defaults
if [[ "$DRY_RUN" == "false" ]]; then
  log "macOS instellingen..."
  run "bash $HOME/dev-setup/config/macos-defaults.sh"
fi

log "== klaar (dry-run=$DRY_RUN) =="
if [[ "$DRY_RUN" == "true" ]]; then
  log ""
  log "🚀 Om echt te installeren: DRY_RUN=false ./bootstrap/setup.sh"
fi
