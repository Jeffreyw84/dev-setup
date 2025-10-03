# Dotfiles 📁

Deze directory bevat al je persoonlijke configuratiebestanden (dotfiles) die automatisch geïnstalleerd worden op een nieuwe Mac.

## 📋 Wat wordt beheerd

- **`zshrc`** - zsh shell configuratie (Oh My Zsh, aliases, PATH, etc.)
- **`gitconfig`** - Git globale instellingen en aliases
- **`hosts-custom`** - Custom hosts entries (development domains)
- **`ssh/config`** - SSH client configuratie (geen keys!)
- **`vscode/settings.json`** - VS Code instellingen

## 🔄 Gebruik

### Backup maken (op huidige Mac)
```bash
# Backup alle huidige configuraties naar dotfiles/
./dotfiles/backup.sh

# Commit de wijzigingen
git add dotfiles/
git commit -m "Update dotfiles configuratie"
git push
```

### Installeren (op nieuwe Mac)  
```bash
# Installeer alle dotfiles (automatisch via setup.sh)
./dotfiles/install.sh
```

## ⚠️ Belangrijk

### Veiligheid
- **SSH keys worden NOOIT opgeslagen** (alleen config)
- **Wachtwoorden worden NOOIT opgeslagen**
- **Gevoelige data wordt uitgesloten**

### Backup
- Bestaande bestanden worden automatisch gebackupt naar `~/.dotfiles-backup-YYYYMMDD-HHMMSS/`
- Je kunt altijd terugdraaien door de backup terug te zetten

### Hosts file
- Alleen custom entries worden gemanaged
- System entries (localhost, etc.) blijven ongewijzigd
- Duplicaten worden automatisch vermeden

## 🛠️ Aanpassingen

### Nieuwe configuratie toevoegen
1. **Voeg bestand toe** aan `dotfiles/`
2. **Update `install.sh`** om het bestand te linken
3. **Update `backup.sh`** om het te backuppen
4. **Test** op development machine

### Gevoelige data
Nooit committen:
- SSH private keys
- Wachtwoorden  
- API keys
- Persoonlijke tokens

Gebruik in plaats daarvan:
- Omgevingsvariabelen
- Keychain
- Aparte (niet-gecommitte) bestanden

## 🔍 Troubleshooting

### Zsh configuratie laadt niet
```bash
source ~/.zshrc
# Of herstart terminal
```

### Hosts wijzigingen werken niet
```bash
# Flush DNS cache
sudo dscacheutil -flushcache
```

### SSH config problemen
```bash
# Check syntax
ssh -T git@github.com
```

### Permission problemen
```bash
# Fix SSH permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config
```