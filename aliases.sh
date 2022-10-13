#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    VSCODE=$(mdfind -literal 'kMDItemFSName=="Visual Studio Code - Insiders.app"')
    alias cat="bat --color=always --style=numbers,changes,header"
    if [[ ! -z "$VSCODE" ]]; then
        alias code="code-insiders"
    fi
    node=$(which node)
else
    alias cat="batcat --color=always --style=numbers,changes,header"
fi

alias ls="exa -abghHlS --icons"

kernel_string=$(uname -r)

if [[ $kernel_string == *"WSL"* ]]; then
  alias exp='/mnt/c/WINDOWS/explorer.exe'
  alias code='/mnt/c/Users/wende/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code'
fi
