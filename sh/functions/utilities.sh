function clean_home(){
	rm -rf ~/.{AndroidStudio1.2,adobe,cordova,dbus,emacs.d,gstreamer-0.10,ionic,macromedia,mozilla,node-gyp,nvimlog,pki,subversion,Trash}
	if [[ $(uname) == "Darwin" ]]; then
		if [[ -d "$HOME/Desktop" ]]; then
			/bin/chmod -a "group:everyone deny delete" "$HOME/Desktop"
			rm -rf "$HOME/Desktop"
		fi
	fi
}

function clean_recursive(){
	find -iname '.DS_Store' -delete
}

function findall(){
	ps -A | grep "$*"
}

function cleanall(){
	findall "$*" | awk '{print $1}' | head -n-1 | xargs -I{} kill {}
}

function command_exists(){
	command -v "$1" 2>&1 >/dev/null ;
}

# Produces a recursive count of all files in each subdirectory
function count_files(){
	find $1 -maxdepth 1 -type d 2>/dev/null | while read d; do
		find -L "$d" -type f 2>/dev/null | wc -l | tr -d '\n';
		echo $'\t'$d
	done|sort -n
}

# Shows what would have been in the bash prompt were I not a minimalist
function p(){
	echo "$USER@$HOSTNAME:$(pwd) "
}

# Show the prompt if we're not on a local device
function prmpt(){
	[ ! -f $XDG_DATA_HOME/localdevice ] && p
}

# Prints the total size taken by files with the extension provided
function sizefromtype(){
	find -iname "*.$@" -print0 | du --files0-from - -c -sh | tail -1 | sed 's/\([^ tab]\+\).*/\1 /'
}

function set_title(){
	[[ -z "$TMUX" ]] && echo -ne "\033]0;$*\007" || tmux rename-window "$*"
}

function reset_title(){
	[[ -z "$VIRTUAL_ENV_NAME" ]] && set_title "$HOST" || set_title "$VIRTUAL_ENV_NAME"
}

function s(){
	set_title "$*"
	ssh "$@"
	reset_title
}

if ! [[ -z "$ZSH_VERSION" ]]; then
	function _pip_completion {
		local words cword
		read -Ac words
		read -cn cword
		reply=( $( COMP_WORDS="$words[*]" \
		           COMP_CWORD=$(( cword-1 )) \
		           PIP_AUTO_COMPLETE=1 $words[1] ) )
	}
	compctl -K _pip_completion pip
	compctl -K _pip_completion pip2
elif ! [[ -z "$BASH_VERSION" ]]; then
	_pip_completion() {
		COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
		               COMP_CWORD=$COMP_CWORD \
		               PIP_AUTO_COMPLETE=1 $1 ) )
	}
	complete -o default -F _pip_completion pip
	complete -o default -F _pip_completion pip2
fi

function compdefas () {
  local a
  a="$1"
  shift
  compdef "$_comps[$a]" "${(@)*}=$a"
}
compdefas ssh s
