# 🖥️ ALSI Config

A customized setup of **ALSI** (Arch Linux System Information) for displaying detailed system stats with beautiful, braille-mode ASCII logos on shell startup.

---

## 📁 File Structure

~/.config/alsi/  
├── alsi.conf # Configuration settings (paths, options, colors)  
├── alsi.output # Defines displayed system info layout  
├── alsi.logo # Active logo used by ALSI  
├── alsi.logo.save # Optional backup logo  
├── alsi.de # Desktop Environment info  
├── alsi.wm # Window Manager info  
├── alsi.colors # Custom color values (optional)  
├── logos/ # ASCII logo files used by ALSI  
└── logos-backup/ # Original PNG logos before conversion


---

## 🚀 Installation

1. Clone or copy the ALSI config to your system:

   **Using SSH:**
```bash
git clone git@gitlab.com:myprojects2641204/dotfiles.git ~/Downloads/dotfiles
mv ~/Downloads/dotfiles/alsi ~/.config/
```

Or using HTTPS:

```bash
git clone https://gitlab.com/myprojects2641204/dotfiles.git ~/Downloads/dotfiles
mv ~/Downloads/dotfiles/alsi ~/.config/
```

 2. Make sure ALSI is installed on your system.
     
 3. Update your shell config (`.zshrc`, `.bashrc`, etc.) to run ALSI at startup:


```zsh
# Example for Zsh – adjust for your shell if needed

LOGO_DIR="$HOME/.config/alsi/logos"
LOGO_LIST=("$LOGO_DIR"/*.txt)
LOGO_COUNT=${#LOGO_LIST[@]}

if (( LOGO_COUNT > 0 )); then
  RANDOM_INDEX=$((RANDOM % LOGO_COUNT))
  RANDOM_LOGO="${LOGO_LIST[$RANDOM_INDEX]}"
  cp "$RANDOM_LOGO" "$HOME/.config/alsi/alsi.logo"
fi

alsi --green
```

## ⚙️ Configuration Overview

- `alsi.conf`: Core config, includes:
    
    - Paths to logo and color files
        
    - Disk, CPU, GTK, and screenshot commands
        
    - Enable/disable features like bold colors or usage thresholds
        
- `alsi.output`: Controls the visible order and formatting of:
    
    - OS, Hostname, Uptime, Kernel, Shell
        
    - GTK themes, DE/WM name, Package count, RAM, SWAP, CPU, etc.
        
- `alsi.logo`: The current logo displayed at startup (set via `.zshrc`).

## 🧩 Output Customization

Each line in `alsi.output` is a hash defining:

```
{RAM => '%sRAM:%s %s'}
```

- `%s`: Placeholders for color and value
    
- Supports hardcoded text, custom shell commands, or system properties
    

You can also add your own fields using:

```
{COMMAND => ['%sCustom Info:%s %s', 'echo Hello World']}
```

## 🎲 Random Logo Support

Your terminal startup script dynamically picks a random .txt from your logos:

```zsh
LOGO_DIR="$HOME/.config/alsi/logos"
LOGO_LIST=("$LOGO_DIR"/*.txt)
LOGO_COUNT=${#LOGO_LIST[@]}

if (( LOGO_COUNT > 0 )); then
  RANDOM_INDEX=$((RANDOM % LOGO_COUNT))
  RANDOM_LOGO="${LOGO_LIST[$RANDOM_INDEX]}"
  cp "$RANDOM_LOGO" "$HOME/.config/alsi/alsi.logo"
fi
```

This ensures a fresh look every time you launch your terminal.

## 🛠 Creating Logos

Custom logos are created using [`ascii-image-converter`](https://github.com/TheZoraiz/ascii-image-converter):

```bash
ascii-image-converter -b -H 12 image.png > logo.txt
```

- `-b`: Braille mode for crisp ASCII resolution
    
- `-H 12`: Sets height to 12 lines for layout consistency
### Workflow:

1. PNG logos are stored in `logos-backup/`.
    
2. Images are prepared using **Inkscape** to get the right size and contrast.
    
3. Logos are converted to `.txt` and saved in `logos/`.
## 🖼️ Preview

![screenshot](alsi/screenshot.png)

## 📄 License

MIT

## 🙌 Credits

- [ascii-image-converter](https://github.com/TheZoraiz/ascii-image-converter) by [@TheZoraiz](https://github.com/TheZoraiz)
    
- ALSI original author(s)
    
- Inspired by neofetch and screenfetch