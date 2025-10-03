# Dev Setup

Een verzameling van scripts en configuraties voor het opzetten en beheren van een ontwikkelomgeving.

## Structuur

- `bin/` - Uitvoerbare scripts voor workspace management
- `bootstrap/` - Setup scripts en Brewfiles voor nieuwe machines
- `config/` - Configuratiebestanden
- `docs/` - Documentatie
- `profiles/` - Development profielen en CI/CD configuraties

## Scripts

### Workspace Management

- `ws-close` - Sluit alle vensters in een workspace (inclusief bijbehorende processen)
- `ws-open` - Opent een workspace
- `ws-open-chrome-tabs` - Opent Chrome tabs voor een workspace
- `workspace` - Hoofd workspace management script

### Bootstrap

- `bootstrap/setup.sh` - Setup script voor nieuwe machines
- `bootstrap/Brewfile` - Homebrew dependencies

## Gebruik

### Workspace sluiten
```bash
./bin/ws-close --workspace 1
```

### Bootstrap nieuwe machine
```bash
./bootstrap/setup.sh
```

## Requirements

- macOS
- [AeroSpace](https://github.com/nikitabobko/AeroSpace) window manager
- Homebrew (voor bootstrap)