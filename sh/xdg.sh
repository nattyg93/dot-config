# XDG dirs first
    export XDG_CONFIG_HOME=$HOME/.config
    export XDG_DATA_HOME=$HOME/.local/share
    export XDG_BIN_HOME=$HOME/.local/bin
    export XDG_LIB_HOME=$HOME/.local/lib
    export XDG_CACHE_HOME=$HOME/.cache

# Environment-variable respecting programs
	export ADB_VENDOR_KEYS="$XDG_DATA_HOME/android/.android"
	export ANDROID_SDK_HOME="$XDG_DATA_HOME/android"
	export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
	export COMPOSER_HOME="$XDG_DATA_HOME/composer"
	export COMPOSER_CACHE_DIR="$XDG_CACHE_HOME/composer"
	export GEM_HOME="$HOME/.local/lib/gems"
	export GEM_PATH="$HOME/.local/bin"
	export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
	export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
	export GRADLE_USER_HOME="$XDG_CACHE_HOME/gradle"
	export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
	export HISTFILE="$XDG_DATA_HOME/bash/history"
	export HOMERC="$XDG_CONFIG_HOME/htop/htoprc"
	export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie/"
	# export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
	export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
	export KDEDIR="$XDG_CONFIG_HOME/kde"
	export KDEHOME="$XDG_CONFIG_HOME/kde"
	export LESSHISTFILE="$XDG_DATA_HOME/less/history"
	export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql/history"
	export npm_config_userconfig="$XDG_CONFIG_HOME/npm/npmrc"
	export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
	export PENTADACTYL_INIT=":source $XDG_CONFIG_HOME/pentadactyl/pentadactylrc"
	export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"
	export PIP_LOG_FILE="$XDG_DATA_HOME/pip/log"
	export PSQLRC="$XDG_CONFIG_HOME/psql/psqlrc"
	export PSQL_HISTORY="$XDG_DATA_HOME/psql/history"
	export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
	export PYLINTHOME="$XDG_DATA_HOME/pylint"
	export PYLINTRC="$XDG_CONFIG_HOME/pylint/pylintrc"
	export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
	export RXVT_SOCKET="$XDG_RUNTIME_DIR/urxvtd.sock"
	export TERMINFO="$XDG_CONFIG_HOME/terminfo"
	export VAGRANT_DOTFILE_PATH="$XDG_DATA_HOME/vagrant"
	export VAGRANT_HOME="$XDG_DATA_HOME/vagrant"
	export VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc"
	export VIMPERATOR_INIT=":source $XDG_CONFIG_HOME/vimperator/vimperatorrc"
	export VIMPERATOR_RUNTIME="$XDG_CONFIG_HOME/vimperator"
	export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
	export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Alias respecting programs
	alias ag="ag -p $XDG_CONFIG_HOME/ag/agignore"
	alias emacs="emacs -q --load $XDG_CONFIG_HOME/emacs/emacsrc"
#	alias firefox="firefox -profile $XDG_CONFIG_HOME/firefox"
	export BROWSER="firefox -profile $XDG_CONFIG_HOME/firefox"
	alias mutt="mutt -F $XDG_CONFIG_HOME/mutt/muttrc"
	alias ncmpcpp="ncmpcpp -c $XDG_CONFIG_HOME/ncmpcpp/config"
	alias startx="startx $XDG_CONFIG_HOME/X11/xinitrc"
	alias rtorrent="rtorrent -n -o import=$XDG_CONFIG_HOME/rtorrent/conf"
	alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"

# MacOS specific
	# defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"  # Note: only needs to be run once
