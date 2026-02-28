#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/eljanmahammadli/dotfiles.git"
REPO_DIR="$HOME/.dotfiles"

log() { printf "\n==> %s\n" "$1"; }

log "Installing base packages"
sudo apt update
sudo apt install -y git tmux curl ncurses-term

log "Cloning dotfiles"
if [ -d "$REPO_DIR/.git" ]; then
  git -C "$REPO_DIR" pull --ff-only
else
  rm -rf "$REPO_DIR"
  git clone "$REPO_URL" "$REPO_DIR"
fi

log "Linking tmux config"
ln -sf "$REPO_DIR/tmux/linux.tmux.conf" "$HOME/.tmux.conf"

log "Installing tmux plugin manager (TPM)"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

log "Installing tmux plugins"
~/.tmux/plugins/tpm/bin/install_plugins

log "Done. Start tmux with: tmux"
