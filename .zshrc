# Load HomeBrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Load a nice ASCII logo
echo ''
lolcat /Users/gianmarco/Documents/Seisnet/Text/TXT/ssnt-ascii.txt
echo ''

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
fpath=($fpath "/Users/gianmarco/.zfunctions")

# Set some variables
HOSTS_PATH="/etc/hosts"
VHOSTS_PATH="/Applications/MAMP/conf/apache/extra/httpd-vhosts.conf"

# ---------------
# --- ALIASES ---
# ---------------

alias cdb="cd /Applications/MAMP/htdocs/~boilerplates"
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
alias pu="sh ~/bin/project-utils/project-utils.sh"
alias cd..="cd .."
alias composer="php composer.phar"
alias composer74="php74 composer.phar"
alias wp="php wp-cli.phar"
alias magento="php73 -d \"memory_limit=-1\" bin/magento"
alias whatsmyip="ifconfig | grep -E \"inet.*broadcast\" | grep -Eo -m 1 \"inet ((\d+)\.){3}((\d*))\""
alias opena="open -a"

# PHPs
FOLDER_PHP_LOCAL="/Users/gianmarco/bin/php"
BIN_PHP_LOCAL="$FOLDER_PHP_LOCAL/bin"
BIN_PHP54="/Applications/MAMP/bin/php/php5.4.45/bin"
BIN_PHP56="/Applications/MAMP/bin/php/php5.6.40/bin"
BIN_PHP71="/Applications/MAMP/bin/php/php7.1.33/bin"
BIN_PHP72="/Applications/MAMP/bin/php/php7.2.34/bin"
BIN_PHP73="/Applications/MAMP/bin/php/php7.3.29/bin"
BIN_PHP74="/Applications/MAMP/bin/php/php7.4.21/bin"
BIN_PHP80="/Applications/MAMP/bin/php/\$php8.0.8/bin"
BIN_PHP81="/opt/homebrew/bin"
alias php54="$BIN_PHP54/php"
alias php56="$BIN_PHP56/php"
alias php71="$BIN_PHP71/php"
alias php72="$BIN_PHP72/php"
alias php73="$BIN_PHP73/php"
alias php74="$BIN_PHP74/php"
alias php80="$BIN_PHP80/php"
alias php81="$BIN_PHP81/php"

# ElasticSearch
alias elasticsearch6="/Users/gianmarco/bin/elasticsearch6/bin/elasticsearch"
alias elasticsearch7="/Users/gianmarco/bin/elasticsearch7/bin/elasticsearch"
alias elasticsearch8="/Users/gianmarco/bin/elasticsearch8/bin/elasticsearch"

# Python
alias python="/opt/homebrew/bin/python3"
alias pip="/opt/homebrew/bin/pip3"


# -----------------
# --- Functions ---
# -----------------

cdht() {
  cd /Users/gianmarco/Workspaces/htdocs
  if [ ! -z "$1" ];
    then cd "$1";
  fi;
}

cdwp() {
  # Usage:
  # $ cdwp $FOLDER

  # Go to `htdocs` folder
  cdht

  # Trim string, before* and after**
  FLDR="${1##*( )}" # *
  FLDR="${FLDR%%*( )}" # **
  echo -e "Changing directory to: '$(colorecho "$FLDR/wp-content/themes/$FLDR" "0;33")'"
  cd $FLDR/wp-content/themes/$FLDR
}

removefile() {
  # Usage:
  # $ removefile $FILE $FOLDER
  
  if [ ! -z "$2" ];
    then RMPATH=./$2;
    else RMPATH=.;
  fi;
  echo -e "Searching for '$(colorecho $1 "0;33")' inside '$(colorecho $RMPATH "0;33")'"
  find $RMPATH -name $1 -type f -delete;
  echo -e "$(colorecho "✓ Removed all '$1'" "1;32")"
}

colorecho() {
  # Usage:
  # $(colorecho "string" "style;color")
  # $(colorecho "test" "0;32")
  C_S='\033[' # Color Start
  C_E='m' # Color End
  C_NC='\033[0m' # No Color
  echo -e "${C_S}$2${C_E}$1${C_NC}"
}

installcomposer() {
  #!/bin/sh

  EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

  if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
  then
    >&2 echo 'ERROR: Invalid installer checksum'
    rm composer-setup.php
    echo -e "$(colorecho "× Composer not installed." "1;31")";
  else
    php composer-setup.php
    RESULT=$?
    rm composer-setup.php
    echo -e "$(colorecho "✓ Composer installed successfully!" "1;32")";
  fi

}

installwpcli() {
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
}

mamp() {
  # Usage:
  # $ mamp start
  # $ mamp stop
  # $ mamp restart

  MAMP_BIN_PATH="/Applications/MAMP/bin"
  case $1 in
    start)
      sudo $MAMP_BIN_PATH/start.sh
    ;;

    stop)
      $MAMP_BIN_PATH/stop.sh
    ;;

    restart)
      $MAMP_BIN_PATH/stop.sh
      $MAMP_BIN_PATH/start.sh
    ;;

    open)
      open -a MAMP
    ;;

    close)
      osascript -e 'quit app "MAMP"'
    ;;
    
    *)
      # ┌─────────────────────────────────┐
      # │ Usage:                          │
      # ├─────────────────────────────────┤
      # │ start      Starts MAMP server   │
      # │ stop       Stops MAMP server    │
      # │ restart    Restarts MAMP server │
      # ├─────────────────────────────────┤
      # │ open       Open MAMP GUI        │
      # │ close      Close MAMP GUI       │
      # └─────────────────────────────────┘
      echo "┌─────────────────────────────────┐"
      echo "│ Usage:                          │"
      echo "├─────────────────────────────────┤"
      echo "│ $(colorecho "start" "1;33")      Starts MAMP server   │"
      echo "│ $(colorecho "stop" "1;33")       Stops MAMP server    │"
      echo "│ $(colorecho "restart" "1;33")    Restarts MAMP server │"
      echo "├─────────────────────────────────┤"
      echo "│ $(colorecho "open" "1;33")       Open MAMP GUI        │"
      echo "│ $(colorecho "close" "1;33")      Close MAMP GUI       │"
      echo "└─────────────────────────────────┘"
  esac
}

phpv () {
  VERSION=$1;

  # if [ ! -z "$VERSION" ]
  # then
    case $VERSION in
      54) ln -sfF $BIN_PHP54 $FOLDER_PHP_LOCAL ;;
      56) ln -sfF $BIN_PHP56 $FOLDER_PHP_LOCAL ;;
      71) ln -sfF $BIN_PHP71 $FOLDER_PHP_LOCAL ;;
      72) ln -sfF $BIN_PHP72 $FOLDER_PHP_LOCAL ;;
      73) ln -sfF $BIN_PHP73 $FOLDER_PHP_LOCAL ;;
      74) ln -sfF $BIN_PHP74 $FOLDER_PHP_LOCAL ;;
      80) ln -sfF $BIN_PHP80 $FOLDER_PHP_LOCAL ;;
      81) ln -sfF $BIN_PHP81 $FOLDER_PHP_LOCAL ;;
      *)
        echo "\nAvailable versions:"
        echo "54 -> PHP 5.4.45"
        echo "56 -> PHP 5.6.40"
        echo "71 -> PHP 7.1.33"
        echo "72 -> PHP 7.2.34"
        echo "73 -> PHP 7.3.29"
        echo "74 -> PHP 7.4.21"
        echo "81 -> PHP 8.1.x"
      ;;
    esac
  # fi
}

# --------------------
# --- Exports PATH ---
# --------------------

export OG_PATH=$PATH
# export PATH=$BIN_PHP74
export PATH=$BIN_PHP_LOCAL
export PATH=$PATH:$OG_PATH
# export PATH=$PATH:/Library/Frameworks/Mono.framework/Versions/Current/Commands
export PATH=$PATH:/Applications/MAMP/Library/bin
# export PATH=$PATH:/Users/gianmarco/Documents/Utility/android-platform-tools
# export PATH=$PATH:/Users/gianmarco/Documents/Flutter/SDK/bin
export PATH=$PATH:/opt/homebrew/bin

export php54
export php56
export php71
export php72
export php73
export php74
export php80
export php81

# export JAVA_HOME=$(/usr/libexec/java_home -v 11)
# export ES_JAVA_HOME=$(/usr/libexec/java_home -v 11)


# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# ---------------------
# --- Powerlevel10k ---
# ---------------------
# Activation
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# WP CLI autocompletion
# source $HOME/.wp-cli/wp-completion.bash

# BEGIN SNIPPET: Magento Cloud CLI configuration
# HOME=${HOME:-'/Users/gianmarco'}
# export PATH="$HOME/"'.magento-cloud/bin':"$PATH"
# if [ -f "$HOME/"'.magento-cloud/shell-config.rc' ]; then . "$HOME/"'.magento-cloud/shell-config.rc'; fi
# END SNIPPET
