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
