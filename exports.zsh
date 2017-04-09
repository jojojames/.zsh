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

# Virtual Environment Stuff
if [[ -a /usr/libexec/java_home ]]; then
    export JAVA_HOME=`/usr/libexec/java_home -v1.8`
fi

export EDITOR=/usr/local/bin/mvim

# PATHS
user_bin=$HOME/.bin
local_bin=/usr/local/bin
sbin=/usr/local/sbin
heroku_bin=/usr/local/heroku/bin
opt_bin=/opt/local/bin
opt_sbin=/opt/local/sbin
cabal_bin=$HOME/.cabal/bin
rvm_bin=$HOME/.rvm/bin
cask_elisp_bin=$HOME/.cask/bin
rtags_bin=$HOME/.bin/rtags/bin
go_bin=/usr/local/go/bin

# Add to $PATH variable.
my_paths=$user_bin:$local_bin
language_paths=$go_bin:$cabal_bin:$cask_elisp_bin:$rvm_bin:$rtags_bin
tool_paths=$heroku_bin
system_paths=$opt_bin:$opt_sbin:$sbin

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

    xamp_bin=/Applications/xampp/xamppfiles/bin
    makeinfo_bin=/usr/local/Cellar/texinfo/6.3/bin

    llvm_bin=/usr/local/Cellar/llvm/4.0.0/bin
    export LIBCLANG_LIBDIR=/usr/local/Cellar/llvm/4.0.0/lib

    osx_paths=$makeinfo_bin:$llvm_bin:$xamp_bin
    export PATH=$osx_paths:$PATH

    dropbox_path=$HOME/Dropbox
    if [ -d $dropbox_path ]; then
        if [[ $USER -eq "jnguyen" ]]; then
            source $dropbox_path/Shell/tb.zsh
        else
            source $dropbox_path/Shell/wh.zsh
        fi
    fi
fi
