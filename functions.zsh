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
# nice mount (http://catonmat.net/blog/another-ten-one-liners-from-commandlingfu-explained)
# displays mounted drive information in a nicely formatted manner
# -------------------------------------------------------------------
function nicemount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') | column -t ; }

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
# console function
# -------------------------------------------------------------------
function console () {
    if [[ $# > 0 ]]; then
        query=$(echo "$*"|tr -s ' ' '|')
        tail -f /var/log/system.log|grep -i --color=auto -E "$query"
    else
        tail -f /var/log/system.log
    fi
}

# -------------------------------------------------------------------
# Open directory in OS File Explorer.
# -------------------------------------------------------------------
function finder() {
    if [[ $IS_MAC -eq 1 ]]; then
        open .
    else
        echo "Implement opening folder after screenshot."
    fi
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
# force tmux to use 256 colors
# alias tmux='TERM=screen-256color-bce tmux'

alias jformat='python -m json.tool'
# -------------------------------------------------------------------
# remote machines
# -------------------------------------------------------------------
alias seedbox='ssh jojojames@genesis.whatbox.ca'
# -------------------------------------------------------------------
# Git
# -------------------------------------------------------------------
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gpl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs='git status'
alias gd='git diff'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gta='git tag -a -m'
alias gf='git reflog'
alias gv='git log --pretty=format:'%s' | cut -d " " -f 1 | sort | uniq -c | sort -nr'

# leverage aliases from ~/.gitconfig
alias gh='git hist'
alias gt='git today'

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
function adb_screenshot() {
    adb shell screencap -p /sdcard/screen.png
    adb pull /sdcard/screen.png
    adb shell rm /sdcard/screen.png
    open_in_file_explorer
}

function adb_reset() {
    adb kill-server
    adb start-server
    adb devices
}

# -------------------------------------------------------------------
# iOS
# -------------------------------------------------------------------
function ios_screenshot() {
    echo "This doesn't yet work on iOS 10, don't be confused it this fails."
    idevicescreenshot temp.tiff
    sips -s format png temp.tiff --out screenshot.png
    rm ./temp.tiff
    open_in_file_explorer
}
