#!/bin/bash

# Variables
PACKAGE_FILE="packages.txt"
DNF_CONF="dnf.conf"
GIT_NAME="Rahul Vadhyar"
GIT_EMAIL="vadhyarrahul@gmail.com"

# Function to update dnf.conf
if [ -f "$DNF_CONF" ]; then
    echo "Updating dnf.conf..."
    sudo cp -f "$DNF_CONF" /etc/dnf/dnf.conf
else
    echo "dnf.conf file $DNF_CONF not found!"
    exit 1
fi

echo "Upgrading system..."
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
sudo dnf upgrade -y

if [ -f "$PACKAGE_FILE" ]; then
    echo "Installing packages from $PACKAGE_FILE..."
    packages=$(tr ' ' < "$PACKAGE_FILE")
    sudo dnf install -y $packages --allowerasing --skipbroken
    sudo dnf groupinstall -y "Development Tools"
    sudo dnf groupupdate multimedia
else
    echo "Package file $PACKAGE_FILE not found!"
    exit 1
fi
#
# echo "Update fstab configuration..."
# sudo echo "UUID=EBBF-75C2                            /run/media/baby2           exfat   rw,user,exec,uid=1000,gid=1000,umask=000    0 0"  >> /etc/fstab
# sudo echo "UUID=8E8B-6608                            /run/media/baby1           exfat   rw,user,exec,uid=1000,gid=1000,umask=000    0 0"  >> /etc/fstab


echo "Updating Git configuration..."
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

# echo "Installing Python packages..."
pip install torch torchvision torchaudio matplotlib pandas scipy scikit-learn numpy notebook ipykernel

echo "Making ZSH default shell..."
chsh -s $(which zsh)
zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh); git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions; git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting; git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting; git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete"

# Check if .zshrc exists in the home directory

ZSHRC="$HOME/.zshrc"

if [ -f "$ZSHRC" ]; then
    # Use sed to replace the plugins line
    sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)/' "$ZSHRC"
    echo ".zshrc has been updated "
else
    echo ".zshrc not found in the home directory."
    exit 1
fi


echo "Secure boot key generation..."
sudo kmodgenca -a
sudo mokutil --import /etc/pki/akmods/certs/public_key.der

echo "Github login"
gh auth login
