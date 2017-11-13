export ZSH_CONFIG=TRUE

# load the XDG basedirs and aliases
    XDG_CONFIG_HOME="$(dirname ${(%):-%x})/.."
    source "$XDG_CONFIG_HOME/sh/xdg.sh"



# GNU coreutils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"



# Chris' bootstrap.sh code
export PATH=$XDG_BIN_HOME:${PATH}
for file in "$XDG_CONFIG_HOME/sh/utilities/"*.*; do
	base=$(basename $(basename "$file" .sh) .py)
	[[ -e "$XDG_BIN_HOME/$base" ]] || ln -s "$file" "$XDG_BIN_HOME/$base"
	# echo "Added utility $base"
done


# Append Additional Executables to $PATH
[ -f "$XDG_CONFIG_HOME"/sh/path.sh ] && . $XDG_CONFIG_HOME/sh/path.sh



zstyle ':completion:*' completer _expand _complete _ignored _approximate
autoload -Uz compinit bashcompinit
compinit
bashcompinit
# End of lines added by compinstall



# Load Functions
    [ -d $HOME/.config/sh/functions/ ] &&
        for f in $HOME/.config/sh/functions/*; do . $f; done



# Allow interactive comments
set -k



# zsh
export HISTFILE="$ZDOTDIR/zsh_history"
export HISTCONTROL=ignoreboth   # Ignore duplicate/blank lines in history
export HISTSIZE=100000          # 100K command in history file
export SAVEHIST=100000          # 100K in shell
setopt inc_append_history       # Save every command before it is executed
setopt share_history            # Share history between shells



# PS1
source "$HOME/programs/zsh-git-prompt/zshrc.sh"    # This program comes from: https://github.com/olivierverdier/zsh-git-prompt
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[green]%}"           # Make branch name green
# Make PS1 look something like (ebeacon) [21:09:17 development (master|✔)]% ls -lA
function zle-line-init zle-keymap-select {
    if [[ ! -z $VIRTUAL_ENV_NAME ]] then
        venvname="($VIRTUAL_ENV_NAME)"
    elif [[ ! -z $VIRTUAL_ENV ]] then
        venvname="(${VIRTUAL_ENV##*/})"
    else
        venvname=''
    fi
    num_jobs='%1(j.%j.)'
    clock='%*'
    current_dir='%c'
    git_status='$(git_super_status)'
    PROMPT=$venvname'['$clock' %B'$current_dir' %b'$git_status']%F{blue}'$num_jobs'%f%# '
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

export DEV_DIR="$HOME/development"



# Editors
export VISUAL=nvim
export EDITOR="$VISUAL"


# Run in emacs mode
bindkey -e


# Docker
da() { docker attach "$COMPOSE_PROJECT_NAME"_"$1"_"1" "${@:2}"; }



# make zsh respect non-alphanumerical chars as word break chars
autoload -U select-word-style
select-word-style bash



# new zle widget definitions

delete-word-ignoring-wordchars () {  # break up words when there are symbols
    local WORDCHARS=
    zle delete-word
}

zle -N delete-word-ignoring-wordchars



# key bindings
bindkey "^[[3~" delete-char
bindkey "^[[30~" delete-word-ignoring-wordchars

# echo colors
# ( x=`tput op` y=`printf %$((${COLUMNS}-6))s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done; )


source ~/.config/sh/aliases.sh


# Pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


# Python
export PYTHONDONTWRITEBYTECODE=1
