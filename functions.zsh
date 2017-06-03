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

if [[ -x `which brew` ]]; then
    HAS_BREW=1
fi

if [[ -x `which apt-get` ]]; then
    HAS_APT=1
fi

if [[ -x `which yum` ]]; then
    HAS_YUM=1
fi

# -------------------------------------------------------------------
# compressed file expander
# (from https://github.com/myfreeweb/zshuery/blob/master/zshuery.sh)
# -------------------------------------------------------------------
ex() {
    if [[ -f $1 ]]; then
        case $1 in
            *.tar.bz2) tar xvjf $1;;
            *.tar.gz) tar xvzf $1;;
            *.tar.xz) tar xvJf $1;;
            *.tar.lzma) tar --lzma xvf $1;;
            *.bz2) bunzip $1;;
            *.rar) unrar $1;;
            *.gz) gunzip $1;;
            *.tar) tar xvf $1;;
            *.tbz2) tar xvjf $1;;
            *.tgz) tar xvzf $1;;
            *.zip) unzip $1;;
            *.Z) uncompress $1;;
            *.7z) 7z x $1;;
            *.dmg) hdiutul mount $1;; # mount OS X disk images
            *) echo "'$1' cannot be extracted via >ex<";;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# -------------------------------------------------------------------
# any function from http://onethingwell.org/post/14669173541/any
# search for running processes
# -------------------------------------------------------------------
any() {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]] ; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any " >&2 ; return 1
    else
        ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
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
    # view man pages in Preview
    pman() { ps=`mktemp -t manpageXXXX`.ps ; man -t $@ > "$ps" ; open "$ps" ; }

    function pfd() {
        osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (target of window 1 as alias)
    end tell
EOF
    }

    function man-preview() {
        man -t "$@" | open -f -a Preview
    }

    # Change directory to the current Finder directory.
    function cdf() {
        cd "$(pfd)"
    }

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
function open_in_file_explorer() {
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
    alias 'dus=du -sckx * | sort -nr'
fi

# -------------------------------------------------------------------
# Mac only
# -------------------------------------------------------------------
if [[ $IS_MAC -eq 1 ]]; then
    # rebuild Launch Services to remove duplicate entries on Open With menu
    alias rebuildopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.fram ework/Support/lsregister -kill -r -domain local -domain system -domain user'

    emacsc() {
        # https://stackoverflow.com/questions/10171280/how-to-launch-gui-emacs-from-command-line-in-osx/26565655#26565655
        EMACSPATH=/Applications/Emacs.app/Contents/MacOS

        # Check if an emacs server is available
        # (by checking to see if it will evaluate a lisp statement)
        if ! (${EMACSPATH}/bin/emacsclient --eval "t"  2> /dev/null > /dev/null )
        then
            # There is no server available so,
            # Start Emacs.app detached from the terminal
            # and change Emac's directory to PWD
            # ------------------------------------------
            # Why use parens?
            # https://apple.stackexchange.com/questions/133087/how-to-prevent-the-application-launched-in-terminal-from-undesirably-exiting
            (nohup ${EMACSPATH}/Emacs --chdir "${PWD}" "${@}" 2>&1 > /dev/null &)
        else
            # The emacs server is available so use emacsclient
            if [ "$#" -eq  "0" ]
            then
                # There are no arguments, so
                # tell emacs to open a new window
                # ${EMACSPATH}/bin/emacsclient --eval "(list-directory \"${PWD}\")"
                ${EMACSPATH}/bin/emacsclient --eval "(dired \"${PWD}\")"
            else
                # There are arguments, so
                # tell emacs to open them
                ${EMACSPATH}/bin/emacsclient --no-wait "${@}"
            fi

            # Bring emacs to the foreground
            ${EMACSPATH}/bin/emacsclient --eval "(x-focus-frame nil)"
        fi
    }
fi

alias e=emacsc

# -------------------------------------------------------------------
# me
# -------------------------------------------------------------------
# -2 for color, || to attach to a current session or create a new session
alias tm='tmux -2 attach || tmux -2 new'
# force tmux to use 256 colors
# alias tmux='TERM=screen-256color-bce tmux'

if [[ $IS_MAC -eq 1 ]]; then
    # vim with no plugins
    alias vi='vim -u NONE'
fi

alias jformat='python -m json.tool'
# -------------------------------------------------------------------
# remote machines
# -------------------------------------------------------------------
alias seedbox='ssh jojojames@genesis.whatbox.ca'
alias syno='ssh -p 4000 james@jojobebe.noip.me'
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

# -------------------------------------------------------------------
# WH
# -------------------------------------------------------------------
alias redis_start='${EM_REDIS_HOME}/redis-server.sh start'

# -------------------------------------------------------------------
# TB
# -------------------------------------------------------------------
function tb_clean_app() {
    cd ~/Code/mobile-app/
    find . -d -name bin -print0 | xargs -0 rm -Rf
    find . -d -name obj -print0 | xargs -0 rm -Rf
    find . -d -name build -print0 | xargs -0 rm -Rf
    find . -d -name Build -print0 | xargs -0 rm -Rf
    rm -Rf packages
}
