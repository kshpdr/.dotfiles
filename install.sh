#!/usr/bin/env bash
# Symlink every dotfiles package into $HOME using GNU Stow.
#
# Usage:
#   ./install.sh            # stow every package in this repo
#   ./install.sh wezterm    # stow only the named package(s)
#
# Each top-level directory here is a "package" whose tree mirrors $HOME,
# e.g. wezterm/.wezterm.lua  ->  ~/.wezterm.lua
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

# Install GNU Stow if it's missing (macOS / Homebrew).
if ! command -v stow >/dev/null 2>&1; then
  if command -v brew >/dev/null 2>&1; then
    echo "stow not found — installing via Homebrew…"
    brew install stow
  else
    echo "error: GNU Stow is required and Homebrew is not available." >&2
    echo "Install stow manually, then re-run this script." >&2
    exit 1
  fi
fi

# Packages = explicit args, or every dir that isn't .git.
if [ "$#" -gt 0 ]; then
  packages=("$@")
else
  packages=()
  for d in */; do
    packages+=("${d%/}")
  done
fi

for pkg in "${packages[@]}"; do
  echo "stowing: $pkg"
  stow --target="$HOME" --restow "$pkg"
done

echo "done."
