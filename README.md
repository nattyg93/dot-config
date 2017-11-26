.config
========
These are the settings for various programs that I use.


Note: that this makes an attempt to respect XDG base directory layout.
Currently, bash/zsh do not comply, as they hook in the other programs.
By editing /etc/profile (for bash) or /etc/zshenv (for zsh), a dotfile-free
$HOME is achieved

Installation:

  1. Clone it
    git clone http://github.com/nattyg93/.config && cd .config && git submodule init

  2. Your device:
      Bash: sudo echo '[[ ! -z "$PS1" ]] && [[ ! -z "$BASH_VERSION" ]] && . ~/.config/bash/bashrc' >> /etc/profile
      Zsh: sudo echo 'export ZDOTDIR="$HOME/.config/zsh"' >> /etc/zshenv
    Remote host:
      Bash: ln -s ~/.config/bash/bashrc ~/.bash_profile
      Zsh: ensure "SendEnv ZDOTDIR" is in your  config

  3. Symlink $XDG_CONFIG_HOME to $HOME
      cd ~
      ln -s .config/ssh .ssh

  4. Configure your graphical terminal to always open login shells

  5. Log out and back in again for the environment variables to take effect

  6. Some directories such as $HOME/development will need to be manually
  created

  7. Some of the addons will require other programs to be installed.
    silver-searcher
    pip (pip install --user uses $HOME/.local)
      flake8
      pylint
      mypy
