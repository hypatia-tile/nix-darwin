# TODO: Configuration Improvements

This document tracks issues identified in the nix-darwin configuration audit (2026-01-02) and fixes to align with Architecture Decision Records (ADRs 0001-0004).

## Status Legend
- [ ] Not started
- [x] Completed
- [~] In progress
- [!] Blocked

---

## CRITICAL Priority

### [x] 5.1: Fix Missing Git Commit Template
**File**: `nix/home/programs.nix:113`
**Issue**: Git configuration references non-existent template file
**Impact**: Git commits may fail or show warnings
**Fix**: Create template file or remove reference

**Resolution**:
- Create `xdg.configFile."git/commit_template.txt"` in programs.nix
- Add standard commit message template

---

## HIGH Priority

### [x] 4.1: Extract Hardcoded Username (DRY Violation)
**Files**:
- `nix/home/base.nix:2,3,6`
- `nix/darwin/users.nix:6,7,8`
- `nix/darwin/default.nix:9`
- `nix/darwin/macos.nix:6`

**Issue**: Username "kazukishinohara" hardcoded in 9+ locations
**Impact**: Changes require updating multiple files, error-prone
**Fix**: Create shared configuration file

**Resolution**:
- Create `nix/common.nix` with username and homeDirectory
- Update all files to reference common config
- Use string interpolation for paths

### [x] 3.1: Add Missing nixpkgs Parameter
**File**: `flake.nix:24-41`, `nix/darwin/default.nix`
**Issue**: nixpkgs input not passed to darwin configuration
**Impact**: Could cause issues with overlays or package references
**Fix**: Pass nixpkgs through flake outputs

**Resolution**:
- Add `nixpkgs` to inherit list in flake.nix
- Update darwin/default.nix to accept nixpkgs parameter

---

## MEDIUM Priority

### [x] 2.1: Clarify Zsh Configuration Split
**Files**: `nix/darwin/users.nix:4,9`, `nix/home/programs.nix:116-159`
**Issue**: Zsh configured in both darwin and home-manager
**Impact**: Potential confusion about which layer controls zsh
**Fix**: Add clarifying comments

**Resolution**:
- Document that darwin enables zsh system-wide (required)
- Document that home-manager configures user zsh settings
- Remove redundant `shell = pkgs.zsh` from users.nix

### [x] 2.2: Consolidate home.packages Declarations
**Files**: `nix/home/packages.nix`, `nix/home/tex.nix`
**Issue**: Multiple files declare home.packages
**Impact**: Violates single responsibility principle
**Fix**: Move all packages to packages.nix

**Resolution**:
- Move TeX packages to packages.nix
- Remove tex.nix or repurpose for TeX-specific config only
- Update imports in home/default.nix

### [x] 3.3: Remove or Fix Unused specialArgs
**File**: `flake.nix:49`
**Issue**: specialArgs defined at wrong level and unused
**Impact**: Dead code, confusion
**Fix**: Remove or move to correct location

**Resolution**:
- Remove from flake.nix outputs level
- If needed, add to darwinSystem in darwin/default.nix

### [x] 4.4: Document allowUnfree Requirement
**File**: `nix/darwin/nix.nix:12`
**Issue**: No explanation for why unfree packages allowed
**Impact**: Unclear why security policy relaxed
**Fix**: Add comment explaining which packages require unfree

**Resolution**:
- Add comment listing unfree packages (VS Code, fonts, etc.)

### [x] 4.7: Split Large programs.nix Module
**File**: `nix/home/programs.nix` (165 lines)
**Issue**: Exceeds 150-line guideline, configures 5+ programs
**Impact**: Harder to navigate and maintain
**Fix**: Split into separate files per program

**Resolution**:
- Create `nix/home/programs/` directory
- Split into: direnv.nix, tmux.nix, alacritty.nix, git.nix, zsh.nix
- Update imports in home/default.nix

### [x] 5.2: Enable or Document macOS Preferences
**File**: `nix/darwin/macos.nix:24-37`
**Issue**: Most settings commented out without explanation
**Impact**: Incomplete configuration
**Fix**: Enable desired settings or document why disabled

**Resolution**:
- Add comment explaining macOS settings are managed manually
- Or uncomment and enable desired settings

### [x] 7.2: Explain nix.enable = false Setting
**File**: `nix/darwin/nix.nix:4-5`
**Issue**: "Determinate" reference unclear
**Impact**: Confusing for future maintainers
**Fix**: Add detailed explanation with link

**Resolution**:
- Explain Determinate Systems Nix installer
- Add link to documentation
- Clarify when this setting is needed

### [x] 7.3: Document Homebrew Package Justification
**File**: `nix/darwin/macos.nix:8-19`
**Issue**: No explanation why packages use homebrew vs nix
**Impact**: Unclear when to use homebrew (violates ADR 0002)
**Fix**: Add comments for each package

**Resolution**:
- Document why aquaskk requires homebrew
- Document why llvm/make/cmake use homebrew
- Reference ADR 0002 for future decisions

---

## LOW Priority

### [x] 1.1: Add Documentation to configuration.nix
**File**: `nix/darwin/configuration.nix:1`
**Issue**: Missing module purpose comment
**Impact**: Minor - unclear what file does
**Fix**: Add header and inline comments

### [x] 1.2: Fix Incomplete Comment in default.nix
**File**: `nix/darwin/default.nix:21`
**Issue**: Says "apply neovim" but applies neovim + rust
**Impact**: Minor - inaccurate comment
**Fix**: Update comment to mention both overlays

### [x] 3.2: Remove Commented-out Code
**File**: `flake.nix:35-47`
**Issue**: Commented code creates confusion
**Impact**: Minor - clutters file
**Fix**: Remove or move to documentation

### [x] 4.2: Document stateVersion
**File**: `nix/home/base.nix:4`
**Issue**: Missing date when stateVersion was set
**Impact**: Minor - harder to track version history
**Fix**: Add comment with date

### [x] 4.3: Add Explicit Parameters to macos.nix
**File**: `nix/darwin/macos.nix:1`
**Issue**: Only uses `{...}` instead of explicit params
**Impact**: Minor - less clear what's available
**Fix**: Add `{ pkgs, config, lib, ... }`

### [x] 4.5: Remove Commented Shell Configuration
**File**: `nix/home/programs.nix:164`
**Issue**: Dead code comment in wrong file
**Impact**: Minor - clutters file
**Fix**: Remove commented line

### [x] 4.6: Remove or Document Unused config Parameter
**File**: `nix/home/default.nix:1-5`
**Issue**: config parameter accepted but not used
**Impact**: Minor - unclear if intentional
**Fix**: Add comment or remove

### [x] 6.1: Fix Typo in macos.nix Comment
**File**: `nix/darwin/macos.nix:2`
**Issue**: "ocnfiguration" should be "configuration"
**Impact**: Minor - typo
**Fix**: Correct spelling

### [x] 6.2: Fix Typo in packages.nix Comment
**File**: `nix/home/packages.nix:25`
**Issue**: "Detets" should be "Detects"
**Impact**: Minor - typo
**Fix**: Correct spelling

### [x] 6.3: Fix Typo in programs.nix Comment
**File**: `nix/home/programs.nix:52`
**Issue**: "allactirry" should be "alacritty"
**Impact**: Minor - typo
**Fix**: Correct spelling

### [x] 6.4: Remove Orphaned Content Reference
**File**: `nix/home/programs.nix:53`
**Issue**: Contains `:contentReference[oaicite:0]{index=0}`
**Impact**: Minor - leftover AI artifact
**Fix**: Remove reference

### [x] 6.5: Standardize Comment Style
**Files**: Multiple
**Issue**: Inconsistent capitalization and punctuation
**Impact**: Minor - readability
**Fix**: Use sentence case with periods

### [x] 7.1: Add Module Purpose Comments
**Files**: `fonts.nix`, `users.nix`, `tex.nix`
**Issue**: Missing header comments
**Impact**: Minor - unclear module purpose
**Fix**: Add descriptive header comments

---

## Future Enhancements

### [ ] Consider Migration from Homebrew to Nix
**Issue**: Some packages use homebrew when nix equivalents may exist
**Impact**: Reduces reproducibility
**Investigation needed**:
- Check if llvm, make, cmake available in nixpkgs
- Check if aquaskk has nix alternative
- Document why homebrew is absolutely necessary

### [ ] Add Pre-commit Hooks
**Issue**: No automated checking of nix syntax
**Enhancement**: Add pre-commit hooks for:
- `nix flake check`
- `nixpkgs-fmt` or `alejandra` for formatting
- `deadnix` for unused code detection
- `statix` for linting

### [ ] Document Darwin-rebuild Workflow
**Issue**: No documentation for common operations
**Enhancement**: Add to README:
- How to apply changes (`darwin-rebuild switch`)
- How to test changes (`darwin-rebuild build`)
- How to update dependencies (`nix flake update`)
- Rollback procedure

### [ ] Add System Configuration Templates
**Issue**: No templates for common configurations
**Enhancement**: Create templates in `templates/` for:
- New user setup
- Development environment presets
- macOS system preference bundles

---

## Completion Tracking

- **Total Issues**: 23
- **Critical**: 1/1 completed (100%)
- **High**: 2/2 completed (100%)
- **Medium**: 7/7 completed (100%)
- **Low**: 13/13 completed (100%)
- **Future Enhancements**: 0/4 completed (0%)

---

## Notes

- All issues aligned with ADRs 0001-0004
- Audit completed: 2026-01-02
- Fixes applied: 2026-01-02
- Next review: Scheduled after next major flake update

## References

- [ADR 0001: Module Organization](docs/adr/0001-module-organization.md)
- [ADR 0002: Separation of Concerns](docs/adr/0002-separation-of-concerns.md)
- [ADR 0003: Dependency Management](docs/adr/0003-dependency-management.md)
- [ADR 0004: Configuration Patterns](docs/adr/0004-configuration-patterns.md)
- [Audit Report](docs/adr/AUDIT-2026-01-02.md) *(to be created)*
