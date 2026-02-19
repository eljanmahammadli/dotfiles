#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$HOME/.dotfiles"

log() { printf "\n==> %s\n" "$1"; }

log "Installing base packages"
sudo apt update
sudo apt install -y git tmux curl ncurses-term

log "Linking tmux config"
mkdir -p "$REPO_DIR"
ln -sf "$REPO_DIR/tmux/linux.tmux.conf" "$HOME/.tmux.conf"

log "Installing tmux plugin manager (TPM)"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

log "Done."

