# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export LANG='en_US.UTF-8'
export LANGUAGE='en_US:en'
export LC_ALL='en_US.UTF-8'

export TERM="screen-256color"

alias ls="exa -abghHlS --git"
alias cat="batcat --color=always --style=numbers"

export PATH="$PATH:/home/developer/Android/sdk/platform-tools"
export PATH="$PATH:/usr/lib/dart/bin"
export PATH="$PATH:/home/developer/.pub-cache/bin"
export PATH="$PATH:/home/developer/fvm/default/bin"


##### Zsh/Oh-my-Zsh Configuration
export ZSH="/home/developer/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git ssh-agent zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-syntax-highlighting flutter)

source $ZSH/oh-my-zsh.sh
source "$HOME/utils.sh"

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_last"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs status)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_STATUS_CROSS=true

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
