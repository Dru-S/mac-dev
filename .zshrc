# ---------------------------
# --- COLORS/STYLE OUTPUT ---
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


# ---------------
# --- ALIASES ---
# ---------------

alias cdb="cd /Applications/MAMP/htdocs/~boilerplates"
alias cat="bat"
alias ls="ls -G"
alias cls="colorls -1 --sd"
alias removeds="removefile .DS_Store"
alias tclock="tty-clock -sc -f \"%A %d %B %Y\" -C 4"
alias edithosts="code /etc/hosts /Applications/MAMP/conf/apache/extra/httpd-vhosts.conf"
alias pu="~/Documents/Utility/project-utils.sh"


# -----------------
# --- FUNCTIONS ---
# -----------------

function cdht() {
  cd /Applications/MAMP/htdocs
  if [ ! -z "$1" ];
    then cd "$1";
  fi;
}

function cdwp() {
  # Trim string, before* and after**
  FLDR="${1##*( )}" # *
  FLDR="${FLDR%%*( )}" # **
  echo -e "Changing directory to: '$(colorout "$FLDR/wp-content/themes/$FLDR" "0;33")'"
  cd $FLDR/wp-content/themes/$FLDR
}

function removefile() {
  if [ ! -z "$2" ];
    then RMPATH=./$2;
    else RMPATH=.;
  fi;
  echo -e "Searching for '$(colorout $1 "0;33")' inside '$(colorout $RMPATH "0;33")'"
  find $RMPATH -name $1 -type f -delete;
  echo -e "$(colorout "✓ Removed all '$1'" "1;32")"
}

function colorout() {
  # Usage
  # $(colorout "string" "style;color")
  # $(colorout "test" "0;32")
  C_S='\033[' # Color Start
  C_E='m' # Color End
  C_NC='\033[0m' # No Color
  echo -e "${C_S}$2${C_E}$1${C_NC}"
}

# --------------------
# --- EXPORTS PATH ---
# --------------------

export OG_PATH=$PATH
export PATH=/Applications/MAMP/bin/php/php7.4.9/bin/
export PATH=$PATH:$OG_PATH
# export PATH=$PATH:/Library/Frameworks/Mono.framework/Versions/Current/Commands
export PATH=$PATH:/Applications/MAMP/Library/bin
export PATH=$PATH:/Users/gianmarco/Documents/Utility/android-platform-tools
export PATH=$PATH:/Users/gianmarco/Documents/Flutter/SDK/bin
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

fpath=($fpath "/Users/gianmarco/.zfunctions")

# -----------------
# --- SPACESHIP ---
# -----------------

# Set Spaceship's variables
SPACESHIP_PROMPT_ORDER=()
SPACESHIP_PROMPT_ORDER=(
  # time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  # hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  # ruby          # Ruby section
  # elixir        # Elixir section
  # xcode         # Xcode section
  # swift         # Swift section
  # golang        # Go section
  # php           # PHP section
  # rust          # Rust section
  # haskell       # Haskell Stack section
  # julia         # Julia section
  # docker        # Docker section
  # aws           # Amazon Web Services section
  # gcloud        # Google Cloud Platform section
  # venv          # virtualenv section
  # conda         # conda virtualenv section
  pyenv         # Pyenv section
  # dotnet        # .NET section
  # ember         # Ember.js section
  # kubectl       # Kubectl context section
  # terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  # battery       # Battery level and status
  # vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

# Custom Spaceship
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PACKAGE_PREFIX='-'
SPACESHIP_NODE_PREFIX='-'

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

# zsh-syntax-highlighting
plugins=(osx zsh-syntax-highlighting)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

echo ''
lolcat /Users/gianmarco/Documents/Seisnet/Text/TXT/ssnt_ascii.txt
