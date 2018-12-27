# Don't create additional files during tar.
export COPYFILE_DISABLE=true

# Disable automatic renaming.
export DISABLE_AUTO_TITLE="true"

# Setup terminal
export TERM=xterm-256color

# This resolves issues install the mysql, postgres
# and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

export LESS='--ignore-case --raw-control-chars'
export PAGER='less'

# CTAGS Sorting in VIM/Emacs is better behaved with this in place
export LC_COLLATE=C
# https://stackoverflow.com/questions/11287564/getting-sed-error-illegal-byte-sequence-in-bash
export LC_ALL=C

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
local_bin=/usr/local/bin
local_sbin=/usr/local/sbin
heroku_bin=/usr/local/heroku/bin
opt_bin=/opt/local/bin
opt_sbin=/opt/local/sbin
usr_sbin=/usr/sbin
sbin=/sbin
cabal_bin=$HOME/.cabal/bin
rvm_bin=$HOME/.rvm/bin
cask_elisp_bin=$HOME/.cask/bin
rtags_bin=$HOME/.bin/rtags/bin
go_bin=/usr/local/go/bin
gopath_bin=$GOBIN
node_bin=$N_BIN
rust_bin=$HOME/.cargo/bin
python_bin=/usr/local/opt/python/libexec/bin

# Add to $PATH variable.
my_paths=$node_bin:$user_bin:$local_bin
language_paths=$go_bin:$cabal_bin:$cask_elisp_bin:$rvm_bin:$rtags_bin:$rust_bin:$python_bin
tool_paths=$heroku_bin:$gopath_bin
system_paths=$opt_bin:$opt_sbin:$local_sbin:$sbin:$usr_sbin

export PATH=$my_paths:$language_paths:$tool_paths:$system_paths:$PATH

if [[ $IS_LINUX -eq 1 ]]; then
    love_path=$HOME/Code/love/src
    fzf_path=$HOME/.fzf/bin
    export PATH=$fzf_path:$love_path:$PATH
fi

if [[ $IS_MAC -eq 1 ]]; then
    # Homebrew Analytics Opt Out
    # https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
    export HOMEBREW_NO_ANALYTICS=1

    export XCODE_BUILD=$HOME/Library/Developer/Xcode/DerivedData

    makeinfo_bin=/usr/local/Cellar/texinfo/6.3/bin

    # /usr/local/opt/llvm/bin points to ~> /usr/local/Cellar/llvm/4.0.0/bin
    llvm_bin=/usr/local/opt/llvm/bin
    # /usr/local/opt/llvm/lib points to ~> /usr/local/Cellar/llvm/4.0.0/lib
    export LIBCLANG_LIBDIR=/usr/local/opt/llvm/lib

    osx_paths=$makeinfo_bin:$llvm_bin
    export PATH=$PATH:$osx_paths

    if [[ $USER == "james" ]]; then
        # Android
        export ANDROID_HOME=/Applications/adt-bundle-mac-x86_64-20140702/sdk
        android_tools=$ANDROID_HOME/tools
        android_platform_tools=$ANDROID_HOME/platform-tools
        export PATH=$android_tools:$android_platform_tools:$PATH

        # Cocos
        export COCOS_CONSOLE_ROOT=$HOME/Code/cocos2d-x/tools/cocos2d-console/bin
        export PATH=$COCOS_CONSOLE_ROOT:$PATH
        export COCOS_X_ROOT=$HOME/Code
        export PATH=$COCOS_X_ROOT:$PATH
        export COCOS_TEMPLATES_ROOT=$HOME/Code/cocos2d-x/templates
        export PATH=$COCOS_TEMPLATES_ROOT:$PATH
    fi
fi
