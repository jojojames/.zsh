# Don't create additional files during tar.
export COPYFILE_DISABLE=true

# Disable automatic renaming.
export DISABLE_AUTO_TITLE="true"

# Homebrew Analytics Opt Out
# https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

# Setup terminal
export TERM=xterm-256color

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
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
export XCODE_BUILD=$HOME/Library/Developer/Xcode/DerivedData

# PATHS
user_bin=$HOME/.bin
local_bin=/usr/local/bin
sbin=/usr/local/sbin
heroku_bin=/usr/local/heroku/bin
opt_bin=/opt/local/bin
opt_sbin=/opt/local/sbin
xamp_bin=/Applications/xampp/xamppfiles/bin
cabal_bin=$HOME/.cabal/bin
rvm_bin=$HOME/.rvm/bin
cask_elisp_bin=$HOME/.cask/bin
rtags_bin=$HOME/.bin/rtags/bin
go_bin=/usr/local/go/bin
llvm_bin=/opt/local/libexec/llvm-3.9/bin

# /usr/local/opt/llvm/bin
export LIBCLANG_LIBDIR=/opt/local/libexec/llvm-3.9/lib

# Add to $PATH variable.
my_paths=$user_bin:$local_bin
language_paths=$go_bin:$cabal_bin:$cask_elisp_bin:$rvm_bin:$rtags_bin
tool_paths=$llvm_bin:$xamp_bin:$heroku_bin
system_paths=$opt_bin:$opt_sbin:$sbin

export PATH=$my_paths:$language_paths:$tool_paths:$system_paths:$PATH

if [[ $IS_LINUX -eq 1 ]]; then
    love_path=$HOME/Code/love/src
    fzf_path=$HOME/.fzf/bin
    export PATH=$fzf_path:$love_path:$PATH
fi

if [[ $IS_MAC -eq 1 ]]; then
    dropbox_path=$HOME/Dropbox
    if [ -d $dropbox_path ]; then
        if [[ $USER -eq "jnguyen" ]]; then
            source $dropbox_path/Shell/tb.zsh
        else
            source $dropbox_path/Shell/wh.zsh
        fi
    fi
fi
