#
# ~/.bashrc
#

# Prompt customisation is present in /etc/bash.bashrc and /etc/bash.bash_prompt!

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

###############
### EXPORTS ###
###############

EDITOR="nvim"
PAGER="less"
test "$DISPLAY" \
     && VISUAL="mousepad" \
     && BROWSER="librewolf"

export EDITOR PAGER VISUAL BROWSER

###############
### HISTORY ###
###############

HISTTIMEFORMAT="%Y-%m-%d %t "
HISTCONTROL="ignoreboth:erasedups" # ignores and deletes entries starting w/ space and duplicates
HISTIGNORE="clear:neofetch:ls:history:man:info"
HISTFILE="$XDG_STATE_HOME/bash/history"

export HISTTIMEFORMAT HISTCONTROL HISTIGNORE HISTFILE

#############
### SHOPT ###
#############

# run shopt -p to see all available options and their values
shopt -s autocd # runs 'cd' when only directory path was given
shopt -s cmdhist # saves multiline commands as a single line
shopt -s histappend # do not overwrite history
shopt -s no_empty_cmd_completion # disable command completion when empty
shopt -s extglob # expand pattern checking
shopt -s cdspell # Corrects minor spelling mistakes
#shopt -s nocaseglob # Case-instensitive globbing
test "${DISPLAY}" && shopt -s checkwinsize # checks term window size after bash regains control

#################
### DIRCOLORS ###
#################

dircolors_file='.config/dircolors'

which dircolors &>/dev/null && test -f "$dircolors_file" \
    && eval "$(dircolors -b $dircolors_file)" \
    || eval "$(dircolors -b)"

unset dircolors_file

###########################
### ALIASES & FUNCTIONS ###
###########################m

test -f "$HOME/.config/bash/aliases" && . "$HOME/.config/bash/aliases"
test -f "$HOME/.config/bash/functions" && . "$HOME/.config/bash/functions"
