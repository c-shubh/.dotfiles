#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ble.sh -- keep this line here at the top 
[[ $- == *i* ]] && source /usr/share/blesh/ble.sh --noattach

# autojump
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

# ignore upper and lowercase when TAB completion
bind -s 'set completion-ignore-case on'

# alias
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cls='clear'
alias copy='xclip -selection clip'
alias e.='xdg-open .'
alias ga='git add'
alias l=ls
alias ls='ls -p --color=auto'
alias open='xdg-open'
alias py='python'
alias qrtxt='qrencode -t ansiutf8'
alias tt='gio trash'
# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
# dotfiles management with git bare repo 
# https://www.atlassian.com/git/tutorials/dotfiles
alias conf='/usr/bin/git --git-dir=/home/shubh/.dotfiles/ --work-tree=/home/shubh'

PS1='[\u@\h \W]\$ '

# custom functions
md() { pandoc "$1" | lynx -stdin; }
tmp() { cd /home/shubh/tmp/; }

# rbenv
eval "$(rbenv init -)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# PATH
PATH="\
$PATH\
:$HOME/bin\
:$HOME/.local/bin\
:$HOME/tools/flutter/bin\
:$HOME/src/google/depot_tools\
"

# exports
export ANDROID_HOME="$HOME/Android/Sdk"
# "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# for flutter
export CHROME_EXECUTABLE=/opt/brave-bin/brave

# Load Angular CLI autocompletion.
source <(ng completion script)

# ble.sh -- keep this line here at the end
[[ ${BLE_VERSION-} ]] && ble-attach
