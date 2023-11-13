# Path to oh-my-zsh installation
export ZSH=~/.oh-my-zsh

# Disable auto-updates
DISABLE_AUTO_UPDATE="FALSE"

# Set history config
HISTFILE=~/.zsh_history
HISTSIZE="100000000000"
SAVEHIST="100000000000"

# Theme
ZSH_THEME="fishy"

# Ignore duplicate lines in history
setopt HIST_IGNORE_DUPS

# Allow autocompletion of alias switches
setopt completealiases

# Fix aliases in sudo
alias sudo='sudo '

# Alias to unzip any file with "unzip" command
unzip(){
    if [ -f $1 ] ; then
            case $1 in
                    *.tar.bz2)   tar xvjf $1    ;;
                    *.tar.gz)    tar xvzf $1    ;;
                    *.bz2)       bunzip2 $1     ;;
                    *.rar)       unrar x $1     ;;
                    *.gz)        gunzip $1      ;;
                    *.tar)       tar xvf $1     ;;
                    *.tbz2)      tar xvjf $1    ;;
                    *.tgz)       tar xvzf $1    ;;
                    *.zip)       unzip $1       ;;
                    *.Z)         uncompress $1  ;;
                    *.7z)        7z x $1        ;;
                    *)           echo "Unable to extract '$1'" ;;
            esac
    else
            echo "'$1' is not a valid file"
    fi
}

# Select which plugins to load
plugins=(docker colored-man-pages command-not-found encode64 extract git-prompt hitchhiker sudo tmux history common-aliases systemd git ssh-agent jsontools lol ansible screen systemadmin)
zstyle :omz:plugins:ssh-agent agent-forwarding yes
zstyle :omz:plugins:ssh-agent identities id_rsa ansible_id_rsa
#zstyle :omz:plugins:ssh-agent lazy yes

# Set language environment
export LANG="en_US.UTF-8"
export LC_ALL="C.UTF-8"
# Set up Go environment
export GOPATH=$HOME/go

# Set path
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/bin:$GOPATH/bin:/usr/games"

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
source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Enable z
. $HOME/bin/z.sh

# hook direnv
eval "$(direnv hook zsh)"

# kubectl autocomplete
#[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit.git "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-rust \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-bin-gem-node

### End of Zinit's installer chunk

#Git branch prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
# PROMPT=\$vcs_info_msg_0_'%# '
zstyle ':vcs_info:git:*' formats '%b'

# LFTP alias
alias airlock_bru='lftp -u a-jgreen@corp.dsg.local airlock-brussels.corp.dsg.local'
alias airlock_brp='lftp -u a-jgreen@corp.dsg.local airlock-brampton.corp.dsg.local'
