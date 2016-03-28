source ~/.zsh/checks.zsh
source ~/.zsh/colors.zsh
source ~/.zsh/setopts.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/bindkeys.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/history.zsh
source ~/.zsh/zsh_hooks.zsh
source  ${HOME}/.zsh/z.sh

# ZSH=$HOME/.oh-my-zsh
# #ZSH_THEME="random"
# ZSH_THEME="af-magic"
# plugins=(git osx brew rsync autojump)
# source $ZSH/oh-my-zsh.sh
# 
# #JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home/jre
# #export JAVA_HOME=`/usr/libexec/java_home -v1.6`
# export JAVA_HOME=`/usr/libexec/java_home -v1.7`
# 
# export EDITOR=/usr/local/bin/mvim
# export ANDROID_HOME=/Applications/adt-bundle-mac-x86_64-20140702/sdk
# export XCODE_BUILD=$HOME/Library/Developer/Xcode/DerivedData
# 
# # Disable sharing history.
# setopt NO_SHARE_HISTORY
# # Don't create additional files during tar.
# COPYFILE_DISABLE=true 
# 
# # PATHS
# USER_BIN=$HOME/.bin
# LOCAL_BIN=/usr/local/bin
# SBIN_BIN=/usr/local/sbin
# HEROKU=/usr/local/heroku/bin
# ANDROID_TOOLS=$ANDROID_HOME/tools
# ANDROID_PLATFORM_TOOLS=$ANDROID_HOME/platform-tools
# POSTGRES=/Library/PostgreSQL/9.2/bin
# OPT_BIN=/opt/local/bin
# OPT_SBIN=/opt/local/sbin
# XAMP=/Applications/xampp/xamppfiles/bin
# CABAL=$HOME/.cabal/bin
# REDIS=/usr/local/redis-2.8.7/bin
# 
# export OMNISHARP=$HOME/Developer/omnisharp-server/OmniSharp/bin/Debug/
# export GOBIN=/usr/local/go/bin
# 
# ##############
# # BEGIN: WORK RELATED
# ##############
# export EMPROJECTROOT=$HOME/Developer/emroot
# export EM_SOFTWARE=/usr/local
# export EM_REPO=${EMPROJECTROOT}/EveryoneMessages
# 
# export EM_REDIS_HOME=${EMPROJECTROOT}/redis
# export EM_REDIS_DATA=${EMPROJECTROOT}/redis/data
# 
# # GRADLE
# export GRADLE_221=/usr/local/gradle-2.2.1
# export GRADLE_HOME=${GRADLE_221}
# 
# # GRAILS
# # EM
# export GRAILS_211=/usr/local/grails-2.1.1
# 
# # WHOSHERE
# export GRAILS_221=/usr/local/grails-2.2.1
# 
# export GRAILS_HOME=${GRAILS_211}
# 
# CASSANDRA=/usr/local/Cassandra/apache-cassandra-2.0.7/bin
# ERLANG=${EMPROJECTROOT}/erlang/bin
# 
# export JAVA_OPTS="-Xms1g -Xmx2g -XX:MaxPermSize=2g"
# export WHPROJECTROOT=$HOME/Developer/whoshere
# 
# export MONOTOUCH_BIN=/Developer/MonoTouch/usr/bin
# export MONODROID_BIN=/Developer/MonoAndroid/usr/bin
# 
# ##############
# # END: WORK RELATED
# ##############
# 
# export PATH=$USER_BIN:$LOCAL_BIN:$GRAILS_HOME/bin:$GRADLE_HOME:$ERLANG:$CABAL:$SBIN_BIN:$HEROKU:$ANDROID_TOOLS:$ANDROID_PLATFORM_TOOLS:$MONOTOUCH_BIN:$MONODROID_BIN:$POSTGRES:$OPT_BIN:$OPT_SBIN:$XAMP:$CASSANDRA:$REDIS:$PATH
# 
# DOCTORJS=/usr/local/lib/jsctags
# NODE_PATH='$DOCTORJS:${NODE_PATH}'
# 
# # Aliases
# # -2 for color, || to attach to a current session or create a new session
# alias tm='tmux -2 attach || tmux -2 new'
# # vim with no plugins
# alias vi='vim -u NONE'
# alias jformat='python -m json.tool'
# alias seedbox='ssh jojojames@vanilla.whatbox.ca'
# alias syno='ssh -p 4000 james@jojobebe.noip.me'
# 
# # Status Line
# PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
# 
# # disable automatica renaming
# export DISABLE_AUTO_TITLE="true"
# 
# ### Added by the Heroku Toolbelt
# export PATH="/usr/local/heroku/bin:$PATH"
# 
# # source ruby/rvm/rails
# 
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
