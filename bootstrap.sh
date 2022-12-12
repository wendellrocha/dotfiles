#!/bin/sh

if [ ! -x "$(command -v starship)" ]; then
    curl -sS https://starship.rs/install.sh | sh
fi

if [ ! -d "$HOME/.zprezto-prompt-contrib" ]; then
    git clone --recurse-submodules https://github.com/mattmc3/prezto-prompt-contrib ${ZDOTDIR:-$HOME}/.zprezto-prompt-contrib
fi

cat > ~/.zshrc << EOF
source $(pwd)/.zshrc
# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
source /Users/wendellrocha/dotfiles/.zshrc
# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
export STARSHIP_CONFIG=$(pwd)/starship.toml
EOF

echo "source $(pwd)/.zpreztorc" > ~/.zpreztorc