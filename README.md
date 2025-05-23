creates Brewfile in the current directory from currently-installed packages
`brew bundle dump`

install everything from the Brewfile
`brew bundle`

bootstrap zsh with prezto
`./bootstrap.sh`

defaults write com.apple.TextEdit NSShowAppCentricOpenPanelInsteadOfUntitledFile -bool false

One-liner pra desinstalar brews com direito a descrição como preview.
Pra escolher vários é só marcar com `<TAB>`:

 ```
❯ brew rm `brew ls | fzf -m --preview='brew info {}'``
```

## Install Oh my ZSH.
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Install plugins.
 - autosuggesions plugin
 
	`git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions`
	
 - zsh-syntax-highlighting plugin
 
	`git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting`
	
 - zsh-fast-syntax-highlighting plugin
 
	`git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting`
	
 - zsh-autocomplete plugin
	
	`git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete`
	
## Enable plugins by adding them to .zshrc.
 - Open .zshrc
	
	`nvim ~/.zshrc`
	
 -  Find the line which says `plugins=(git)`.
	
 -  Replace that line with
	`plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)`