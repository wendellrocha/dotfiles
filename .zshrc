export LANG=en_US.UTF-8

if [[ "$OSTYPE" == "darwin"* ]]; then
  export ZSH="/Users/$USER/.oh-my-zsh"
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home"
  export ANDROID_HOME="$HOME/Library/Android/sdk"
  export PATH="$PATH:$ANDROID_HOME/emulator"
  export PATH="$PATH:$ANDROID_HOME/platform-tools"
  export PATH="$PATH:/Users/$USER/development/flutter/bin"
  export PATH="$PATH:/Users/$USER/development/bin"
  export PATH="$PATH:/Users/$USER/.pub-cache/bin"
  export PATH="$PATH:/Users/$USER/.local/bin"
  export REACT_TERMINAL=iTerm
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

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source "$HOME/dotfiles/aliases.sh"
export TERM="screen-256color"

if [[ $(id -u) -ne 0 ]] ; then
  source "$HOME/dotfiles/utils.sh"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    eval $(/opt/homebrew/bin/brew shellenv)
  else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh

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
