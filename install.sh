#!/bin/bash

sudo apt install -y curl gnupg apt-transport-https wget ca-certificates dirmngr software-properties-common lsb-release

wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install -y git unzip xz-utils zip libglu1-mesa zsh tmux \
    nodejs build-essential adoptopenjdk-8-hotspot dart exa bat neovim \
    qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager \
    docker-ce docker-ce-cli containerd.io

sudo update-alternatives --config java
sudo systemctl enable --now libvirtd

echo -e "Installing oh-my-zsh\n"
if [ -d ~/.oh-my-zsh ]; then
    echo -e "oh-my-zsh is already installed\n"
else
    git clone --depth=1 git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

mkdir -p /home/$USER/Android/sdk
mkdir -p /home/$USER/.android && touch /home/$USER/.android/repositories.cfg

wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
unzip sdk-tools.zip && rm sdk-tools.zip

mv tools /home/$USER/Android/sdk/
cd /home/$USER/Android/sdk/tools/bin && yes | ./sdkmanager --licenses
cd /home/$USER/Android/sdk/tools/bin && ./sdkmanager  "patcher;v4" "platform-tools" \
    "platforms;android-30" \
    "build-tools;30.0.2" \
    "sources;android-30"

cd ~
curl https://install.meteor.com/ | sh

wget -O dart.zip https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.5/sdk/dartsdk-linux-x64-release.zip
unzip dart.zip && rm dart.zip
mkdir /home/$USER/tools
mv dart-sdk /home/$USER/tools/

export PATH="$PATH:/home/$USER/fvm/default/bin"
export PATH="$PATH:/home/$USER/.pub-cache/bin"
export PATH="$PATH:/usr/lib/dart/bin"

pub global activate fvm
cat "Y" | fvm global stable

sudo usermod -aG docker $USER

/bin/zsh -i -c 'cd ~ && git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"'
/bin/zsh -i -c 'ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"'

echo -e "\nSudo access is needed to change default shell\n"

if chsh -s $(which zsh) && /bin/zsh -i -c omz update; then
    echo -e "Installation Successful, exit terminal and enter a new session"
else
    echo -e "Something is wrong"
fi

if mv -n ~/.zshrc ~/.zshrc-backup-$(date +"%Y-%m-%d"); then # backup .zshrc
    echo -e "Backed up the current .zshrc to .zshrc-backup-date\n"
fi

git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim

echo "source $(pwd)/.zshrc" > ~/.zshrc
mkdir /home/$USER/.config/alacritty
mkdir /home/$USER/.config/nvim

ln -sf $(pwd)/alacritty.yml /home/.config/alacritty/alacritty.yml
ln -sf $(pwd)/.vimrc /home/$USER/.vimrc
ln -sf $(pwd)/init.vim /home/$USER/.config/nvim/init.vim
ln -sf $(pwd)/coc-settings.json /home/$USER/.config/nvim/coc-settings.json
ln -sf $(pwd)/.gitconfig /home/$USER/.gitconfig
ln -sf $(pwd)/.tmux.conf /home/$USER/.tmux.conf
exit
