#!/bin/sh

git filter-branch --subdirectory-filter bin/ HEAD -- --all

if [ ! -d "$HOME/.zprezto" ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    
    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done
fi

if [ ! -d "$HOME/.zprezto-contrib" ]; then
    git clone --recurse-submodules https://github.com/belak/prezto-contrib ${ZDOTDIR:-$HOME}/.zprezto-prompt-contrib
fi


cat > ~/.zshrc << EOF
source $(pwd)/.zshrc
EOF

echo "source $(pwd)/.zpreztorc" > ~/.zpreztorc
