#!/bin/sh

git filter-branch --subdirectory-filter bin/ HEAD -- --all





cat > ~/.zshrc << EOF
source $(pwd)/.zshrc
EOF

mkdir $HOME/.config
ln -sf $(pwd)/starship.toml ~/.config/starship.toml


