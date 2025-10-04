#!/usr/bin/env bash
# kanata-setup.sh — Installeer Kanata LaunchDaemon voor keyboard remapping
set -euo pipefail

log() { echo "[kanata] $*"; }

KANATA_CONFIG="$HOME/.config/kanata/config.kbd"
PLIST_FILE="/Library/LaunchDaemons/com.jeffrey.kanata.plist"
KANATA_BIN="/opt/homebrew/bin/kanata"

log "=== Kanata LaunchDaemon Setup ==="

# Check of Kanata geïnstalleerd is
if [[ ! -x "$KANATA_BIN" ]]; then
    log "Error: Kanata niet gevonden op $KANATA_BIN"
    log "Installeer eerst: brew install kanata"
    exit 1
fi

# Check of configuratie bestaat
if [[ ! -f "$KANATA_CONFIG" ]]; then
    log "Error: Kanata config niet gevonden: $KANATA_CONFIG"
    log "Kopieer je configuratie naar ~/.config/kanata/config.kbd"
    exit 1
fi

# Maak LaunchDaemon plist
log "Creating LaunchDaemon plist..."
sudo tee "$PLIST_FILE" > /dev/null <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.jeffrey.kanata</string>
    <key>ProgramArguments</key>
    <array>
        <string>$KANATA_BIN</string>
        <string>--cfg</string>
        <string>$KANATA_CONFIG</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardErrorPath</key>
    <string>/tmp/kanata.err</string>
    <key>StandardOutPath</key>
    <string>/tmp/kanata.out</string>
</dict>
</plist>
EOF

# Set juiste permissions
sudo chmod 644 "$PLIST_FILE"
sudo chown root:wheel "$PLIST_FILE"

# Stop bestaande service (als draait)
log "Stopping existing Kanata service..."
sudo launchctl bootout system "$PLIST_FILE" 2>/dev/null || true

# Start nieuwe service
log "Starting Kanata service..."
sudo launchctl bootstrap system "$PLIST_FILE"
sudo launchctl enable system/com.jeffrey.kanata

log "Kanata LaunchDaemon geïnstalleerd en gestart!"
log ""
log "Handige commands:"
log "  sudo launchctl kickstart system/com.jeffrey.kanata  # herstart service"
log "  sudo launchctl bootout system $PLIST_FILE           # stop service"  
log "  tail -f /tmp/kanata.out                              # bekijk logs"
log ""
log "Na wijzigingen aan ~/.config/kanata/config.kbd:"
log "  sudo launchctl kickstart -k system/com.jeffrey.kanata"