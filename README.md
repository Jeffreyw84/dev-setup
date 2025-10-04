# Dev Setup 🚀

Een complete verzameling van scripts en configuraties voor het automatiseren van je macOS ontwikkelomgeving. Dit project helpt je bij het snel opzetten van nieuwe machines en het efficiënt beheren van development workspaces.

## 📋 Wat doet dit project?

Dit project biedt een geautomatiseerde manier om:
- **Workspaces beheren** met AeroSpace window manager
- **Development omgevingen** automatisch op te starten en af te sluiten
- **Nieuwe machines** snel in te richten met alle benodigde tools
- **Consistente development profielen** te onderhouden

## 🗂️ Project structuur

```
dev-setup/
├── bin/                    # Uitvoerbare workspace management scripts
│   ├── ws-close           # Sluit workspace + alle gerelateerde processen
│   ├── ws-open            # Open applicaties in specifieke workspace
│   ├── ws-open-chrome-tabs # Open Chrome tabs voor development
│   └── workspace          # Hoofd workspace orchestrator
├── bootstrap/             # Machine setup automatisering
│   ├── Brewfile          # Homebrew package definitie
│   ├── Brewlist          # Geïnstalleerde packages overzicht
│   └── setup.sh          # Automated setup script voor nieuwe machines
├── config/               # Configuratiebestanden
├── docs/                # Project documentatie
└── profiles/            # Development profielen
    ├── ci-cd-pipeline.yml
    └── develop.yml
```

## ⚡ Belangrijkste features

### 🏢 Intelligente Workspace Management
- **Automatisch applicaties starten** in de juiste workspace
- **Slimme proces cleanup** - sluit ook gerelateerde processen (bijv. Ruby servers van RubyMine)
- **Chrome tab management** voor development URLs
- **Multi-workspace ondersteuning** zonder interferentie

### 🛠️ Machine Bootstrap
- **One-command setup** voor nieuwe development machines
- **Dry-run modus** om te zien wat geïnstalleerd wordt
- **Homebrew integratie** met custom Brewfiles
- **Herbruikbare configuraties**

## 🚀 Snelle start

### Workspace beheer

```bash
# Sluit alle vensters in workspace 1 (inclusief gerelateerde processen)
./bin/ws-close --workspace 1 --force

# Open RubyMine met specifiek project
./bin/ws-open app=rubymine dir=/path/to/project

# Open development URLs in Chrome
./bin/ws-open-chrome-tabs workspace=2
```

### Nieuwe machine opzetten

```bash
# Dry run - zie wat er gebeurt zonder iets te installeren
DRY_RUN=true ./bootstrap/setup.sh

# Echte installatie
DRY_RUN=false ./bootstrap/setup.sh
```

## 🔧 Vereisten

- **macOS** (getest op macOS 14+)
- **[AeroSpace](https://github.com/nikitabobko/AeroSpace)** - Modern tiling window manager
- **Homebrew** - Package manager voor macOS
- **Bash 3.2+** (standaard op macOS)

## 💡 Handige tips

### Chrome Profiel Ondersteuning
Je kunt specifieke Chrome profielen afdwingen voor verschillende workspaces:

```yaml
windows:
  - id: web
    app: chrome
    url: "{{develop_url}}"
    profile: "Profile 1"  # Gebruik specifiek Chrome profiel
```

**Chrome profiel namen vinden:**
1. Open Chrome
2. Ga naar `chrome://settings/manageProfile`
3. De naam die je ziet is wat je gebruikt in de YAML (bijv. "Profile 1", "Work", "Personal")

**Alternatieve methode - gebruik profiel directory namen:**
```bash
ls ~/Library/Application\ Support/Google/Chrome/ | grep Profile
# Output: Profile 1, Profile 7, Profile 8, etc.
```

**Voorbeelden:**

```yaml
# Workspace met specifiek profiel
windows:
  - id: web
    app: chrome
    url: "{{develop_url}}"
    profile: "Profile 7"  # Voor work-gerelateerd development

# Workspace zonder profiel (gebruikt default)
windows:
  - id: web
    app: chrome  
    url: "{{develop_url}}"
    # Geen profile - gebruikt default Chrome profiel
```

**Voordelen van profielen:**
- Gescheiden cookies en sessies per project
- Verschillende extensies per omgeving
- Geen interferentie tussen development en productie accounts
- Per profiel verschillende bookmarks en browsing geschiedenis

### RubyMine Development
Het `ws-close` script is speciaal geoptimaliseerd voor RubyMine development:
- Sluit automatisch gerelateerde Ruby/Rails processen af
- Voorkomt zombie processen van development servers
- Sluit alleen processen van de specifieke RubyMine instantie

### Multiple Workspaces
Je kunt veilig meerdere development workspaces hebben:
- Workspace 1: Frontend project (met Chrome profiel "Work")
- Workspace 2: Backend project (met Chrome profiel "Development")
- Workspace 3: DevOps/Scripts (met Chrome profiel "Admin")
- etc.

Elk workspace behoudt zijn eigen processen en vensters.

## 🔍 Troubleshooting

### AeroSpace niet gevonden
```bash
# Installeer AeroSpace
brew install aerospace
```

### Scripts niet uitvoerbaar
```bash
# Maak scripts uitvoerbaar
chmod +x bin/*
chmod +x bootstrap/setup.sh
```

## 🤝 Contributing

Dit is een persoonlijk development setup project, maar voel je vrij om:
- Issues te melden
- Features voor te stellen  
- Fork te maken voor je eigen setup

## 📄 Licentie

MIT License - zie het project voor details.