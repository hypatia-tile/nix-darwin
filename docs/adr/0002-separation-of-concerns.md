# ADR 0002: Separation of Concerns - Darwin vs Home-Manager

## Status

Accepted

## Context

Nix-darwin and home-manager both manage macOS configurations, but at different levels. Without clear boundaries, configuration can be duplicated, conflict, or be placed in the wrong layer. We need clear guidelines for what belongs in system-level configuration (darwin) versus user-level configuration (home-manager).

## Decision

We establish the following separation of concerns:

### System-Level (nix/darwin/) - Root Privileges Required

**Scope**: Configurations that require root privileges or affect all users on the system.

**Belongs in darwin:**
- User account creation and management (`users.nix`)
- System-wide fonts installation (`fonts.nix`)
- Nix daemon settings and build configuration (`nix.nix`)
- macOS system preferences (Dock, Finder, defaults) (`macos.nix`)
- System-wide services (requires `sudo`)
- Networking configuration
- Security settings (firewall, gatekeeper)

**Example** (`nix/darwin/users.nix`):
```nix
users.users.kazukishinohara = {
  name = "kazukishinohara";
  home = "/Users/kazukishinohara";
};
```

### User-Level (nix/home/) - No Root Required

**Scope**: Configurations specific to individual users, can be changed without `sudo`.

**Belongs in home-manager:**
- User-installed packages (`packages.nix`)
- Program configurations and dotfiles (`programs.nix`)
- Shell configuration (zsh, bash, tmux)
- Editor settings (vim, neovim)
- Development environments (TeX, programming languages) (`tex.nix`)
- User-specific environment variables
- Git configuration, SSH config
- Application preferences in `~/.config/`

**Example** (`nix/home/programs.nix`):
```nix
programs.git = {
  enable = true;
  userName = "Kazuki Shinohara";
  userEmail = "user@example.com";
};
```

### Decision Framework

When adding new configuration, ask:

1. **Does it require root privileges?**
   - Yes → darwin
   - No → home-manager

2. **Should it affect all users?**
   - Yes → darwin
   - No → home-manager

3. **Is it a system service or user service?**
   - System service → darwin
   - User service → home-manager

4. **Where does the configuration file live?**
   - `/etc/`, `/Library/`, system directories → darwin
   - `~/.config/`, `~/.*rc` → home-manager

### Gray Areas and Special Cases

**Fonts**:
- System-wide fonts → darwin (`fonts.nix`)
- User-specific fonts → home-manager
- **Decision**: Install commonly-used fonts in darwin for consistency

**Environment Variables**:
- System-wide (`/etc/zshrc`) → darwin
- User-specific (`~/.zshrc`) → home-manager
- **Decision**: Use home-manager unless it affects system services

**Homebrew**:
- System packages requiring root → darwin (via nix-darwin homebrew module)
- User CLI tools → home-manager (via nix packages)
- **Decision**: Migrate to nix packages when possible, use darwin homebrew sparingly

## Consequences

### Positive

- Clear mental model for where to add configuration
- Prevents duplicate configuration
- Minimizes `sudo` usage for day-to-day changes
- User configs are portable to other systems
- System configs establish baseline for all users

### Negative

- Some tools span both layers (requires coordination)
- Rebuild requires both `darwin-rebuild` and home-manager activation
- Need to understand nix-darwin and home-manager separately

### Validation

To verify correct separation:
- `nix/darwin/` changes should require `sudo darwin-rebuild switch`
- `nix/home/` changes should work without `sudo` after darwin rebuild
- User can switch home-manager configs independently

## References

- [nix-darwin documentation](https://github.com/LnL7/nix-darwin)
- [home-manager documentation](https://nix-community.github.io/home-manager/)
- Current implementation: `nix/darwin/default.nix:27-32` (home-manager integration)
