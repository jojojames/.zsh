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
if [[ "$TERM" == "dumb" || "$TERM" == "tramp" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    PS1='$'
    PROMPT='$ '
fi

# Copied from:
# https://github.com/akermu/emacs-libvterm/blob/master/etc/emacs-vterm-zsh.sh

# Completely clear the buffer. With this, everything that is not on screen
# is erased.
if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
    alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'

    # Some of the most useful features in emacs-libvterm require shell-side
    # configurations. The main goal of these additional functions is to enable the
    # shell to send information to `vterm` via properly escaped sequences. A
    # function that helps in this task, `vterm_printf`, is defined below.

    function vterm_printf() {
        if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
            # Tell tmux to pass the escape sequences through
            printf "\ePtmux;\e\e]%s\007\e\\" "$1"
        elif [ "${TERM%%-*}" = "screen" ]; then
            # GNU screen (screen, screen-256color, screen-256color-bce)
            printf "\eP\e]%s\007\e\\" "$1"
        else
            printf "\e]%s\e\\" "$1"
        fi
    }

    # With vterm_cmd you can execute Emacs commands directly from the shell.
    # For example, vterm_cmd message "HI" will print "HI".
    # To enable new commands, you have to customize Emacs's variable
    # vterm-eval-cmds.
    vterm_cmd() {
        local vterm_elisp
        vterm_elisp=""
        while [ $# -gt 0 ]; do
            vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
            shift
        done
        vterm_printf "51;E$vterm_elisp"
    }


    # This is to change the title of the buffer based on information provided by the
    # shell. See, http://tldp.org/HOWTO/Xterm-Title-4.html, for the meaning of the
    # various symbols.
    autoload -U add-zsh-hook
    add-zsh-hook -Uz chpwd (){ print -Pn "\e]2;%m:%2~\a" }

    # Sync directory and host in the shell with Emacs's current directory.
    # You may need to manually specify the hostname instead of $(hostname) in case
    # $(hostname) does not return the correct string to connect to the server.
    #
    # The escape sequence "51;A" has also the role of identifying the end of the
    # prompt
    vterm_prompt_end() {
        vterm_printf "51;A$(whoami)@$(hostname):$(pwd)";
    }
    setopt PROMPT_SUBST
    PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
fi
