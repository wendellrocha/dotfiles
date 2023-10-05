#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    VSCODE=$(mdfind -literal 'kMDItemFSName=="Visual Studio Code - Insiders.app"')
    CHROME_CANARY=$(mdfind -literal 'kMDItemFSName=="Google Chrome Canary.app"')
    alias cat="bat --color=always --style=numbers,changes,header"
    alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
    
    if [[ ! -z "$VSCODE" ]]; then
        alias code="code-insiders"
    fi

    if [[ ! -z "$CHROME_CANARY" ]]; then
        export CHROME_EXECUTABLE="/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary"
    fi

    node=$(which node)
    export NODE_BINARY=$(which node)
else
    alias cat="batcat --color=always --style=numbers,changes,header"
fi


alias ls="exa -abghHlS --icons"
alias ports='netstat -a | grep -i "listen"'
alias reload='source ~/.zshrc'
alias backup='tar -zcvf $(date +%Y%m%d).tar.gz *'
alias path='echo -e ${PATH//:/\\n}'
alias cp='rsync --progress -avz --ignore-existing'
alias tree='tree -C --dirsfirst --gitignore -I "infrastructure|android|ios|shared|macos|web|windows|linux|.fvm|build|.dart_tool|.idea|.vscode|.vs|.fleet|.flutter-*|.metadata|*.iml"'
alias publicip='curl ifconfig.me'
alias extract='for i in *.gz; do tar xvf $i; done'
alias du1='du -h -d 1'
alias today='date +"%A, %B %d, %Y"'
alias weather='function _weather() { curl wttr.in/$1; }; _weather'
alias free='free -m -h'
alias rename='function _rename() { for i in *$1*; do mv "$i" "${i/$1/$2}"; done }; _rename'
alias to='function _to() { (cd "$@" && tree;) }; _to'
alias search='function _search() { grep -r --exclude-dir={.git,.svn,infrastructure,android,ios,shared,macos,web,windows,linux,.fvm,build,.dart_tool,.idea,.vscode,.vs,.fleet,.flutter-*,.metadata,*.iml} $1 *; }; _search'
alias gdiscard='git clean -df && git checkout -- .'

kernel_string=$(uname -r)

if [[ $kernel_string == *"WSL"* ]]; then
  alias exp='/mnt/c/WINDOWS/explorer.exe'
  alias code='/mnt/c/Users/wende/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code'
fi

if [[ -x "$(command -v kitten)" ]]; then
    alias icat="kitty +kitten icat"
    alias d="kitty +kitten diff"
fi
