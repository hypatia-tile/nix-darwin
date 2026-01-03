# Kitty Terminal - Basic Configuration

## Overview

This is a clean, minimal Kitty terminal configuration managed by nix-darwin.

**Philosophy**: Basic terminal functionality with Tokyo Night theme. Window management handled by Hammerspoon.

---

## Configuration Summary

### Theme
- **Tokyo Night** - Cool blue/purple color scheme
- Modern, popular, easy on the eyes

### Transparency
- **0.90 opacity** (10% transparent)
- Dynamic adjustment enabled (`Cmd+Shift+A` / `Cmd+Shift+D`)

### Font
- **JetBrainsMono Nerd Font** - 14pt (matches Alacritty)

### Essential Settings
- macOS font rendering optimized (`macos_thicken_font = 0.75`)
- Left Option key as Alt
- 10,000 line scrollback
- Audio bell disabled
- Bottom tab bar with powerline style

---

## Configuration File

All settings in: `nix/home/programs.nix`

```nix
kitty = {
  enable = true;
  font = {
    name = "JetBrainsMono Nerd Font";
    size = 14.0;
  };

  settings = {
    # Terminal
    term = "xterm-kitty";

    # Appearance
    window_padding_width = 8;
    background_opacity = 0.90;
    dynamic_background_opacity = true;

    # Behavior
    scrollback_lines = 10000;
    enable_audio_bell = false;

    # macOS
    macos_thicken_font = 0.75;
    macos_option_as_alt = "left";

    # Tokyo Night colors (16 colors)
    # ...
  };

  keybindings = {
    # Tab management only
    # Window management via Hammerspoon
  };
};
```

---

## Keybindings

### Tab Management
- `Cmd+1/2/3/4/5` - Go to tab 1-5
- `Cmd+t` - New tab
- `Cmd+w` - Close tab

### Clipboard
- `Cmd+c` - Copy
- `Cmd+v` - Paste

### Dynamic Opacity
- `Cmd+Shift+A` - Increase opacity (less transparent)
- `Cmd+Shift+D` - Decrease opacity (more transparent)

**Note**: Window navigation (`Cmd+h/j/k/l`) intentionally removed for Hammerspoon.

---

## Color Scheme - Tokyo Night

```
Background:  #1a1b26  (Dark blue)
Foreground:  #c0caf5  (Light blue-white)
Cursor:      #c0caf5  (Light blue-white)

Colors 0-7:  Normal colors
Colors 8-15: Bright colors
```

**Preview**: Cool blue/purple theme, good contrast, modern aesthetic.

---

## Customization

### Change Opacity

Edit `nix/home/programs.nix`:

```nix
background_opacity = 0.85;  # More transparent
background_opacity = 0.95;  # Less transparent
background_opacity = 1.0;   # No transparency
```

### Change Font Size

```nix
size = 16.0;  # Larger
size = 12.0;  # Smaller
```

### Change Theme

Replace the color values in `settings`:

**Gruvbox Dark**:
```nix
background = "#282828";
foreground = "#ebdbb2";
cursor = "#ebdbb2";
# ... (see MEMO_CUSTOMIZATION_GUIDE.md for full values)
```

**Catppuccin Mocha**:
```nix
background = "#1e1e2e";
foreground = "#cdd6f4";
cursor = "#89b4fa";
# ... (see MEMO_CUSTOMIZATION_GUIDE.md for full values)
```

**One Dark Pro** (match Alacritty):
```nix
background = "#282c34";
foreground = "#abb2bf";
cursor = "#528bff";
# ... (see MEMO_CUSTOMIZATION_GUIDE.md for full values)
```

See [MEMO_CUSTOMIZATION_GUIDE.md](MEMO_CUSTOMIZATION_GUIDE.md) for complete color schemes.

### Apply Changes

```bash
darwin-rebuild switch
```

---

## Hammerspoon Integration

Since window management is handled by Hammerspoon, here's a basic setup:

### Launch Kitty with Hotkey

Add to `~/.hammerspoon/init.lua`:

```lua
-- Launch or focus Kitty with Cmd+Alt+K
hs.hotkey.bind({"cmd", "alt"}, "K", function()
  local kitty = hs.application.find("kitty")
  if kitty then
    kitty:activate()
  else
    hs.application.open("kitty")
  end
end)
```

### Window Management Example

```lua
-- Move Kitty to right half of screen
hs.hotkey.bind({"cmd", "alt"}, "Right", function()
  local win = hs.window.focusedWindow()
  if win then
    win:moveToUnit(hs.geometry.rect(0.5, 0, 0.5, 1))
  end
end)
```

For more Hammerspoon examples, see [MEMO_EXAMPLES_RECIPES.md](MEMO_EXAMPLES_RECIPES.md) Recipes 25-29.

---

## Usage

### Launch Kitty

```bash
# From Spotlight
Cmd+Space, type "kitty"

# From terminal
kitty

# Or use Hammerspoon hotkey (if configured)
```

### Basic Workflow

1. Launch Kitty
2. Use tabs for organization (`Cmd+t` for new tab)
3. Hammerspoon manages window positioning
4. Standard clipboard operations (`Cmd+c`, `Cmd+v`)

---

## Comparison with Alacritty

| Feature | Alacritty | Kitty |
|---------|-----------|-------|
| Theme | One Dark Pro | Tokyo Night |
| Opacity | 0.75 (25% transparent) | 0.90 (10% transparent) |
| Font Size | 11pt | 14pt |
| Tabs | No | Yes |
| Use Case | Main development terminal | Alternative/specialized use |

---

## Directory Structure

```
nix-darwin/
├── nix/
│   └── home/
│       └── programs.nix  ← Kitty configuration here
└── docs/
    ├── KITTY_BASIC_CONFIG.md  ← This file
    └── MEMO_CUSTOMIZATION_GUIDE.md  ← Color schemes
```

**No** memo-specific files, scripts, or directories.

---

## Troubleshooting

### Colors Look Wrong

```bash
# Check TERM variable in Kitty
echo $TERM
# Should show: xterm-kitty

# Rebuild if needed
darwin-rebuild switch
```

### Transparency Not Working

```bash
# Check opacity setting
cat ~/.config/kitty/kitty.conf | grep opacity

# If file doesn't exist, rebuild
darwin-rebuild switch
```

### Font Too Thin on Retina Display

Already configured with `macos_thicken_font = 0.75`.

Adjust if needed (0.5 - 1.5):
```nix
macos_thicken_font = 0.85;  # Thicker
```

---

## Next Steps

1. **Apply configuration**: `darwin-rebuild switch`
2. **Test Kitty**: Launch and verify Tokyo Night theme
3. **Set up Hammerspoon**: Add window management
4. **Customize**: Adjust opacity/colors if needed

---

## Related Documentation

- [MEMO_CUSTOMIZATION_GUIDE.md](MEMO_CUSTOMIZATION_GUIDE.md) - 7 complete color schemes
- [MEMO_EXAMPLES_RECIPES.md](MEMO_EXAMPLES_RECIPES.md) - Hammerspoon integration (Recipes 25-29)
- [Official Kitty Docs](https://sw.kovidgoyal.net/kitty/) - Complete Kitty documentation

---

*Basic Kitty configuration - No memo features - Hammerspoon-ready*
