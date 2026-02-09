#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$HOME/.dotfiles"

log() { printf "\n==> %s\n" "$1"; }

log "Installing base packages"
sudo apt update
sudo apt install -y git tmux curl

log "Linking tmux config"
mkdir -p "$REPO_DIR"
ln -sf "$REPO_DIR/tmux/linux.tmux.conf" "$HOME/.tmux.conf"

log "Installing tmux plugin manager (TPM)"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

log "Enabling auto-tmux on SSH"
if ! grep -q "Auto-start tmux on SSH (dotfiles)" "$HOME/.bashrc"; then
  cat <<'EOF' >> "$HOME/.bashrc"

# Auto-start tmux on SSH (dotfiles)
if [ -n "$SSH_CONNECTION" ] && [ -z "$TMUX" ]; then
  tmux attach -t main || tmux new -s main
fi
EOF
fi

log "Done. Reconnect SSH to activate tmux."

