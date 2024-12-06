# set aliases
source ~/.zsh_aliases

if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -L "$HOME/.config/minimal.zsh" ]] then
  source "$HOME/.config/minimal.zsh"
fi

# History
HISTSIZE=15000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Keybindings
bindkey -e
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward
bindkey '^[w' kill-region

