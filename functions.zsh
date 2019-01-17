# -------------------------------------------------------------------
# Checks
# (stolen from zshuery)
# -------------------------------------------------------------------
if [[ $(uname) = 'Linux' ]]; then
    IS_LINUX=1
fi

if [[ $(uname) = 'Darwin' ]]; then
    IS_MAC=1
fi

# -------------------------------------------------------------------
# Source a file for zsh if file exists.
# -------------------------------------------------------------------
function source_if_possible() {
    if [[ -r $1 ]]; then
        source $1
    fi
}

# -------------------------------------------------------------------
# display a neatly formatted path
# -------------------------------------------------------------------
path() {
    echo $PATH | tr ":" "\n" | \
        awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
           sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
           sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
           sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
           sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
           print }"
}

# -------------------------------------------------------------------
# Mac specific functions
# -------------------------------------------------------------------
if [[ $IS_MAC -eq 1 ]]; then
    # Rebuild Launch Services to remove duplicate entries on Open With menu.
    alias rebuildopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.fram ework/Support/lsregister -kill -r -domain local -domain system -domain user'

fi

# -------------------------------------------------------------------
# myIP address
# -------------------------------------------------------------------
function myip() {
    ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
    ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
    ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
    ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
    ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}

# -------------------------------------------------------------------
# use nocorrect alias to prevent auto correct from "fixing" these
# -------------------------------------------------------------------
#alias foobar='nocorrect foobar'
# -------------------------------------------------------------------
# directory movement
# -------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
# -------------------------------------------------------------------
# directory information
# -------------------------------------------------------------------

alias l='ls -al'
alias lh='ls -d .*' # show hidden files/directories only

if [[ $IS_MAC -eq 1 ]]; then
    # Colorize output, add file type indicator, and put sizes in human readable format
    alias ls='ls -GFh'
    # directories sorted by size
    alias dus='du -sckx * | sort -nr'
fi

# -------------------------------------------------------------------
# me
# -------------------------------------------------------------------
# -2 for color, || to attach to a current session or create a new session
alias tm='tmux -2 attach || tmux -2 new'

alias jformat='python -m json.tool'
# -------------------------------------------------------------------
# remote machines
# -------------------------------------------------------------------

# This requires ~/.ssh/config to exist with the right configuration.
alias seedbox='ssh genesis'

# curiosities
# gsh shows the number of commits for the current repos for all developers
alias gsh="git shortlog | grep -E '^[ ]+\w+' | wc -l"

# gu shows a list of all developers and the number of commits they've made
alias gu="git shortlog | grep -E '^[^ ]'"

function git_set_james() {
    git config user.email james@jojojames.com
}

# -------------------------------------------------------------------
# Android
# -------------------------------------------------------------------
function adb_reset() {
    adb kill-server
    adb start-server
    adb devices
}
