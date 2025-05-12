RICING_HOME="$HOME/.ricing"

export XCURSOR_PATH=${XCURSOR_PATH}:~/.local/share/icons
export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color" 
export EDITOR="nano"

ZSH_CUSTOM="$RICING_HOME/rices/omz"
ZSH_THEME="headline"

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 2

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd/mm/yyyy"

plugins=(git flatpak fzf-completion) 

alias reload="source ~/.zshrc"
alias zshrc="nano ~/.zshrc"
alias yay="yay --color always"

alias rice="$RICING_HOME/rice.sh"

source $ZSH/oh-my-zsh.sh
source "$RICING_HOME/rices/omz/plugins/fzf-tab/fzf-tab.plugin.zsh"
