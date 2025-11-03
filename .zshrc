# ----- Random Logo (fixed randomness with .txt filtering) -----
LOGO_DIR="$HOME/.config/alsi/logos"
LOGO_LIST=("$LOGO_DIR"/*.txt(N))  # (N) = nullglob, ignores if empty
LOGO_COUNT=${#LOGO_LIST[@]}

if (( LOGO_COUNT > 0 )); then
  RANDOM_INDEX=$((RANDOM % LOGO_COUNT))
  RANDOM_LOGO="${LOGO_LIST[$RANDOM_INDEX]}"
  cp -f "$RANDOM_LOGO" "$HOME/.config/alsi/alsi.logo"
fi

#alsi --red
fastfetch

setopt CORRECT_ALL

# ----- Set default editor to nvim -----
export EDITOR=nvim


# ----- Powerlevel10k Instant Prompt -----
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ----- Oh My Zsh Setup -----
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(zsh-autosuggestions zsh-syntax-highlighting web-search history-substring-search fzf)
source $ZSH/oh-my-zsh.sh

# ----- Plugin Configuration -----
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#bf616a'
fpath+=($HOME/.zsh/zsh-completions)

export TERMINAL=kitty

# ----- Aliases -----
 if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# ----- Powerlevel10k Config -----
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



# ----- Environment Variables -----
export EDITOR=nvim
export VISUAL=nvim
export PATH="$HOME/polybar/build/bin:$PATH"

# Created by `pipx` on 2025-05-19 01:55:06
export PATH="$PATH:/home/thinus/.local/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'


export TERM=xterm-256color

export PYTHONPATH="$HOME/python-lib:$PYTHONPATH"

