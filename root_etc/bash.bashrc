#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

###############
### EXPORTS ###
###############

### MISC ###
export IGNOREEOF="100" # must press ctrl-D 100+1 times to exit shell

#############
### SHOPT ###
#############

shopt -s autocd # runs 'cd' when only directory path was given
shopt -s cdspell # Corrects minor spelling mistakes
shopt -s no_empty_cmd_completion # disable command completion when empty
shopt -s nocaseglob # Case-instensitive globbing
[[ $DISPLAY ]] && shopt -s checkwinsize # checks term window size after bash regains control

#######################
### BASH COMPLETION ###
#######################

if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
fi

complete -c man which info
complete -cf sudo

##############
### PROMPT ###
##############

test -f "/etc/bash.bash_prompt" && . "/etc/bash.bash_prompt"
