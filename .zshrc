# Path to oh-my-zsh installation
export ZSH=~/.oh-my-zsh

# Disable auto-updates
DISABLE_AUTO_UPDATE="FALSE"

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
plugins=(sudo tmux history common-aliases systemd git ssh-agent)
zstyle :omz:plugins:ssh-agent agent-forwarding yes
zstyle :omz:plugins:ssh-agent identities id_rsa ansible_id_rsa

# Set language environment
export LANG="en_US.UTF-8"
export LC_ALL="C.UTF-8"
# Set up Go environment
export GOPATH=$HOME/go

# Set path
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/bin:$GOPATH/bin"

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
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

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

# kube context tag
#zplugin light jonmosco/kube-ps1
#PROMPT='$(kube_ps1)'$PROMPT


#Git branch prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
# PROMPT=\$vcs_info_msg_0_'%# '
zstyle ':vcs_info:git:*' formats '%b'

# Custom ssh agent config
${HOME}/.local/bin/wsl-ssh-agent-relay start
export SSH_AUTH_SOCK=${HOME}/.ssh/wsl-ssh-agent.sock
setsid nohup socat EXEC:"/c/Users/jgreen/npiperelay.exe //./pipe/\ssh-pageant" \
    UNIX-LISTEN:${SSH_AUTH_SOCK},unlink-close,unlink-early,fork \
    >/dev/null 2>&1 &
