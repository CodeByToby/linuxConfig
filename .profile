#
# ~/.profile
#

#######################
### XDG DIRECTORIES ###
#######################

test -z "$XDG_CACHE_HOME" && XDG_CACHE_HOME="$HOME/.cache"
test -z "$XDG_CONFIG_HOME" && XDG_CONFIG_HOME="$HOME/.config"
test -z "$XDG_DATA_HOME" && XDG_DATA_HOME="$HOME/.local/share"
test -z "$XDG_STATE_HOME" && XDG_STATE_HOME="$HOME/.local/state"

export XDG_CACHE_HOME XDG_CONFIG_HOME XDG_DATA_HOME XDG_STATE_HOME

############
### PATH ###
############

function append_path {
  # Check if directory exists
  ! test -d "$1" && return

  # Check if directory already exists in PATH
  grep -Eq "(^|:)$1(:|$)" <<< "$PATH" && return

  # Append to path and export it
  export PATH="$1:${PATH}"
}

append_path "$HOME/.bin"
append_path "$HOME/.applications"
append_path "$HOME/.scripts"
append_path "$HOME/.local/bin"

unset -f append_path

################
### HISTFILE ###
################

# Check if HISTFILE exists
if ! test -r "$HISTFILE"; then
  touch "$HISTFILE"
fi

# Copy contents of prev HISTFILE if it exists
if test -r "$HOME/.bash_history"; then
  cat "$HOME/.bash_history" >> "$HISTFILE"
  rm -f "$HOME/.bash_history"
fi

####################
### MISC EXPORTS ###
####################

# returns 0 whether program is installed.
function is_installed {
  return $(which "$1" &>/dev/null)
}

### fcitx5 ###
if is_installed fcitx5; then
    GTK_IM_MODULE=fcitx
    QT_IM_MODULE=fcitx
    XMODIFIERS=@im=fcitx

    export GTK_IM_MODULE QT_IM_MODULE XMODIFIERS
fi

### Home cleaning ###
# use 'xdg_ninja' to help you with files/exports.
is_installed less && LESSHISTFILE="$XDG_STATE_HOME/less/history"
is_installed cargo && CARGO_HOME="$XDG_DATA_HOME/cargo"
is_installed iceauth && ICEAUTHORITY="$XDG_CACHE_HOME/ICEauthority"
is_installed wine && WINEPREFIX="$XDG_DATA_HOME/wine"
is_installed gpg && GNUPGHOME="$XDG_DATA_HOME/gnupg"

test -d "$XDG_DATA_HOME/icons" && XCURSOR_PATH="/usr/share/icons:$XDG_DATA_HOME/icons"
GOPATH="$XDG_DATA_HOME/go"

export LESSHISTFILE CARGO_HOME ICEAUTHORITY WINEPREFIX GNUPGHOME XCURSOR_PATH GOPATH

unset -f is_installed

#####################
### SHELL CONFIGS ###
#####################

if test $SHELL = /bin/bash; then
    test -f "$HOME"/.bashrc && . "$HOME"/.bashrc
elif test $SHELL = /bin/zsh; then
    test -f "$HOME"/.zshrc && . "$HOME"/.zshrc
fi
