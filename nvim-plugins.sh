#!/bin/bash

wget -O trouble.zip https://github.com/simrat39/lsp-trouble.nvim/archive/refs/heads/main.zip
unzip trouble -d trouble && mv trouble/lsp-trouble.nvim-main/lua/trouble ~/.config/nvim/lua/ && rm -rf trouble.zip trouble

mkdir ~/.config/nvim/lua/lsp-colors
wget -O lsp-colors.zip https://github.com/folke/lsp-colors.nvim/archive/refs/heads/main.zip
unzip lsp-colors -d lsp-colors && mv lsp-colors/lsp-colors.nvim-main/lua/* ~/.config/nvim/lua/lsp-colors && rm -rf lsp-colors.zip lsp-colors

mkdir ~/.config/nvim/lua/nvim-web-devicons
wget -O nvim-web-devicons.zip https://github.com/kyazdani42/nvim-web-devicons/archive/refs/heads/master.zip
unzip nvim-web-devicons -d nvim-web-devicons && mv nvim-web-devicons/nvim-web-devicons-master/lua/* ~/.config/nvim/lua/nvim-web-devicons && rm -rf nvim-web-devicons.zip nvim-web-devicons
