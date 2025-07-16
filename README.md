# Thinus's Dotfiles

This is my personal dotfiles repository, built for a clean, customized, and efficient Arch Linux setup using i3 window manager. Everything is tuned for simplicity, minimalism, and performance, while maintaining full control over the look and feel of my system.

## 🛠 What's Included

### Core Configurations

- **Zsh (`.zshrc`)** – My primary shell configuration.
- **i3 (`.config/i3/`)** – Window manager config and related helper scripts.
- **Dunst (`.config/dunst/`)** – Notification daemon themed with Gruvbox-Dark.
- **Picom (`.config/picom/`)** – Compositor config for transparency and effects.
- **Polybar (`.config/polybar/`)** – Custom status bar with launch scripts and modules.
- **Rofi (`.config/rofi/`)** – App launcher and power menu with Gruvbox and Nord themes.
- **Kitty & WezTerm (`.config/kitty/`, `.config/wezterm/`)** – Terminal emulator configs.
- **Neovim (`.config/nvim/`)** – Lightweight text editing environment.
- **LF (`.config/lf/`)** – Minimal terminal file manager with neovim integration.
- **GTK 2/3/4 (`.config/gtk-*`)** – Unified theming across all GTK apps.

### Custom Tools

- **ALSi (`.config/alsi/`)** – Custom ASCII logo splash tool with logos and backups.
- **Theme Assets** – Fonts, colorschemes, wallpapers, etc. used throughout the system.

## 💡 Philosophy

This setup reflects a traditional, minimal Unix philosophy:
- Everything is plain text.
- Nothing is hidden from the user.
- No bloat or unnecessary services.
- Dotfiles are symlinked from a central Git-tracked folder.

## 🔗 Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/thinusr/dotfiles.git ~/dotfiles
   ```

2. Symlink the contents manually or use a bootstrap script like GNU Stow (optional). Example:
   ```bash
   ln -s ~/dotfiles/.zshrc ~/.zshrc
   ln -s ~/dotfiles/.config/i3 ~/.config/i3
   ```

3. Reboot or reload relevant services (`i3-msg reload`, etc).

## 📁 Repo Structure

```
.
├── .zshrc
├── .config/
│   ├── alacritty/
│   ├── alsi/
│   ├── dunst/
│   ├── gtk-2.0/
│   ├── gtk-3.0/
│   ├── gtk-4.0/
│   ├── i3/
│   ├── kitty/
│   ├── lf/
│   ├── nvim/
│   ├── picom/
│   ├── polybar/
│   ├── rofi/
│   └── wezterm/
├── .gitignore
├── LICENSE
└── README.md
```

## 📜 License

MIT License — use freely, tweak as needed, and learn something in the process.

---

**Arch + i3 + Your Dotfiles = Home** 🐧

