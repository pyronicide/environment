# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
#export ZSH_THEME="robbyrussell"
export ZSH_THEME="wezm"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export ALTERNATE_EDITOR=emacs
export EDITOR=emacsclient
export VISUAL=emacsclient

# GIT aliases
alias gcm='git commit -a -m'

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Append hg functions needed for prompt.
preexec_functions+='preexec_update_hg_vars'
precmd_functions+='precmd_update_hg_vars'
chpwd_functions+='chpwd_update_hg_vars'

plugins=(git osx ruby brew gem github pip)

# homebrew python
export PATH=/usr/local/share/python:/usr/local/bin:$PATH
export GEM_HOME=/usr/local

alias emacs='/usr/local/Cellar/emacs/HEAD/Emacs.app/Contents/MacOS/Emacs -nw'
