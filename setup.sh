# Install OMZ
sudo apt install zsh curl git
chsh -s /usr/bin/zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

sed -i.bak \
  -e 's/^ZSH_THEME="robbyrussell"$/ZSH_THEME="pygmalion"/' \
  -e '/^plugins=(git)$/ {' \
  -e 'N; s/plugins=(git)\n/plugins=(\n    git\n    zsh-autosuggestions\n    zsh-syntax-highlighting\n)/' \
  -e '}' \
  ~/.zshrc

# Setup OpenSSH
sudo apt install openssh-server openssh-client

# Install essential software
sudo apt install build-essential lldb gdb vim emacs net-tools wget w3m wireshark ffmpeg apt-transport-https ca-certificates software-properties-common cmake automake unzip bubblewrap tree dirmngr llvm gimp

# Install node
## Install nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

## Install LTS nodejs version
nvm install --lts

## NPM Packages
npm i -g nvm @angular/cli @angular/core @nestjs/cli yarn

# Python Packages
pip install matplotlib numpy scikit-learn requests pandas jupyter pylint websockets

# Firefox installation
sudo apt remove firefox
sudo snap remove firefox
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla
sudo apt-get update
sudo apt-get install firefox

# Install Spotify
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install spotify-client

# Install Docker Engine
## Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

## Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

## Install Docker packages
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

## sudo permission on docker for current user
sudo groupadd docker
sudo usermod -aG docker $USER

# Install Inkscape
sudo add-apt-repository ppa:inkscape.dev/stable
sudo apt update
sudo apt install inkscape

# Install Java LTS
for i in 11 17 21; do
	sudo apt install openjdk-$i-jdk openjdk-$i-jre
done

# Install GNS3
sudo add-apt-repository ppa:gns3/ppa
sudo apt update
sudo apt install gns3-gui gns3-server

## For IOU Support
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install gns3-iou

## Supporting Python packages
sudo apt install python3-pip python3-venv pipx python3-pyqt5 python3-pyqt5.qtwebsockets python3-pyqt5.qtsvg qemu-kvm qemu-utils libvirt-clients libvirt-daemon-system virtinst dynamips gnupg2

# Install KVM
sudo apt -y install bridge-utils cpu-checker libvirt-clients libvirt-daemon qemu qemu-kvm

# Install Blender
sudo snap install blender --classic

# Install LISP
sudo apt-get install sbcl
curl -o /tmp/ql.lisp http://beta.quicklisp.org/quicklisp.lisp
sbcl --no-sysinit --no-userinit --load /tmp/ql.lisp \
       --eval '(quicklisp-quickstart:install :path "~/.quicklisp")' \
       --eval '(ql:add-to-init-file)' \
       --quit
sbcl --eval '(ql:quickload :quicklisp-slime-helper)' --quit
echo '(load (expand-file-name "~/.quicklisp/slime-helper.el"))
  ;; Replace "sbcl" with the path to your implementation
  (setq inferior-lisp-program "sbcl")' >> ~/.emacs

# Install SWIProlog
sudo apt-add-repository ppa:swi-prolog/stable
sudo apt-get update
sudo apt-get install swi-prolog

# Install Julia
curl -fsSL https://install.julialang.org | sh

# Install PHP
sudo apt install aphp-common libapache2-mod-php php-cli

# Install Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

# Install OCaml
bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"

# Install Haskell
sudo apt install libffi-dev libffi6 libgmp-dev libgmp10 libncurses-dev libncurses5 libtinfo5 libffi-dev libffi8ubuntu1 libgmp-dev libgmp10 libncurses-dev

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install R Programming Language
## add the signing key (by Michael Rutter) for these repos
### To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
### Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc

## add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

## Install R
sudo apt install --no-install-recommends r-base

# Install VSCode
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code # or code-insiders

# Install Signal
## Install our official public software signing key:
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

## Add our repository to your list of repositories:
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee /etc/apt/sources.list.d/signal-xenial.list

## Update your package database and install Signal:
sudo apt update && sudo apt install signal-desktop

# Install Thunderbird
wget -O thunderbird.tar.bz2 "https://download.mozilla.org/?product=thunderbird-latest&os=linux64&lang=en-US"
tar xjf ./thunderbird.tar.bz2
rm ./thunderbird.tar.bz2
sudo mv ./thunderbird /opt
sudo ln -s /opt/thunderbird/thunderbird /usr/local/bin/thunderbird
sudo wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/installing-thunderbird-linux/thunderbird.desktop -P /usr/local/share/applications

# Install Telegram
snap install telegram

# Install Chrome
wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O /tmp/google.pub
gpg --no-default-keyring \
        --keyring /etc/apt/keyrings/google-chrome.gpg \
        --import /tmp/google.pub
echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update -y; sudo apt-get install -y google-chrome-stable

# Install Flutter
sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa jq
sudo apt-get install libc6:amd64 libstdc++6:amd64 libbz2-1.0:amd64 libncurses5:amd64
sudo apt-get install clang cmake git ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev
wget -O flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.22.2-stable.tar.xz
sudo tar -xf ./flutter.tar.xz -C /usr/bin/
rm ./flutter.tar.xz
echo '# Flutter SDK Path' >> ~/.zshrc
echo 'export PATH="/usr/bin/flutter/bin:$PATH"' >> ~/.zshrc

# Install WebAssembly
git clone https://github.com/emscripten-core/emsdk.git
cd emsdk
git pull
./emsdk install latest
cd ..
sudo mv ./emsdk /opt
/opt/emsdk/emsdk activate latest
source /opt/emsdk/emsdk_env.sh
echo "# EMSDK" >> ~/.zshrc
echo "export EMSDK_QUIET=1" >> ~/.zshrc
echo "source "/opt/emsdk/emsdk_env.sh"" >> ~/.zshrc

# Install Postman CLI
curl -o- "https://dl-cli.pstmn.io/install/linux64.sh" | sh

# Install from its website
Eclipse

# Install from Chrome PWA Installer
WhatsApp
Teams
Twitter (X)

# Install using UBUNTU SOFTWARE
Startup Disk Creator (with dotted lines in image)
LogSeq
Draw.io
LibreOffice*
