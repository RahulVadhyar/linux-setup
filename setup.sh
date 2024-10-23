#!/bin/bash

# Variables
DNF_CONF="dnf.conf"
GIT_NAME="Rahul Vadhyar"
GIT_EMAIL="vadhyarrahul@gmail.com"

echo "Updating dnf.conf..."
sudo cp -f dnf.conf /etc/dnf/dnf.conf

echo "Upgrading system..."
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
sudo dnf upgrade -y

echo "Installing packages.."
sudo dnf install -y zsh git python3-devel python3-pip bpytop nvtop gh glab cloc code kate cmake g++ gdb clang lldb xlsclients neofetch chromium flatpak git-lfs vlc ffmpeg kmod akmods mokutil openssl gcc kernel-headers kernel-devel util-linux

sudo dnf groupinstall -y "Development Tools"
sudo dnf groupupdate -y multimedia

echo "Updating Git configuration..."
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

# echo "Installing Python packages..."
pip install torch torchvision torchaudio matplotlib pandas scipy scikit-learn numpy notebook ipykernel

echo "Making ZSH default shell..."

chsh -s $(which zsh)
curl -fsSL -o install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
chmod +x install.sh
./install.sh

git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
git clone https://github.com/marlonrichert/zsh-autocomplete.git ~/.oh-my-zsh/custom/plugins/zsh-autocomplete

# Use sed to replace the plugins line
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)/' "$HOME/.zshrc"
echo ".zshrc has been updated "

echo "Secure boot key generation..."
sudo kmodgenca -a
sudo mokutil --import /etc/pki/akmods/certs/public_key.der
