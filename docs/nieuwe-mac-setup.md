# 🆕 Nieuwe Mac Setup - Complete Handleiding

Deze handleiding helpt je om een **gloednieuwe Mac** precies zo in te richten als je vorige machine.

## 📋 Voorbereiding (op oude Mac)

1. **Zorg dat je dev-setup up-to-date is:**
   ```bash
   cd ~/dev-setup
   git add .
   git commit -m "Update voor nieuwe Mac"
   git push
   ```

2. **Export huidige Homebrew status:**
   ```bash
   cd ~/dev-setup
   brew bundle dump --file=bootstrap/Brewfile --force
   git add . && git commit -m "Update Brewfile" && git push
   ```

## 🚀 Setup op nieuwe Mac

### Stap 1: Download dit project
```bash
# Clone via HTTPS (SSH werkt nog niet)
git clone https://github.com/Jeffreyw84/dev-setup.git ~/dev-setup
cd ~/dev-setup
```

### Stap 2: Dry-run (zie wat er gaat gebeuren)
```bash
./bootstrap/setup.sh
```
Dit toont wat er geïnstalleerd wordt **zonder** iets te doen.

### Stap 3: Echte installatie
```bash
DRY_RUN=false ./bootstrap/setup.sh
```

Dit installeert:
- ✅ **Homebrew** (als nog niet aanwezig)
- ✅ **Alle software** uit Brewfile
- ✅ **VS Code extensions**
- ✅ **Development tools** (Git, databases, etc.)
- ✅ **Terminal configuratie** (zsh, nvm, PATH)
- ✅ **Dotfiles** (zshrc, gitconfig, hosts, SSH config)
- ✅ **Git configuratie** (naam, email, aliases)
- ✅ **SSH keys** + GitHub setup
- ✅ **macOS instellingen** (Dock, Finder, Keyboard)

### Stap 4: Services starten
```bash
# Start databases
brew services start postgresql@14
brew services start redis

# Optioneel
brew services start mysql@8.4
brew services start mailhog
```

### Stap 5: Manual steps (eenmalig)

#### A) JetBrains Toolbox
```bash
# Installeer via website of:
brew install --cask jetbrains-toolbox

# Dan installeer RubyMine via Toolbox
```

#### B) VS Code instellingen sync
- Open VS Code
- Sign in met GitHub
- Settings Sync wordt automatisch geactiveerd

#### C) AeroSpace configuratie
```bash
# Je AeroSpace config staat waarschijnlijk in:
# ~/.aerospace.toml
# Kopieer van oude Mac of configureer opnieuw
```

#### D) Keyboard mapping (Kanata)
```bash
# Je Kanata config staat in:  
# ~/config/kanata/
# Kopieer configuratie van oude Mac
```

## ✅ Verificatie

Na de setup zou je moeten hebben:

- **Werkende workspace scripts:** `ws-open`, `ws-close`
- **Development databases:** PostgreSQL, Redis draaiend
- **Git configuratie:** Met jouw naam en email
- **SSH keys:** Geregistreerd bij GitHub
- **Alle tools:** Beschikbaar in terminal

Test met:
```bash
# Test workspace scripts
ws-open app=code dir=~/dev-setup

# Test git
git config --global user.name

# Test SSH
ssh -T git@github.com
```

## 🔧 Troubleshooting

### Homebrew PATH issues
```bash
echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### VS Code command line
```bash
# Open VS Code en gebruik: Cmd+Shift+P > "Shell Command: Install 'code' command"
```

### Database connection issues
```bash
brew services restart postgresql@14
brew services restart redis
```

## 🎯 Result

Na deze setup heb je **exact dezelfde development environment** als op je vorige Mac:
- Alle software geïnstalleerd ✅
- Workspace management werkend ✅  
- Development tools geconfigureerd ✅
- Persoonlijke instellingen toegepast ✅

**Tijd nodig:** ~30-60 minuten (afhankelijk van internetsnelheid)