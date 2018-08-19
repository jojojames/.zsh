# -------------------------------------------------------------------
# Emacs
# -------------------------------------------------------------------
# alias et='emacsclient -a "" -t'
# alias eg='emacsclient -a "" -c'

em_gui() {
    if [ "$#" -eq "0" ]
    then
        emacsclient --eval "(switch-to-buffer \"*scratch*\")"
    else
        emacsclient -n "${@}"
    fi
}

eg() {
    # If called inside Emacs, open in the same Emacs instance.
    # If called a terminal, use emacsclient from a gui frame.
    if [ ! "$EMACS" = "" ]
    then
        em_gui "${@}"
    else
        if [ "$#" -eq "0" ]
        then
            emacsclient -a "" -c -n --eval "(switch-to-buffer \"*scratch*\")"
        else
            emacsclient -a "" -c -n "${@}"
        fi
    fi
}

et() {
    # If called inside Emacs, behaves the same as eg.
    # If called inside a terminal, use emacsclient from inside the terminal.
    if [ ! "$EMACS" = "" ]
    then
        em_gui "${@}"
    else
        if [ "$#" -eq "0" ]
        then
            emacsclient -a "" -t --eval "(switch-to-buffer \"*scratch*\")"
        else
            emacsclient -a "" -t "${@}"
        fi
    fi
}

kill_emacs_server() {
    # Kill emacs --daemon with name 'term'.
    kill $(ps aux | grep "[e]macs.*term$" | awk '{print $2}')
}

alias e=eg
