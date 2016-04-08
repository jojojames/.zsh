#########################################
# me
#########################################
# http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/
source ~/.zsh/bindkeys.zsh
source ~/.zsh/checks.zsh
source ~/.zsh/colors.zsh
source ~/.zsh/setopts.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/history.zsh
source ~/.zsh/zsh_hooks.zsh

#########################################
# https://github.com/rupa/z
#########################################
. ~/.zsh/z.sh

#########################################
# gpg security
#########################################
[ -f ~/.gpg-agent-info ] && source ~/.gpg-agent-info
if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
  export GPG_AGENT_INFO
else
  eval $( gpg-agent --daemon --write-env-file ~/.gpg-agent-info )
fi
