#!/usr/bin/bash

# Changing this might have unexpected behavior, especially with oh-my-zsh!
RICING_HOME="$HOME/.ricing"

function omz-rice {
  rm -rf "$RICING_HOME/rices/omz"

  mkdir -p "$RICING_HOME/rices/omz/themes"
  mkdir -p "$RICING_HOME/rices/omz/plugins"

  ln -s "$RICING_HOME/sources/omz/plugins/fzf-tab" "$RICING_HOME/rices/omz/plugins/fzf-tab"
  ln -s "$RICING_HOME/sources/omz/plugins/flatpak" "$RICING_HOME/rices/omz/plugins/flatpak"
  ln -s "$RICING_HOME/sources/omz/themes/headline/headline.zsh-theme" "$RICING_HOME/rices/omz/themes/headline.zsh-theme"

  echo "source ~/.ricing/zshrc" > "$HOME/.zshrc"
}

function ui-rice {
  mkdir -p "$HOME/.local/share/icons"
  
  rm -rf "$HOME/.local/share/icons/future-cyan"
  ln -s "$RICING_HOME/sources/cursors/future-cyan" "$HOME/.local/share/icons/future-cyan"
}

function rice-link {
  if [ -z "$1" ]; then
    echo "[!] Please provide a ricing name."
    return 1
  fi

  RICING_CONFIG="$RICING_HOME/config/$1"
  HOME_CONFIG="$HOME/.config/$1"

  if [ -L "$HOME_CONFIG" ]; then
    echo "[!] $HOME_CONFIG already exists and is a symlink. This directory is probably already riced."
    return 1
  fi

  if [ -d "$HOME_CONFIG" ] && [ -d "$RICING_CONFIG" ]; then
    echo "[!] $1 already exists both in the .config directory and .ricing directory. Please resolve this conflict manually."
    return 1
  fi

  if [ -d "$HOME_CONFIG" ] && [ ! -d "$RICING_CONFIG" ]; then
    mv "$HOME_CONFIG" "$RICING_CONFIG"
    ln -s "$RICING_CONFIG" "$HOME_CONFIG"
    echo "[i] The existing configuration has been riced !"
  fi

  if [ ! -d "$HOME_CONFIG" ] && [ ! -d "$RICING_CONFIG" ]; then
    mkdir "$RICING_CONFIG"
    ln -s "$RICING_CONFIG" "$HOME_CONFIG"
    echo "[i] The ricing has been created !"
  fi

  if [ ! -d "$HOME_CONFIG" ] && [ -d "$RICING_CONFIG" ]; then
    ln -s "$RICING_CONFIG" "$HOME_CONFIG"
    echo "[i] The ricing has been linked !"
  fi
}

function link-all {
  echo "For each <name> in the config directory of this repository, your own .config/<name> will be removed."
  echo "Please be 100% sure that you have created backups if needed."
  echo
  read -p "Press [Enter] to continue or [Ctrl+C] to cancel."

  for config in "$RICING_HOME"/config/*; do
    path=$(realpath "$config")
    name=$(basename "$config")
    dest="$HOME/.config/$name"

    rm -rf "$dest"
    ln -s "$path" "$dest"
  done
}

function deps {
  yay -Sy hyprland hyprcursor hyprshot hyprpaper wofi waybar xdg-desktop-portal-gtk xdg-desktop-portal-hyprland \
    papirus-icon-theme-git chafa noto-fonts noto-fonts-cjk noto-fonts-emoji alacritty adw-gtk-theme \
    qt5ct qt6ct mako playerctl inotify-tools montserrat-ttf fzf thefuck bc
}



case $1 in
  omz)
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
      echo "[!] Please install oh-my-zsh first."
      return 1
    fi
    omz-rice
    ;;
  ui)
    ui-rice
    ;;
  link)
    rice-link $2
    ;;
  force-link)
    link-all
    ;;
  *)
    echo "Ricing Utils"
    echo
    echo "  rice omz              Install oh-my-zsh spice"
    edho "  rice ui               Install cursors and icons (that aren't on the AUR, sadge)"
    echo "  rice link <name>      Rice a .config folder"
    echo "  rice force-link       Enforce all config directories to be riced up."
    echo
    ;;
esac
