#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    VSCODE=$(mdfind -literal 'kMDItemFSName=="Visual Studio Code - Insiders.app"')
    alias cat="bat --color=always --style=numbers,changes,header"
    if [[ ! -z "$VSCODE" ]]; then
        alias code="code-insiders"
    fi
    node=$(which node)
    export NODE_BINARY=$(which node)
else
    alias cat="batcat --color=always --style=numbers,changes,header"
fi


if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

alias ls="exa -abghHlS --icons"

kernel_string=$(uname -r)

if [[ $kernel_string == *"WSL"* ]]; then
  alias exp='/mnt/c/WINDOWS/explorer.exe'
  alias code='/mnt/c/Users/wende/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code'
fi

if [[ -x "$(command -v kitten)" ]]; then
    alias icat="kitty +kitten icat"
    alias d="kitty +kitten diff"
fi