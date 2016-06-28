# Setup terminal, and turn on colors
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

export LESS='--ignore-case --raw-control-chars'
export PAGER='less'

# CTAGS Sorting in VIM/Emacs is better behaved with this in place
export LC_COLLATE=C 

# Virtual Environment Stuff

# Currently this path is appended to dynamically when picking a ruby version
# zshenv has already started PATH with rbenv so append only here
# export PATH=$PATH~/bin:/usr/local/bin:/usr/local/sbin:~/bin

#JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home/jre
#export JAVA_HOME=`/usr/libexec/java_home -v1.6`
export JAVA_HOME=`/usr/libexec/java_home -v1.7`

export EDITOR=/usr/local/bin/mvim
export ANDROID_HOME=/Applications/adt-bundle-mac-x86_64-20140702/sdk
export XCODE_BUILD=$HOME/Library/Developer/Xcode/DerivedData

# PATHS
USER_BIN=$HOME/.bin
LOCAL_BIN=/usr/local/bin
SBIN_BIN=/usr/local/sbin
HEROKU=/usr/local/heroku/bin
ANDROID_TOOLS=$ANDROID_HOME/tools
ANDROID_PLATFORM_TOOLS=$ANDROID_HOME/platform-tools
OPT_BIN=/opt/local/bin
OPT_SBIN=/opt/local/sbin
XAMP=/Applications/xampp/xamppfiles/bin
CABAL=$HOME/.cabal/bin
REDIS=/usr/local/redis-2.8.7/bin
RVM_BIN=$HOME/.rvm/bin
CASK_ELISP_BIN=$HOME/.cask/bin
RTAGS=$HOME/.bin/rtags/bin

LLVM_BIN=/opt/local/libexec/llvm-3.9/bin
# /usr/local/opt/llvm/bin
export LIBCLANG_LIBDIR=/opt/local/libexec/llvm-3.9/lib

export OMNISHARP=$HOME/Developer/omnisharp-server/OmniSharp/bin/Debug/
export GOBIN=/usr/local/go/bin

##############
# BEGIN: WORK RELATED
##############
export EMPROJECTROOT=$HOME/Developer/emroot
export EM_SOFTWARE=/usr/local
export EM_REPO=${EMPROJECTROOT}/EveryoneMessages

export EM_REDIS_HOME=${EMPROJECTROOT}/redis
export EM_REDIS_DATA=${EMPROJECTROOT}/redis/data

# GRADLE
export GRADLE_221=/usr/local/gradle-2.2.1
export GRADLE_HOME=${GRADLE_221}

# GRAILS
export GRAILS_211=/usr/local/grails-2.1.1
export GRAILS_221=/usr/local/grails-2.2.1
export GRAILS_HOME=${GRAILS_221}

CASSANDRA=/usr/local/Cassandra/apache-cassandra-2.0.7/bin
ERLANG=${EMPROJECTROOT}/erlang/bin

export JAVA_OPTS="-Xms1g -Xmx2g -XX:MaxPermSize=2g"
export WHPROJECTROOT=$HOME/Developer/whoshere

export MONOTOUCH_BIN=/Developer/MonoTouch/usr/bin
export MONODROID_BIN=/Developer/MonoAndroid/usr/bin

##############
# END: WORK RELATED
##############

export PATH=$RTAGS:$USER_BIN:$RVM_BIN:$OPT_BIN:$OPT_SBIN:$LLVM_BIN:$CASK_ELISP_BIN:$LOCAL_BIN:$GRAILS_HOME/bin:$GRADLE_HOME:$ERLANG:$CABAL:$SBIN_BIN:$HEROKU:$ANDROID_TOOLS:$ANDROID_PLATFORM_TOOLS:$MONOTOUCH_BIN:$MONODROID_BIN:$XAMP:$CASSANDRA:$REDIS:$PATH

DOCTORJS=/usr/local/lib/jsctags
NODE_PATH='$DOCTORJS:${NODE_PATH}'

# don't create additional files during tar
COPYFILE_DISABLE=true

# disable automatic renaming
export DISABLE_AUTO_TITLE="true"

# Homebrew Analytics Opt Out
# https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
export HOMEBREW_NO_ANALYTICS=1
