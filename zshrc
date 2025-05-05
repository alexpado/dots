RICING_HOME="$HOME/.ricing"

export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nano"
ZSH_CUSTOM="$RICING_HOME/rices/omz"
ZSH_THEME="headline"

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 2

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd/mm/yyyy"

plugins=(git flatpak)

alias reload="source ~/.zshrc"
alias zshrc="nano ~/.zshrc"
alias ohmy="cd /var/opt/oh-my-zsh"
alias hostname="cat /etc/hostname"
alias k-dns="ssh akio@192.168.1.4 -p 2222"
alias k-nuc="ssh akio@192.168.1.3 -p 2222"
alias k-nucr="ssh akio@home.alexpado.fr -p 2222"
alias k-vps="ssh debian@141.94.115.40 -p 2222"
alias yt2mp3="yt-dlp -x --audio-format mp3"

alias color="~/.config/alacritty/color.sh"
alias rice="$RICING_HOME/rice.sh"

function update-arch {
  yay -Syu
  sudo pacman -Syu
  sudo pacman -Sy
  sudo flatpak update
}

function media-cut {
  ffmpeg -i $1 -ss $2 -to $3 -c copy -map 0 $4
}

function media-share {
  ffmpeg -i $1 -c:a mp3 -c:v libx264 -map 0 $2
}

source $ZSH/oh-my-zsh.sh
source <(fzf --zsh)

source "$RICING_HOME/rices/omz/plugins/fzf-tab/fzf-tab.plugin.zsh"
