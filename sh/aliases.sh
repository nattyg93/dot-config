alias v='$(_get_editor) '
alias ppn=~/.local/bin/print_project_directory_name.sh
alias av="source ~/.local/bin/activate_venv.sh"
alias mkvenv="venv_manager mkvenv"
compdef '_files -W "$DEV_DIR"' venv_manager
alias wq="venv_manager workon"
alias agpy="ag -G \".*\.py\""
if [ -d "/usr/local/opt/coreutils" ]; then
    alias ls="ls --color"
else
    alias ls="ls -G"
fi

alias l="ls -lAh"
alias vim=nvim
# Docker
alias dc='docker-compose'
alias dcl="docker-compose logs -f --tail=50"
alias dcr="docker-compose restart"
alias dpsa='docker ps -a'
alias dm='docker-compose exec web /var/www/venv/bin/python manage.py'
alias dp='docker-compose exec db psql -Udjango django'
alias dpi='docker-compose exec db psql -Udjango django < dj_"$COMPOSE_PROJECT_NAME".psql'
alias dpo='docker-compose exec db pg_dump -Udjango django > dj_"$COMPOSE_PROJECT_NAME".psql'

# Docker aliases for new style projects
alias dcd='docker-compose run --rm backend /var/www/deployment/deploy.py'
alias dmn='docker-compose run --rm backend /var/www/deployment/deploy.py run python -mdjango'


_get_editor() {
	if [ ! -z "$NVIM_LISTEN_ADDRESS" ]; then
		echo "nvimex e"
	elif command_exists nvim; then
		echo "nvim"
	else
		echo "vim"
	fi
}
