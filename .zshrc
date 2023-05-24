# Load HomeBrew
if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f "/usr/local/bin/brew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Load a nice ASCII logo/motd if exists, with `lolcat` if exists
MOTD="$HOME/.zsh_motd"
if [ -e $MOTD ]; then
  if type "lolcat" > /dev/null
    then lolcat $MOTD
    else cat $MOTD
  fi
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---------------------------
# --- Colors/Style output ---
# ---------------------------
# -- Styles --
# 0 - Regular
# 1 - Bold
# 2 - Dimmed
# 3 - Italic
# 4 - Underline
# 7 - Background (Invert text ⟶ bg)
# 9 - Strike-through
# -- Colors (3x text - 4x bg) --
# 0 (30, 40) - Black
# 1 (31, 41) - Red
# 2 (32, 42) - Green
# 3 (33, 43) - Yellow
# 4 (34, 44) - Blue
# 5 (35, 45) - Purple
# 6 (36, 46) - Teal/Cyan
# 7 (37, 47) - Gray

# Load some functions
fpath=($fpath "$HOME/.zfunctions")

# Set some variables
HOSTS_PATH="/etc/hosts"
VHOSTS_PATH="/Applications/MAMP/conf/apache/extra/httpd-vhosts.conf"

# ---------------
# --- ALIASES ---
# ---------------

alias cdb="cd /Applications/MAMP/htdocs/~boilerplates"
alias cdgh="cd ~/Workspaces/github"
# alias cat="bat"
alias ls="ls -G"
alias ll="ls -alh"
alias cls="colorls -1 --sd"
alias rmf="removefile"
alias removeds="removefile .DS_Store"
alias rmds="removeds"
alias tclock="tty-clock -sc -f \"%A %d %B %Y\" -C 4"
alias edithosts="code $HOSTS_PATH $VHOSTS_PATH"
alias editzshrc="code ~/.zshrc"
# alias pu="sh ~/bin/project-utils/project-utils.sh"
alias pu="python ~/bin/project-utils"
alias cd..="cd .."
alias composer="php composer.phar"
alias composer74="php74 composer.phar"
alias wp="php wp-cli.phar"
alias magento="php73 -d \"memory_limit=-1\" bin/magento"
alias whatsmyip="ifconfig | grep -Eo -e 'inet\s(([0-9]{1,3}\.){3}[0-9]{1,3})\s' | sed -E 's/inet[[:space:]]//g' | sed -E 's/127.*/IP Address:/g'"
alias opena="open -a"
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

# PHPs
source ~/.zsh_php

# ElasticSearch
alias elasticsearch6="$HOME/bin/elasticsearch6/bin/elasticsearch"
alias elasticsearch7="$HOME/bin/elasticsearch7/bin/elasticsearch"
alias elasticsearch8="$HOME/bin/elasticsearch8/bin/elasticsearch"

# Python
alias python="/opt/homebrew/bin/python3"
alias pip="/opt/homebrew/bin/pip3"


# -----------------
# --- Functions ---
# -----------------

source ~/.zsh_functions


# --------------------
# --- Exports PATH ---
# --------------------

export OG_PATH=$PATH
# export PATH=$BIN_PHP74
export PATH=$BIN_PHP_LOCAL
export PATH=$PATH:$OG_PATH
# export PATH=$PATH:/Library/Frameworks/Mono.framework/Versions/Current/Commands
export PATH=$PATH:/Applications/MAMP/Library/bin
# export PATH=$PATH:$HOME/Documents/Utility/android-platform-tools
# export PATH=$PATH:$HOME/Documents/Flutter/SDK/bin
export PATH=$PATH:/opt/homebrew/bin

# export JAVA_HOME=$(/usr/libexec/java_home -v 11)
# export ES_JAVA_HOME=$(/usr/libexec/java_home -v 11)

# Load NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Load Powerlevel10k
# Activation
if [ -f "/opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme" ]; then
  source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
elif [ -f "/usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme" ]; then
  source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load zsh-syntax-highlighting
if [ -f "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# WP CLI autocompletion
# source $HOME/.wp-cli/wp-completion.bash

# BEGIN SNIPPET: Magento Cloud CLI configuration
# HOME=${HOME:-'$HOME'}
# export PATH="$HOME/"'.magento-cloud/bin':"$PATH"
# if [ -f "$HOME/"'.magento-cloud/shell-config.rc' ]; then . "$HOME/"'.magento-cloud/shell-config.rc'; fi
# END SNIPPET