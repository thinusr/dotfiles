# ----- Powerlevel10k Instant Prompt -----
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ----- Oh My Zsh Setup -----
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search history-substring-search fzf)
source $ZSH/oh-my-zsh.sh

# ----- Plugin Configuration -----
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#bf616a'
fpath+=($HOME/.zsh/zsh-completions)

export TERMINAL=kitty

# ----- Aliases -----
alias x='exit'
alias c='clear'
alias backup='sudo /home/thinus/scripts/backup/backup.sh'
alias update='sudo pacman -Syyu'
alias vim="nvim"
alias tip='python ~/PycharmProjects/coding_projects/tip_calculator/tip_calculator.py'
alias ollama='(ollama serve & docker-compose -f /home/thinus/docker_compose/docker-compose.yml up -d)'
alias ls='lsd -a --color=auto --icon=always'
alias home='cd ~'
alias scale='xrandr --output HDMI-2 --scale 1.20x1.20'
alias scaleup='xrandr --output HDMI-2 --scale 1.00x1.00'
alias yay='yay --color=always'
alias fo='code $(fzf)'
alias pp='cd ~/PycharmProjects'
alias push='git push'
alias add='git add .'
alias status='git status'
alias emacs='emacs -nw'
alias doom='emacs -nw'
alias nani='nano'
alias nanno='nano'
alias nanni='nano'
alias bubble='python3 /home/thinus/scripts/redbubble-automate/redbubble.py'
alias xpost='~/.venvs/xposter/bin/python /home/thinus/scripts/redbubble-automate/x-post.py'
alias reset='python3 /home/thinus/scripts/redbubble-automate/reset-posted.py'
alias mirrors='sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist'
alias logout='i3-msg exit'
alias webapp='/home/thinus/scripts/create-webapp/create-webapp.sh'
alias appdel='/home/thinus/scripts/create-webapp/delete-webapp.sh'
alias dbstart='nohup dropbox start > /dev/null 2>&1 &'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# ----- Powerlevel10k Config -----
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ----- Random Logo (fixed randomness with .txt filtering) -----
LOGO_DIR="$HOME/.config/alsi/logos"
LOGO_LIST=("$LOGO_DIR"/*.txt)  # Ensure we only pick .txt files
LOGO_COUNT=${#LOGO_LIST[@]}

if (( LOGO_COUNT > 0 )); then
  RANDOM_INDEX=$((RANDOM % LOGO_COUNT))
  RANDOM_LOGO="${LOGO_LIST[$RANDOM_INDEX]}"
  cp "$RANDOM_LOGO" "$HOME/.config/alsi/alsi.logo"
fi

alsi --green

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

