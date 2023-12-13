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

if [ ! -x "$(command -v starship)" ]; then
    curl -sS https://starship.rs/install.sh | sh
fi

if [ -d "~/.fzf"]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/instal --all
fi


cat > ~/.zshrc << EOF
source $(pwd)/.zshrc
# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
export STARSHIP_CONFIG=$(pwd)/starship.toml
# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
EOF

echo "source $(pwd)/.zpreztorc" > ~/.zpreztorc
