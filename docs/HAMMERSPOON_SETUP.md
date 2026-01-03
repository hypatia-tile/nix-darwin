# Hammerspoon Setup & Keybindings

## Overview

Hammerspoon is installed via Homebrew and configured via nix-darwin home-manager.

**Configuration file**: Managed by Nix at `nix/home/base.nix` → `~/.hammerspoon/init.lua`

---

## Installation

Hammerspoon is automatically installed via nix-darwin:

```nix
# In nix/darwin/macos.nix
homebrew.casks = [
  "hammerspoon"
];
```

---

## Keybindings

### Kitty Terminal

| Key | Action |
|-----|--------|
| `Cmd+Alt+K` | Launch or focus Kitty terminal |

### Window Management

| Key | Action |
|-----|--------|
| `Cmd+Alt+Left` | Move window to left half of screen |
| `Cmd+Alt+Right` | Move window to right half of screen |
| `Cmd+Alt+Up` | Move window to top half of screen |
| `Cmd+Alt+Down` | Move window to bottom half of screen |
| `Cmd+Alt+M` | Maximize window |
| `Cmd+Alt+C` | Center window on screen |

### Display Management (Multi-monitor)

| Key | Action |
|-----|--------|
| `Cmd+Alt+Ctrl+Right` | Move window to next display |
| `Cmd+Alt+Ctrl+Left` | Move window to previous display |

### Hammerspoon Control

| Key | Action |
|-----|--------|
| `Cmd+Alt+R` | Reload Hammerspoon configuration |
| `Cmd+Alt+Ctrl+/` | Show all active hotkeys |

---

## Usage Examples

### Example 1: Quick Kitty Access

```
1. Press Cmd+Alt+K from anywhere
2. Kitty launches (if not running) or comes to focus
```

### Example 2: Split Screen Workflow

```
1. Focus Kitty (Cmd+Alt+K)
2. Move to left half (Cmd+Alt+Left)
3. Focus browser (Cmd+Tab)
4. Move to right half (Cmd+Alt+Right)

Result: Kitty on left, browser on right
```

### Example 3: Multi-Display Setup

```
1. Focus window you want to move
2. Press Cmd+Alt+Ctrl+Right
3. Window moves to next monitor
```

---

## Configuration

### Location

- **Source**: `nix/home/base.nix` (managed by Nix)
- **Generated**: `~/.hammerspoon/init.lua` (auto-created on rebuild)

### Customization

Edit `nix/home/base.nix` to customize:

```nix
home.file.".hammerspoon/init.lua".text = ''
  -- Your custom Hammerspoon configuration here

  -- Example: Change Kitty hotkey to Cmd+Alt+T
  hs.hotkey.bind({"cmd", "alt"}, "T", function()
    local kitty = hs.application.find("kitty")
    if kitty then
      kitty:activate()
    else
      hs.application.open("kitty")
    end
  end)
'';
```

Then rebuild:
```bash
darwin-rebuild switch
```

And reload Hammerspoon:
```bash
# Press Cmd+Alt+R
# Or: Open Hammerspoon → Reload Config
```

---

## Common Customizations

### Add Application Shortcuts

```lua
-- Launch Safari with Cmd+Alt+S
hs.hotkey.bind({"cmd", "alt"}, "S", function()
  hs.application.launchOrFocus("Safari")
end)

-- Launch VS Code with Cmd+Alt+V
hs.hotkey.bind({"cmd", "alt"}, "V", function()
  hs.application.launchOrFocus("Visual Studio Code")
end)
```

### Custom Window Sizes

```lua
-- Move window to left 2/3
hs.hotkey.bind({"cmd", "alt", "shift"}, "Left", function()
  local win = hs.window.focusedWindow()
  if win then
    win:moveToUnit(hs.geometry.rect(0, 0, 0.67, 1))
  end
end)

-- Move window to right 1/3
hs.hotkey.bind({"cmd", "alt", "shift"}, "Right", function()
  local win = hs.window.focusedWindow()
  if win then
    win:moveToUnit(hs.geometry.rect(0.67, 0, 0.33, 1))
  end
end)
```

### Quarter Screen Layouts

```lua
-- Top-left quarter
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "1", function()
  local win = hs.window.focusedWindow()
  if win then
    win:moveToUnit(hs.geometry.rect(0, 0, 0.5, 0.5))
  end
end)

-- Top-right quarter
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "2", function()
  local win = hs.window.focusedWindow()
  if win then
    win:moveToUnit(hs.geometry.rect(0.5, 0, 0.5, 0.5))
  end
end)

-- Bottom-left quarter
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "3", function()
  local win = hs.window.focusedWindow()
  if win then
    win:moveToUnit(hs.geometry.rect(0, 0.5, 0.5, 0.5))
  end
end)

-- Bottom-right quarter
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "4", function()
  local win = hs.window.focusedWindow()
  if win then
    win:moveToUnit(hs.geometry.rect(0.5, 0.5, 0.5, 0.5))
  end
end)
```

---

## First-Time Setup

### After Installation

1. **Install**: Run `darwin-rebuild switch`
2. **Open Hammerspoon**:
   - Spotlight (`Cmd+Space`) → "Hammerspoon"
   - Or: `/Applications/Hammerspoon.app`
3. **Grant Accessibility Permission**:
   - Hammerspoon will prompt for Accessibility access
   - System Settings → Privacy & Security → Accessibility
   - Enable "Hammerspoon"
4. **Verify**: You should see "Hammerspoon config loaded" alert
5. **Test**: Press `Cmd+Alt+K` to launch Kitty

---

## Troubleshooting

### Hotkeys Not Working

**Check 1**: Accessibility permissions
```
System Settings → Privacy & Security → Accessibility → Hammerspoon ✓
```

**Check 2**: Hammerspoon is running
```
# Look for Hammerspoon icon in menu bar
# Or launch from Applications
```

**Check 3**: Configuration loaded
```
# Press Cmd+Alt+R to reload
# Should see "Hammerspoon config loaded" alert
```

### Configuration Not Applied

```bash
# Rebuild to regenerate ~/.hammerspoon/init.lua
darwin-rebuild switch

# Reload Hammerspoon
# Press Cmd+Alt+R
```

### View Current Configuration

```bash
cat ~/.hammerspoon/init.lua
```

### Check Hammerspoon Console

```
# Open Hammerspoon
# Menu bar icon → Console

# Shows errors and debug messages
```

---

## Advanced Features

### Window Filters

Filter windows by application:

```lua
-- Only resize Kitty windows
hs.hotkey.bind({"cmd", "alt"}, "Left", function()
  local win = hs.window.focusedWindow()
  if win and win:application():name() == "kitty" then
    win:moveToUnit(hs.geometry.rect(0, 0, 0.5, 1))
  end
end)
```

### Automatic Window Positioning

Position Kitty automatically on launch:

```lua
local kittyFilter = hs.window.filter.new("kitty")

kittyFilter:subscribe(hs.window.filter.windowCreated, function(window)
  -- Move Kitty to right half on launch
  window:moveToUnit(hs.geometry.rect(0.5, 0, 0.5, 1))
end)
```

### Chained Actions

Execute multiple actions:

```lua
-- Launch Kitty and position it
hs.hotkey.bind({"cmd", "alt"}, "K", function()
  local kitty = hs.application.find("kitty")
  if kitty then
    kitty:activate()
    local win = kitty:focusedWindow()
    if win then
      win:moveToUnit(hs.geometry.rect(0.5, 0, 0.5, 1))
    end
  else
    hs.application.open("kitty")
    -- Wait for it to open, then position
    hs.timer.doAfter(0.5, function()
      local kitty = hs.application.find("kitty")
      if kitty then
        local win = kitty:focusedWindow()
        if win then
          win:moveToUnit(hs.geometry.rect(0.5, 0, 0.5, 1))
        end
      end
    end)
  end
end)
```

---

## Useful Resources

- [Hammerspoon Official Docs](https://www.hammerspoon.org/docs/)
- [Hammerspoon API Reference](https://www.hammerspoon.org/docs/index.html)
- [Hammerspoon Getting Started](https://www.hammerspoon.org/go/)
- [Sample Configurations](https://github.com/Hammerspoon/hammerspoon/wiki/Sample-Configurations)

---

## Summary

**Installation**: Via Homebrew cask (managed by Nix)

**Configuration**: Via home-manager (`nix/home/base.nix`)

**Reload**: `Cmd+Alt+R`

**Show hotkeys**: `Cmd+Alt+Ctrl+/`

**Launch Kitty**: `Cmd+Alt+K`

**Window management**: `Cmd+Alt+Arrow keys`

---

*Hammerspoon configuration managed by nix-darwin*
