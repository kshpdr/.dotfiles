# .dotfiles

Personal configuration files, managed with [GNU Stow](https://www.gnu.org/software/stow/).

Each top-level directory is a **package** whose tree mirrors `$HOME`. Stowing a
package creates symlinks from `$HOME` into this repo, so edits here are live.

```
wezterm/.wezterm.lua  ->  ~/.wezterm.lua
```

## Install

```sh
git clone https://github.com/kshpdr/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh          # install third-party deps (oh-my-zsh + plugins) — run first
./install.sh            # stow everything (installs stow via Homebrew if needed)
./install.sh wezterm    # or just one package
```

`bootstrap.sh` installs things this repo deliberately does **not** vendor —
oh-my-zsh and its custom plugins are upstream git repos, not ours. It's
idempotent, so it's safe to re-run. Order matters: bootstrap, then stow
(bootstrap keeps any existing `.zshrc`; stow then symlinks ours over it).

## Packages

| Package   | What it configures                |
| --------- | --------------------------------- |
| `wezterm` | WezTerm terminal (`.wezterm.lua`) |
| `zsh`     | zsh + oh-my-zsh (`.zshrc`, `.zprofile`) |
| `git`     | git (`.gitconfig`, `~/.config/git/ignore`) |
| `tmux`    | tmux + TPM (`.tmux.conf`) |

## Adding a new config

1. Make a package dir mirroring its location under `$HOME`
   (e.g. `nvim/.config/nvim/init.lua` for `~/.config/nvim/init.lua`).
2. Move the real file in and run `./install.sh <package>` to symlink it back.
3. Commit.
