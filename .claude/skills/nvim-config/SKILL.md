---
name: nvim-config
description: >
  Use whenever changing this repo's Neovim setup: editing
  nvim/lua/mappings.lua, nvim/lua/options.lua, nvim/lua/ui.lua,
  nvim/lua/splitterm.lua, nvim/lua/plugins/init.lua, any
  nvim/lua/configs/*.lua, nvim/lua/overwrite/*, or the plugin-pinning
  scripts clone_nvim_extensions.py / treesitter_install.py. Also use for
  any request to add, upgrade, remove, or reconfigure a Neovim plugin, add
  or change a keymap/option, or otherwise touch the nvim/ directory. Keeps
  changes consistent with the repo's offline/pinned plugin model, matches
  existing keymap/config conventions, avoids silently breaking existing
  behavior, and verifies changes before reporting done.
---

# Neovim Config Changes

This repo's Neovim config (`nvim/`) is deployed to real machines via
`move_configs.py` and its plugins are cloned at pinned commits by
`clone_nvim_extensions.py` — see the root `CLAUDE.md` "Architecture"
section for the full model. This skill is the checklist for actually
touching that config without breaking it or drifting from its conventions.

## 1. Adding, upgrading, or removing a plugin

Plugins are **never** fetched by lazy.nvim — it only loads what's already
cloned into `~/.local/share/nvim/lazy/<name>`. A plugin change touches
three places, in this order:

1. `clone_nvim_extensions.py` — add/update an `Extension(name=..., url=...,
   commit_id=...)` entry. `name` sets the clone folder name — set it
   explicitly when it differs from the repo name (e.g. `catppuccin-nvim`
   for `catppuccin/nvim`). To remove a plugin, prefer setting
   `disable=True` over deleting the entry outright unless the user
   confirms it should be gone entirely.
2. `nvim/lua/plugins/init.lua` — add/update the lazy.nvim spec. Note specs
   here use `dir = plugin_folder .. "<name>"` (pointing at the pinned
   clone), never a `"user/repo"` short form — that's the offline model,
   keep using it.
3. `nvim/lua/configs/<plugin>.lua` — the plugin's own config, wired up via
   `config = function() require("configs.<plugin>") end` in the spec.

Extra cases to remember:
- `telescope-fzf-native.nvim` needs `build = 'make'` in its spec (already
  present — keep it if you touch that entry).
- The pinned treesitter is v0.10.0, which requires **Neovim 0.12** — flag
  it if a treesitter/grammar bump would need a different nvim version.
- After step 1, the plugin isn't actually on disk until someone runs
  `clone_nvim_extensions.py`. Don't run it yourself unless the user asks —
  it writes into `~/.local/share/nvim/lazy/`, outside the repo. Say so
  when you report the change.

## 2. Keymaps and options — match existing conventions

`nvim/lua/mappings.lua` is the single home for keymaps (per CLAUDE.md).
Before adding one:

- **Check for collisions first.** Grep `nvim/lua/mappings.lua` and any
  relevant `nvim/lua/configs/*.lua` for the key you're about to bind. The
  file itself notes `:verbose map <mapping>` as the way to check this live
  — do the static equivalent by reading the source.
- Use `vim.keymap.set(mode, lhs, rhs, { desc = "..." })` with a `desc` —
  almost every existing mapping has one; keep that up.
- Group with a `-- Comment Header` above related mappings (see `-- Tabs`,
  `-- Buffer Commands`, etc.) and drop the new mapping under the matching
  group, or start a new group if none fits.
- `<leader>` mappings follow loose mnemonic prefixes already in use (`t` =
  tabs, `c` = copy path, `d` = diffview, `f` = format/file, `k` = window).
  Reuse an existing prefix family rather than inventing an unrelated one.
- Non-trivial logic (state tracking, toggles) belongs in
  `nvim/lua/configs/<plugin>.lua` and gets `require`'d at the top of
  `mappings.lua` (see the `nvimtree` require) — don't inline complex
  functions directly in `mappings.lua` if a config module already owns
  that plugin's behavior.
- `<A-...>` (Alt) is used deliberately in places to dodge terminal `<C-...>`
  conflicts (see the tab/pane mappings) — keep that pattern for anything
  that must also work inside `toggleterm`/`splitterm` floating terminals.

## 3. Don't silently break existing behavior

- Never remove, rebind, or repurpose an existing keymap/option as a side
  effect of an unrelated change — if a new mapping would have to replace
  one that already does something, call it out explicitly and confirm
  before changing it (rebinding muscle memory is a real regression here).
- If you're generalizing something written for one plugin (e.g. the
  `WinEnter` autocmd that clears `<C-l>` for floating windows), check
  `nvim/lua/splitterm.lua` and `nvim/lua/configs/toggleterm.lua` for
  related floating-window/terminal logic before changing shared behavior —
  this repo already unifies terminal and split floating-window patterns
  intentionally (see recent commit history).
- Keep edits to `nvim/lua/overwrite/dap_repl.lua` minimal and clearly
  scoped — it's a patched copy of an nvim-dap internal file, so unrelated
  cleanup there is more likely to fight future upstream syncs than help.

## 4. Verify before calling it done

Do both:

**Static check** — re-read your diff:
- Every new/changed `require(...)` resolves to a real module path.
- No duplicate or shadowed keymap was introduced (see §2).
- Plugin spec `dir` name matches the `Extension.name` folder exactly.
- `nvim/lua/plugins/init.lua` entries stay in the `dir = plugin_folder ..
  "<name>"` form — no accidental switch to lazy.nvim's normal
  auto-install syntax.

**Headless launch check** — this repo's `nvim/` directory is *named*
`nvim`, so pointing `XDG_CONFIG_HOME` at the repo root makes Neovim treat
it as a real config dir while still using the machine's already-cloned
plugins in `~/.local/share/nvim/lazy/` (data dir is untouched):

```bash
XDG_CONFIG_HOME=/Users/tundetaiwo/Documents/Misc/configs nvim --headless "+qa"
```

A clean exit with no output means `init.lua` (options → mappings →
splitterm → configs.lazy → ui) loaded without Lua errors. If you just
added a plugin whose entry hasn't been cloned yet, a "module not found" /
missing-dir error for *that plugin only* is expected — say so rather than
treating it as a bug; anything else surfacing is a real regression to fix.

## 5. Deployment awareness

The repo copy is canonical (per CLAUDE.md). `move_configs.py` copies
repo → machine, or with `-u` pulls machine → repo, and it prompts before
overwriting either way. Don't invoke `move_configs.py` (or
`clone_nvim_extensions.py`, `treesitter_install.py`) yourself unless the
user asks — they write outside the repo (`~/.config/nvim`,
`~/.local/share/nvim/...`). When you finish an edit, tell the user what to
run to deploy it rather than running it for them.
