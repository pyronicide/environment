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


# SVN helper functions
svnstatus () {
    templist=`svn status $*`
    echo `echo $templist | grep '^?' | wc -l` unversioned files/directories
    echo $templist | grep -v '^?'
}

svnup () {
    svn log --stop-on-copy -r HEAD:BASE $1
    svn up $1
}

svndiff() {
    svn diff | emacspipe
}

function svn_prompt_info() {
    branch=$(svn_current_branch) || return
    echo "$ZSH_THEME_SVN_PROMPT_PREFIX$branch$(parse_svn_dirty)$ZSH_THEME_SVN_PROMPT_SUFFIX"
}

parse_svn_dirty() {
    if [[ $(svn diff 2> /dev/null) != "" ]]; then
        echo "$ZSH_THEME_SVN_PROMPT_DIRTY"
    else
        echo "$ZSH_THEME_SVN_PROMPT_CLEAN"
    fi
}

svn_current_branch() {
    svn info 2> /dev/null | grep '^URL:' | egrep -o '(tags|branches)/[^/]+|trunk' | egrep -o '[^/]+$'
}

emacspipe() {
    unset DISPLAY

    tmp_file="$(mktemp)"
    lisp_to_accept_file="(fake-stdin-slurp \"${tmp_file}\")"

    if [ ! -t 0  ]; then
        cat > "${tmp_file}"

        emacsclient -a emacs -e "${lisp_to_accept_file}" ${@}

        if [ ${?} -ne 0 ]; then
            echo "failed: your input was saved in '${tmp_file}'"
        else
            rm -f "${tmp_file}"
        fi
    else
    # nothing from stdin
        emacsclient -n -a emacs ${@}
    fi
}

alias sstat='svnstatus'