# Append Additional Executables to $PATH
# Don't re-source inside a VENV
  [[ -z "$VIRTUAL_ENV" ]] || return

function add() {
  [[ -d "$1" ]] && [[ :$PATH: != *:"$1":* ]] && export PATH="$1:$PATH"
}

add "/usr/local/bin"
add "/usr/local/opt/coreutils/libexec/gnubin"
add "$HOME/Library/Android/sdk/tools"
add "$HOME/Library/Android/sdk/platform-tools"
add "$HOME/Library/Python/2.7/bin"
add "$HOME/Library/Python/3.6/bin"
add "$XDG_CONFIG_HOME/cargo/bin"
add "$XDG_CONFIG_HOME/sh/utilities"
add "$HOME/.local/bin"

unset add
#     export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export NODE_PATH="$HOME/.local/lib/node_modules"
