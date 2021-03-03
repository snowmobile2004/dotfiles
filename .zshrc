# Path to oh-my-zsh installation
export ZSH=~/.oh-my-zsh

# Disable auto-updates
DISABLE_AUTO_UPDATE="true"

# Set history config
HISTFILE=~/.zsh_history
HISTSIZE="1000"
SAVEHIST="1000000"

# Theme
ZSH_THEME="fishy"

# Ignore duplicate lines in history
setopt HIST_IGNORE_DUPS

# Allow autocompletion of alias switches
setopt completealiases

# Select which plugins to load
plugins=(sudo tmux history common-aliases systemd)

# Set language environment
export LANG="en_US.UTF-8"

# Set up Go environment
export GOPATH=$HOME/go

# Set path
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/bin:$GOPATH/bin"

# Enable command completion
autoload -U compinit
compinit
autoload -U bashcompinit
bashcompinit

# Allow arrow key control of completions
zstyle ':completion:*' menu select

# Find any new executables in path
zstyle ':completion:*' rehash true

# Source config file
source $ZSH/oh-my-zsh.sh

## Aliases
source ~/.zsh_aliases

# Enable syntax highlighting
source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Enable z
. $HOME/bin/z.sh