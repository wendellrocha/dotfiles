if [[ "$OSTYPE" == "darwin"* ]]; then
  export ZSH="/Users/$USER/.oh-my-zsh"
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home"
  export ANDROID_HOME="$HOME/Library/Android/sdk"
  export PATH="$PATH:$ANDROID_HOME/emulator"
  export PATH="$PATH:$ANDROID_HOME/platform-tools"
  # export PATH="$PATH:/Users/$USER/fvm/default/bin"
  # export PATH="$PATH:/Users/$USER/.pub-cache/bin"
  # export PATH="$PATH:/Users/$USER/.local/bin"
  # export PATH="$PATH:/opt/mitm"
  export PATH="$PATH:/$JAVA_HOME/bin:$PATH"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if [[ $(id -u) -ne 0 ]] ; then
    export ZSH="/home/$USER/.oh-my-zsh"
    export ANDROID_HOME="/home/$USER/Android/sdk"
    export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
    export PATH="$PATH:/home/$USER/Android/sdk/platform-tools"
    export PATH="$PATH:/home/$USER/fvm/default/bin"
    export PATH="$PATH:/home/$USER/.pub-cache/bin"
    export PATH="$PATH:/$JAVA_HOME/bin:$PATH"
    export PATH="$PATH:/home/$USER/.local/bin"
    export PATH="$PATH:/opt/mitm"
  else
    export ZSH="/root/.oh-my-zsh"
    export ANDROID_HOME="/home/wendell/Android/sdk"
    export PATH="$PATH:/home/wendell/Android/sdk/platform-tools"
  fi
fi

ZSH_THEME="spaceship"

plugins=(git bgnotify flutter vscode)

source $ZSH/oh-my-zsh.sh

if [[ $(id -u) -ne 0 ]] ; then
  source "$HOME/dotfiles/utils.sh"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    eval $(/opt/homebrew/bin/brew shellenv)
  else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  node          # NodeJS
  exec_time     # Execution time
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

SPACESHIP_USER_SHOW=always
SPACESHIP_GIT_SHOW=true
SPACESHIP_GIT_ASYNC=false
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SUFFIX=" "
DISABLE_AUTO_TITLE="true"

export TERM="screen-256color"

kernel_string=$(uname -r)

if [[ $kernel_string == *"WSL"* ]]; then
  alias exp='/mnt/c/WINDOWS/explorer.exe'
  alias code='/mnt/c/Users/wende/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code'
fi


alias ls="exa -abghHlS"
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
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
    zdharma-continuum/zinit-annex-readurl \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
