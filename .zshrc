# ===========================
#  Appearance & Startup Logo
# ===========================
LOGO_DIR="$HOME/.config/alsi/logos"
LOGO_LIST=("$LOGO_DIR"/*.txt(N))  # (N) = nullglob, ignores if empty
LOGO_COUNT=${#LOGO_LIST[@]}

if (( LOGO_COUNT > 0 )); then
  RANDOM_INDEX=$((RANDOM % LOGO_COUNT))
  RANDOM_LOGO="${LOGO_LIST[$RANDOM_INDEX]}"
  cp -f "$RANDOM_LOGO" "$HOME/.config/alsi/alsi.logo"
fi

# alsi --red
fastfetch

# ===========================
#  Zsh Options
# ===========================
setopt CORRECT_ALL

# ===========================
#  Editor & Terminal
# ===========================
export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=kitty
export TERM=xterm-256color

# ===========================
#  Prompt (Powerlevel10k)
# ===========================
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ===========================
#  Oh My Zsh Setup
# ===========================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  web-search
  history-substring-search
  fzf
)
source $ZSH/oh-my-zsh.sh

# ===========================
#  Plugin Configuration
# ===========================
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#bf616a'
fpath+=($HOME/.zsh/zsh-completions)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'

# ===========================
#  Aliases
# ===========================
if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

# ===========================
#  Environment Variables
# ===========================
export PATH="$HOME/polybar/build/bin:$PATH"
export PATH="$PATH:/home/thinus/.local/bin"   # pipx addition
export PYTHONPATH="$HOME/python-lib:$PYTHONPATH"

