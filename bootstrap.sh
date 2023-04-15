#!/bin/sh

git filter-branch --subdirectory-filter bin/ HEAD -- --all

if [ ! -d "$HOME/.zprezto" ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    
    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done
fi

if [ ! -d "$HOME/.zprezto-prompt-contrib" ]; then
    git clone --recurse-submodules https://github.com/mattmc3/prezto-prompt-contrib ${ZDOTDIR:-$HOME}/.zprezto-prompt-contrib
fi

if [ ! -x "$(command -v starship)" ]; then
    curl -sS https://starship.rs/install.sh | sh
fi

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
ln -sf $(pwd)/kitty.conf ~/.config/kitty/kitty.conf

cat > ~/.zshrc << EOF
source $(pwd)/.zshrc
# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
source /Users/wendellrocha/dotfiles/.zshrc
export STARSHIP_CONFIG=$(pwd)/starship.toml
# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
EOF

echo "source $(pwd)/.zpreztorc" > ~/.zpreztorc