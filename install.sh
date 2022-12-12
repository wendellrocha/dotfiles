#!/bin/bash

sudo apt install -y curl gnupg apt-transport-https wget ca-certificates dirmngr software-properties-common lsb-release

curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install -y git unzip xz-utils zip libglu1-mesa zsh tmux \
    nodejs build-essential openjdk-8-jdk openjdk-8-jre exa bat neovim \
    qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager \
    docker-ce docker-ce-cli containerd.io jq

sudo update-alternatives --config java
sudo systemctl enable --now libvirtd

#echo -e "Installing oh-my-zsh\n"
#if [ -d ~/.oh-my-zsh ]; then
#    echo -e "oh-my-zsh is already installed\n"
#else
#    git clone --depth=1 git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
#fi

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

cat "Y" | fvm global stable

sudo usermod -aG docker $USER

git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim

mkdir /home/$USER/.config
echo "source $(pwd)/.zshrc" > ~/.zshrc
mkdir /home/$USER/.config/alacritty
mkdir /home/$USER/.config/nvim

ln -sf $(pwd)/alacritty.yml /home/$USER/.config/alacritty/alacritty.yml
ln -sf $(pwd)/.vimrc /home/$USER/.vimrc
ln -sf $(pwd)/init.vim /home/$USER/.config/nvim/init.vim
ln -sf $(pwd)/coc-settings.json /home/$USER/.config/nvim/coc-settings.json
ln -sf $(pwd)/.gitconfig /home/$USER/.gitconfig
ln -sf $(pwd)/.tmux.conf /home/$USER/.tmux.conf
exit
