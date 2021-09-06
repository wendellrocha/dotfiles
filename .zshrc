export ZSH="/home/$USER/.oh-my-zsh"
export ANDROID_HOME="/home/$USER/Android/sdk"
export JAVA_HOME="/usr/lib/jvm/adoptopenjdk-8-hotspot-amd64"
export PATH="$PATH:/home/$USER/Android/sdk/platform-tools"
export PATH="$PATH:/home/$USER/Android/sdk/tools"
export PATH="$PATH:/home/$USER/fvm/default/bin"
export PATH="$PATH:/home/$USER/.pub-cache/bin"
export PATH="$PATH:/home/$USER/tools/dart-sdk/bin"
export PATH="$PATH:/opt/mitmproxy"
export PATH="$PATH:/$JAVA_HOME/bin:$PATH"
export PATH="$PATH:/opt/go/bin"

ZSH_THEME="spaceship"

plugins=(git bgnotify flutter meteor vscode)

source $ZSH/oh-my-zsh.sh
source "$HOME/dotfiles/utils.sh"

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  node          # NodeJS
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SUFFIX=" "

export TERM="screen-256color"

alias ls="exa -abghHlS --git"
alias cat="batcat --color=always --style=numbers"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND=find
export FZF_DEFAULT_OPTS="
  --color hl:011,fg+:015,bg+:-1,hl+:011
  --color info:008,prompt:003,spinner:011,pointer:006,marker:002
  --cycle
  --prompt='❯ '
  --pointer='▶'
  --marker='│'
"

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
