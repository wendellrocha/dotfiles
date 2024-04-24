export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

if [[ "$OSTYPE" == "darwin"* ]]; then
  export ZSH="/Users/$USER/.oh-my-zsh"
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
  export ANDROID_HOME="$HOME/Library/Android/sdk"
  export PATH="$PATH:$ANDROID_HOME/emulator"
  export PATH="$PATH:$ANDROID_HOME/platform-tools"
  export PATH="$PATH:/Users/$USER/fvm/default/bin"
  export PATH="$PATH:/Users/$USER/.pub-cache/bin"
  export PATH="$PATH:/Users/$USER/.local/bin"
  export REACT_TERMINAL=iTerm
  export PATH="$PATH:/$JAVA_HOME/bin:$PATH"
if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if [[ $(id -u) -ne 0 ]] ; then
    export ZSH="/home/$USER/.oh-my-zsh"
    export ANDROID_HOME="/home/$USER/Android/sdk"
    export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
    export PATH="$PATH:/home/$USER/Android/sdk/platform-tools"
    export PATH="$PATH:/home/$USER/.pub-cache/bin"
    export PATH="$PATH:/$JAVA_HOME/bin:$PATH"
    export PATH="$PATH:/home/$USER/.local/bin"
  else
    export ZSH="/root/.oh-my-zsh"
    export ANDROID_HOME="/home/wendell/Android/sdk"
    export PATH="$PATH:/home/wendell/Android/sdk/platform-tools"
  fi
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source "$HOME/dotfiles/aliases.sh"
source "$HOME/dotfiles/completitions.sh"
if [[ -s "$HOME/dotfiles/.env" ]]; then
  source "$HOME/dotfiles/.env"
else
  echo -e "${RED}Error: No .env file found.${END}"
fi
export TERM="screen-256color"

if [[ $(id -u) -ne 0 ]] ; then
  source "$HOME/dotfiles/utils.sh"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    eval $(/opt/homebrew/bin/brew shellenv)
  else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

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
