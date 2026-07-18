# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles/config repository for zsh, bash, vim, Neovim, tmux, VS Code, git, iTerm2, and Windows Terminal, plus Python scripts that deploy those configs to a machine and bootstrap Neovim.

## Commands

```bash
# Deploy a config from the repo onto this machine (prompts before overwriting)
python move_configs.py -a <app> -m <machine>     # app: nvim, zsh, tmux, vim, code, gitconfig, iterm2, windows_terminal, all
                                                 # machine: unix, mac, wsl, windows

# Pull the local machine's config back INTO the repo (reverses copy direction)
python move_configs.py -a <app> -m <machine> -u

# Clone all pinned Neovim plugins into ~/.local/share/nvim/lazy/
python clone_nvim_extensions.py                  # skips plugins already present
python clone_nvim_extensions.py --overwrite "telescope.nvim; harpoon"   # re-clone specific plugins (semicolon-separated), or --overwrite true for all

# Clone treesitter grammar repos into ~/.local/share/nvim/treesitter/
python treesitter_install.py

# Python env / tooling (uv-managed; deps: ruff, gitpython, ipython, ty)
uv sync
ruff check .        # lint
ruff format .       # format
ty check            # type check
```

There are no tests. `setup.sh` is the from-scratch bootstrap for a fresh Debian/Ubuntu machine (apt packages, Neovim, lazygit, venvs, oh-my-zsh, uv) — it is run manually, not part of day-to-day work.

## Architecture

### Offline/pinned Neovim plugin model (the non-obvious part)

lazy.nvim is used **only as a plugin loader**, not as an installer. Plugins are never fetched by lazy.nvim itself; instead `clone_nvim_extensions.py` clones each plugin at a **pinned commit/tag** into `~/.local/share/nvim/lazy/<name>` (the `Extension` dataclass list is the source of truth for versions). Consequently, adding or upgrading a plugin requires touching multiple places:

1. `clone_nvim_extensions.py` — add/update the `Extension` entry (name, url, pinned `commit_id`). The `name` determines the folder name, which matters when it differs from the repo name (e.g. `catppuccin-nvim` for `catppuccin/nvim`).
2. `nvim/lua/plugins/init.lua` — the single lazy.nvim spec file for all plugins.
3. `nvim/lua/configs/<plugin>.lua` — per-plugin configuration.

`telescope-fzf-native.nvim` additionally requires `make` after cloning (the script handles this). The pinned treesitter is v0.10.0, which requires **Neovim 0.12**.

### Neovim config layout (`nvim/`)

`init.lua` loads in order: `options` → `mappings` (all keymaps live in `nvim/mappings.lua`) → `configs.lazy` (bootstraps lazy.nvim) → `ui`. `nvim/lua/overwrite/dap_repl.lua` is a patched copy of an nvim-dap internal file used to override plugin behavior. Snippets live in `nvim/lua/snippets/` (JSON, loaded via LuaSnip/friendly-snippets format).

### Config deployment (`move_configs.py`)

`move_configs()` maps each app to a repo path and a machine-specific destination path (e.g. `nvim/` → `~/.config/nvim/`, `dotfiles/zshrc` → `~/.zshrc`). The `-u/--update` flag swaps source and destination, which is how repo copies are kept in sync with live configs. When editing configs, prefer editing the repo copy and deploying, or edit live and pull back with `-u` — the repo is the canonical store.

### Other directories

- `dotfiles/` — shell/vim/git rc files deployed by `move_configs.py`.
- `code/mac/`, `code/windows/` — VS Code keybindings/settings/snippets per OS.
- `keyboard_maps/` — keyboard layout JSONs (not deployed by `move_configs.py`).
