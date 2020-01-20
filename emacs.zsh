# -------------------------------------------------------------------
# Emacs
# -------------------------------------------------------------------
if [[ $IS_MAC -eq 1 ]]; then
    alias emacsclient=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
fi

emacsclient2() {
    if [ "$#" -eq "0" ]
    then
        dired
    else
        emacsclient --no-wait --quiet "${@}"
    fi
}

kill_emacs_server() {
    # Kill emacs --daemon with name 'term'.
    kill $(ps aux | grep "[e]macs.*term$" | awk '{print $2}')
}

magit() {
    emacsclient -n -e "(magit-status)"
}

dired() {
    emacsclient -n -e "(dired-jump)"
}

alias e=emacsclient2

# https://www.reddit.com/r/emacs/comments/7f62pn/tramp_hang_after_sending_password/
# Emacs tramp fix
# https://wxchen.wordpress.com/2012/05/20/getting-tramp-in-emacs-to-work-with-zsh-as-default-shell/
if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
    PS1='$ '
fi
