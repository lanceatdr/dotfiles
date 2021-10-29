# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/lancesmith/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"
#ZSH_THEME="spaceship"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git kops kubectl)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# PowerLevel10k Customizations
POWERLEVEL9k_SHORTEN_DIR_PATH=2
POWERLEVEL9k_SHORTEN_DELIMITER=""
POWERLEVEL9k_SHORTEN_STRATEGY="truncate_from_left"
POWERLEVEL9k_LEFT_PROMPT_ELEMENTS=(kubecontext dir vcs)
POWERLEVEL9k_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time battery)
POWERLEVEL9k_PROMPT_ON_NEWLINE=true
# Add a space in the first prompt
#POWERLEVEL10k_MULTILINE_FIRST_PROMPT_PREFIX="%f"
#POWERLEVEL10k_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"
POWERLEVEL9K_MODE="nerdfont-complete"

# Spaceship Customizations
SPACESHIP_PROMPT_ORDER=(
  time
  dir
  git
  kubecontext
)
SPACESHIP_TIME_SHOW=true
SPACESHIP_PROMPT_ADD_NEWLINE=false



# Visual customisation of the second prompt line
local user_symbol="$"
if [[ $(print -P "%#") =~ "#" ]]; then
    user_symbol = "#"
fi
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# old .bash_profile-ings
export VISUAL='nvim'
export VIMCONFIG="$HOME/.config/nvim"
export EDITOR='nvim'

# do things because of os x and all the pythons
export PATH=~/Library/Python/2.7/bin:$PATH

# open folder in vscode
code () {
    if [[ $# = 0 ]]
    then
        open -a "Visual Studio Code"
    else
        [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
        open -a "Visual Studio Code" --args "$F"
    fi
}

# i'm into the brevity thing
alias k='kubectl'
alias g='gcloud'
alias tf='terraform'
alias tg='terragrunt'
alias ll='ls -lart'
alias tfinit="rm -rf .terraform && terraform init"
alias tfdocs="terraform-docs"

alias vim='nvim'
alias vi='nvim'

alias gc='git commit -m'
alias gp='git push'

# asdf
source $HOME/.asdf/asdf.sh

# long lost patch command
alias kcp='function _patch() { kubectl patch deployment ${1} --patch "{\"spec\":{\"template\":{\"metadata\":{\"annotations\":{\"date\":\"$(date +'%s')\"}}}}}" }; _patch'
alias kns="kubens"
alias docker-clean="docker images -aq -f 'dangling=true' | xargs docker rmi -f; docker volume ls -q -f 'dangling=true' | xargs docker volume rm"
alias kclr='sed -i"" -e "s/^current-context:.*$/current-context:/" ~/.kube/config'

alias av="aws-vault"
alias weather='function _weather(){ curl -s https://wttr.in/"${1:-denver}"; }; _weather'
alias ave='function _ave(){ aws-vault exec "${1}" -- $SHELL; }; _ave'
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# helm completion
source <(helm completion zsh)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/lancesmith/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/lancesmith/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/lancesmith/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/lancesmith/google-cloud-sdk/completion.zsh.inc'; fi

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi
