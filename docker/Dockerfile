FROM ubuntu:20.10

ARG DEBIAN_FRONTEND=noninteractive

# Prerequisites
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget apt-transport-https sudo gnupg2 clang cmake ninja-build pkg-config libgtk-3-dev neovim tmux bat exa python3-dev

RUN curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
RUN sudo apt install -y nodejs

# Set up new user
RUN useradd -ms /bin/bash developer
RUN adduser developer sudo
RUN passwd -d developer
USER developer
WORKDIR /home/developer

# Install zsh
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/deluan/zsh-in-docker/master/zsh-in-docker.sh)" -- \
    -p git \
    -p ssh-agent \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions \
    -p https://github.com/zsh-users/zsh-history-substring-search \
    -p https://github.com/zsh-users/zsh-syntax-highlighting

RUN PATH="$PATH:/usr/bin/zsh"

RUN sudo chsh -s /usr/bin/zsh developer

# Prepare Android directories and system variables
RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg

# Set up Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/sdk/tools
RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;30.0.0" "patcher;v4" "platform-tools" "platforms;android-30" "sources;android-30"
ENV PATH "$PATH:/home/developer/Android/sdk/platform-tools"

# Download Dart SDK
RUN wget -O dart.deb https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/linux_packages/dart_2.13.3-1_amd64.deb
RUN sudo dpkg -i dart.deb && rm dart.deb
ENV PATH "$PATH:/usr/lib/dart/bin"
ENV PATH "$PATH:/home/developer/.pub-cache/bin"
ENV PATH "$PATH:/home/developer/fvm/default/bin"

# Run basic check to download Dark SDK
RUN dart pub global activate fvm
RUN dart pub global activate slidy

ENV PATH "$PATH:/home/developer/fvm/default/bin"

RUN (echo "Y" && cat) | fvm global 2.2.3
RUN fvm flutter doctor
RUN fvm flutter config --enable-linux-desktop

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN (yes | ~/.fzf/install)


RUN mkdir /home/developer/.vim/
RUN mkdir /home/developer/.vim/bundle/
RUN mkdir /home/developer/.config/nvim/
RUN mkdir /home/developer/.config/coc/
RUN git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim

RUN wget -O .zshrc https://raw.githubusercontent.com/wendellrocha/dotfiles/master/docker/.zshrc
RUN wget https://raw.githubusercontent.com/wendellrocha/dotfiles/master/utils.sh
RUN wget -O .gitconfig https://raw.githubusercontent.com/wendellrocha/dotfiles/master/.gitconfig
RUN wget -O /home/developer/.config/nvim/coc-settings.json https://raw.githubusercontent.com/wendellrocha/dotfiles/master/coc-settings.json
RUN wget -O /home/developer/.config/nvim/init.vim https://raw.githubusercontent.com/wendellrocha/dotfiles/master/.vimrc


# Disable gradle daemon
RUN mkdir -p ~/.gradle && echo "org.gradle.daemon=false" >> ~/.gradle/gradle.properties

# Set zsh default shell
ENTRYPOINT [ "/usr/bin/zsh" ]
CMD ["-l"]
