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
alias :e="echo -n ':e ' | nvim"
# Docker
alias dc='docker-compose'
alias dcl="docker-compose logs -f --tail=50"
alias dcr="docker-compose restart"
alias dpsa='docker ps -a'
alias dm='docker-compose exec web /var/www/venv/bin/python manage.py'
alias dp='docker-compose exec db psql -Udjango django'
alias dpi='docker-compose exec db psql -Udjango django < dj_"$COMPOSE_PROJECT_NAME".psql'
alias dpo='docker-compose exec db pg_dump -Udjango django > dj_"$COMPOSE_PROJECT_NAME".psql'
alias dfc='docker run --rm --privileged alpine hwclock -s'

# Docker aliases for new style projects
alias dcd='docker-compose run --rm runserver /var/www/deployment/deploy.py'
alias dmn='docker-compose run --rm runserver /var/www/deployment/deploy.py run python3 -mdjango'


_get_editor() {
	if [ ! -z "$NVIM_LISTEN_ADDRESS" ]; then
		echo "nvimex e"
	elif command_exists nvim; then
		echo "nvim"
	else
		echo "vim"
	fi
}
