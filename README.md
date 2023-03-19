creates Brewfile in the current directory from currently-installed packages
`brew bundle dump`

install everything from the Brewfile
`brew bundle`

bootstrap zsh with prezto
`./bootstrap.sh`

defaults write com.apple.TextEdit NSShowAppCentricOpenPanelInsteadOfUntitledFile -bool false

One-liner pra desinstalar brews com direito a descrição como preview.
Pra escolher vários é só marcar com <TAB>:

❯ brew rm `brew ls | fzf --preview='brew info {}'`

