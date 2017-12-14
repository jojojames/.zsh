# Use Emacs bindings.
bindkey -e

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init() {
        echoti smkx
    }
    function zle-line-finish() {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# Make C-p and C-n behave like Up/Down arrows.
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

# [Space] - Do history expansion.
bindkey ' ' magic-space

# This should be called beforehand.
# This is currently called in completion.zsh.
# zmodload -i zsh/complist
# https://www.zsh.org/mla/users/2009/msg01018.html
# Accept completion and enter to avoid having to press RET twice.
bindkey -M menuselect '^M' .accept-line
