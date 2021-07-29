#!/bin/bash

sudo apt install -y gnupg apt-transport-https wget ca-certificates dirmngr software-properties-common

wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'

sudo apt update

sudo apt install -y curl git unzip xz-utils zip libglu1-mesa zsh \
    nodejs build-essential adoptopenjdk-8-hotspot dart

sudo update-alternatives --config java

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in
# your PATH)
sudo ln -s ~/.local/kitty.app/bin/kitty /usr/local/bin/
# Place the kitty.desktop file somewhere it can be found by the OS
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
# Update the path to the kitty icon in the kitty.desktop file
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop


curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

echo -e "Installing oh-my-zsh\n"
if [ -d ~/.oh-my-zsh ]; then
    echo -e "oh-my-zsh is already installed\n"
else
    git clone --depth=1 git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

cp -f .zshrc ~/

mkdir -p Android/sdk
mkdir -p .android && touch .android/repositories.cfg

wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
unzip sdk-tools.zip && rm sdk-tools.zip

mv tools ~/Android/sdk/tools
cd ~/Android/sdk/tools/bin && yes | ./sdkmanager --licenses
cd ~/Android/sdk/tools/bin && ./sdkmanager  "patcher;v4" "platform-tools" \
    "platforms;android-30" \
    "build-tools;30.0.2" \
    "sources;android-30"

cd ~
curl https://install.meteor.com/ | sh

pub global activate fvm

fvm global stable

/bin/zsh -i -c git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
/bin/zsh -i -c ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo -e "\nSudo access is needed to change default shell\n"

if chsh -s $(which zsh) && /bin/zsh -i -c omz update; then
    echo -e "Installation Successful, exit terminal and enter a new session"
else
    echo -e "Something is wrong"
fi

if mv -n ~/.zshrc ~/.zshrc-backup-$(date +"%Y-%m-%d"); then # backup .zshrc
    echo -e "Backed up the current .zshrc to .zshrc-backup-date\n"
fi

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "source $(pwd)/.zshrc" > ~/.zshrc

ln -sf $(pwd)/kitty.conf /home/$USER/.config/kitty/kitty.conf 

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew update
brew install arduino-cli

exit