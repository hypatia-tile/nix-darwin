# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal macOS system configuration using [nix-darwin](https://github.com/LnL7/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager). It manages system-level settings (via darwin) and user-level packages/programs (via home-manager) declaratively. Application dotfiles (shell, editor, terminal configs) live in a separate `~/github/dotfiles` repo and are symlinked via `dot-link.sh`.

## Applying changes

```bash
# Apply all changes (system + home-manager)
sudo darwin-rebuild switch

# Build without applying (dry run)
darwin-rebuild build

# Update all flake inputs
nix flake update

# Update a single input
nix flake lock --update-input nixpkgs
```

## Architecture

```
flake.nix
  └─ nix/darwin/default.nix          # darwinSystem entry point + overlays
      ├─ nix/darwin/configuration.nix # aggregates darwin modules
      │   ├─ nix/darwin/nix.nix       # Nix daemon settings
      │   ├─ nix/darwin/users.nix     # user accounts
      │   ├─ nix/darwin/fonts.nix     # system fonts
      │   └─ nix/darwin/macos.nix     # macOS prefs + Homebrew packages
      └─ home-manager module
          └─ nix/home/default.nix     # aggregates home modules
              ├─ nix/home/base.nix    # XDG dirs, session vars, launchd agents
              ├─ nix/home/packages.nix # user CLI packages (~68 packages)
              └─ nix/home/programs.nix # direnv + home-manager self-management
```

`nix/common.nix` holds shared values (username, hostname, git info) used across modules. It is git-tracked but excluded from commits via `git update-index --skip-worktree`.

## Darwin vs. home-manager split

| Layer | Scope | Examples |
|---|---|---|
| `nix/darwin/` | System-wide, requires sudo | System fonts, Nix daemon config, macOS defaults, Homebrew casks |
| `nix/home/` | User-level, no sudo | CLI tools, LSPs, language runtimes, dev packages |

Prefer adding packages to home-manager. Use Homebrew (via `macos.nix`) only for macOS-native apps or packages unavailable in nixpkgs. Most packages come from `nixpkgs-unstable`.

## Overlays

Two overlays are applied in `nix/darwin/default.nix`:
- `neovim-nightly-overlay` — provides bleeding-edge Neovim builds
- `rust-overlay` — provides pinned Rust toolchain versions

## Module pattern

```nix
{ pkgs, config, lib, ... }:
let
  userConfig = import ../common.nix;
in {
  imports = [ ./submodule.nix ];
  # settings grouped by domain
}
```

## Personal config setup

```bash
cp nix/common.nix.template nix/common.nix
# edit with your username, hostname, git info
git update-index --skip-worktree nix/common.nix
```

## Nix formatting / linting

```bash
alejandra .          # format all .nix files
statix check .       # lint for anti-patterns
deadnix .            # find unused bindings
nil                  # LSP for editor integration
```
