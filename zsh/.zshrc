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




# zstyle ':completion:*' completer _expand _complete _ignored _approximate
# autoload -Uz compinit bashcompinit
# compinit
# bashcompinit
# End of lines added by compinstall






zstyle ':completion:*' completer _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' glob 1
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' match-original both
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+r:|[._-]=** r:|=** l:|=*'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=1
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt 'correcting from %e errors'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' users

# From Benjamin
zstyle -e ':completion:*:hosts' hosts 'reply=(
 ${=${=${=${${(f)"$(cat {/etc/ssh/ssh_,~/.ssh/}known_hosts(|2)(N) 2> /dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
 ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2> /dev/null))"}%%(\#${_etc_host_ignores:+|${(j:|:)~_etc_host_ignores}})*}
 ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
 ${=${${${${(@M)${(f)"$(cat ~/.local/share/ssh/config.d/clients 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'
zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

zstyle :compinstall filename "$XDG_CONFIG_HOME/zsh/.zshrc"

[[ -d /usr/local/share/zsh-completions ]] && fpath=(/usr/local/share/zsh-completions $fpath)

autoload -Uz compinit bashcompinit promptinit
compinit
bashcompinit











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
setopt INC_APPEND_HISTORY       # Save every command before it is executed
setopt SHARE_HISTORY            # Share history between shells
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS         # Do not record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE        # Do not record entries that begin with a space



# PS1
source "$HOME/programs/zsh-git-prompt/zshrc.sh"    # This program comes from: https://github.com/starcraftman/zsh-git-prompt
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

# Pipenv
eval "$(pipenv --completion)"

# Direnv
eval "$(direnv hook zsh)"


# Android dev
export JAVA_HOME="$(/usr/libexec/java_home)"
export ANDROID_HOME="/Users/nathanael/Library/Android/sdk"
export ANDROID_SDK_ROOT="/Users/nathanael/Library/Android/sdk"


# Add Ionata AWS commands
source "$DEV_DIR/scripts-aws/manage.sh"

# Add Flutter to path
export PATH="$PATH":"$HOME/.pub-cache/bin"
