#!/usr/bin/env bash
# Install third-party dependencies that the dotfiles expect but that we do NOT
# vendor into this repo (they're upstream git repos / packages of their own).
#
# Safe to re-run: every step is skipped if already present.
# Run this BEFORE ./install.sh on a fresh machine.
set -euo pipefail

ZSH_DIR="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH_DIR/custom}"

# --- oh-my-zsh ---------------------------------------------------------------
if [ ! -d "$ZSH_DIR" ]; then
  echo "installing oh-my-zsh…"
  # --unattended: no prompts, don't change the shell, don't launch zsh.
  # --keep-zshrc: don't overwrite ~/.zshrc (we stow our own).
  RUNZSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    "" --unattended --keep-zshrc
else
  echo "oh-my-zsh already installed — skipping."
fi

# --- custom plugins (referenced in zsh/.zshrc) -------------------------------
clone_plugin() {
  local name="$1" url="$2" dest="$ZSH_CUSTOM/plugins/$1"
  if [ ! -d "$dest" ]; then
    echo "installing plugin: $name"
    git clone --depth=1 "$url" "$dest"
  else
    echo "plugin $name already installed — skipping."
  fi
}

clone_plugin zsh-autosuggestions        https://github.com/zsh-users/zsh-autosuggestions
clone_plugin zsh-syntax-highlighting    https://github.com/zsh-users/zsh-syntax-highlighting
clone_plugin zsh-history-substring-search https://github.com/zsh-users/zsh-history-substring-search

# --- tmux: TPM (plugin manager referenced in tmux/.tmux.conf) ----------------
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  echo "installing tpm (tmux plugin manager)…"
  git clone --depth=1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
  echo "  note: start tmux and press <prefix> + I (Ctrl-Space, then Shift-i) to install plugins."
else
  echo "tpm already installed — skipping."
fi

echo "bootstrap done. Now run: ./install.sh"
