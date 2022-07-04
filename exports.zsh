# Don't create additional files during tar.
export COPYFILE_DISABLE=true

# Disable automatic renaming.
export DISABLE_AUTO_TITLE="true"

# Only set xterm-256color if we're not being started or connected from emacs.
# We need this because emacs' tramp doesn't behave well with zsh prompts.
# In emacs.zsh, we check the $TERM variable and make the prompt dumb so emacs
# can better process it. Avoid setting $TERM here in order to do so.
if ! [[ "$TERM" == "dumb" || "$TERM" == "tramp" ]]
then
    export TERM=xterm-256color
fi

# This resolves issues install the mysql, postgres
# and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

export LESS='--ignore-case --raw-control-chars'
export PAGER='less'

# Node Version Manager
# npm install -g n
export N_PREFIX=$HOME/.n
export N_BIN=$N_PREFIX/bin

# FZF
export FZF_DEFAULT_COMMAND='(git ls-files --exclude-standard --others --cached ||
        find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
           sed s/^..//) 2> /dev/null'

# Virtual Environment Stuff
if [[ -a /usr/libexec/java_home ]]; then
    export JAVA_HOME=`/usr/libexec/java_home -v1.8`
fi

# Specify $MAILDIR for notmuch and ~maybe~ mu.
export MAILDIR=$HOME/Mail

export EDITOR=vim

# Golang
export GOPATH=$HOME/Code/go

# https://stackoverflow.com/questions/18149601/go-install-always-fails-no-install-directory-outside-gopath
export GOBIN=$GOPATH/bin

# PATHS
user_bin=$HOME/.bin
rvm_bin=$HOME/.rvm/bin
cabal_bin=$HOME/.cabal/bin
cask_elisp_bin=$HOME/.cask/bin
rust_bin=$HOME/.cargo/bin

go_bin=/usr/local/go/bin
gopath_bin=$GOBIN
node_bin=$N_BIN
python_bin=/usr/local/opt/python/libexec/bin

local_bin=/usr/local/bin
local_sbin=/usr/local/sbin
opt_bin=/opt/local/bin
opt_sbin=/opt/local/sbin
sbin=/sbin
usr_sbin=/usr/sbin

home_paths=$user_bin:$rvm_bin:$cabal_bin:$cask_elisp_bin:$rust_bin
lang_paths=$go_bin:$gopath_bin:$node_bin:$python_bin
system_paths=$local_bin:$local_sbin:$opt_bin:$opt_sbin:$sbin:$usr_sbin

export PATH=$home_paths:$lang_paths:$system_paths:$PATH

if [[ $IS_LINUX -eq 1 ]]; then
    fzf_path=$HOME/.fzf/bin
    export PATH=$fzf_path:$PATH
fi

if [[ $IS_MAC -eq 1 ]]; then
    # Homebrew Analytics Opt Out
    # https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
    export HOMEBREW_NO_ANALYTICS=1

    export XCODE_BUILD=$HOME/Library/Developer/Xcode/DerivedData

    makeinfo_bin=/usr/local/Cellar/texinfo/6.3/bin
    local_brew_bin=~/.homebrew/bin

    # /usr/local/opt/llvm/bin points to ~> /usr/local/Cellar/llvm/4.0.0/bin
    llvm_bin=/usr/local/opt/llvm/bin
    # /usr/local/opt/llvm/lib points to ~> /usr/local/Cellar/llvm/4.0.0/lib
    export LIBCLANG_LIBDIR=/usr/local/opt/llvm/lib

    osx_paths=$makeinfo_bin:$llvm_bin:$local_brew_bin
    export PATH=$PATH:$osx_paths

    if [[ $USER == "james" ]]; then
        # Android
        export ANDROID_HOME=/Applications/adt-bundle-mac-x86_64-20140702/sdk
        android_tools=$ANDROID_HOME/tools
        android_platform_tools=$ANDROID_HOME/platform-tools
        export PATH=$android_tools:$android_platform_tools:$PATH
    fi

    if [[ $USER == "jameshn" ]]; then
        # Use provided git instead of system git.
        # This is here instead of yt.zsh because we need this set up before
        # we do the repository clone (for yt.zsh).
        export PATH=/usr/local/git/current/bin:$PATH
    fi
fi

if [[ $IS_BSD -eq 1 ]]; then
    export PATH=/home/james/.local/bin:$PATH
fi
