#!/bin/bash

# Variables
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
sudo dnf install -y zsh git python3-devel python3-pip gh glab cloc code kate cmake g++ gdb clang lldb xlsclients fastfetch chromium flatpak git-lfs vlc kmod akmods mokutil openssl gcc kernel-headers kernel-devel util-linux

sudo dnf group install -y development-tools multimedia

echo "Updating Git configuration..."
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

echo "Making ZSH default shell..."

chsh -s $(which zsh)

echo "Secure boot key generation..."
sudo kmodgenca -a
sudo mokutil --import /etc/pki/akmods/certs/public_key.der
