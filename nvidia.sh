#!/bin/bash
sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-libs xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-power xorg-x11-drv-nvidia-xorg-libs xorg-x11-drv-nvidia-cuda-libs

curl -fsSL -o install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
chmod +x install.sh
./install.sh

git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/marlonrichert/zsh-autocomplete.git ~/.oh-my-zsh/custom/plugins/zsh-autocomplete

#update zshrc
cp ~/.zshrc ~/.zshrc.bak
cp .zshrc ~/.zshrc
echo ".zshrc has been updated "

sudo akmods --force
sudo dracut --force
sudo reboot now

# Things i want customized: 
# dolphin - /home/rahulvadhyar/.config/dolphinrc
# konsole - /home/rahulvadhyar/.config/konsolerc
# mouse and keyboard settings
# suspend
# desktop session
# global theme
# colors
# window decorations
# splash screen - /home/rahulvadhyar/.config/ksplashrc
# wallpaper
# toolbar settings

# /home/rahulvadhyar/.config/kdeglobals
# /home/rahulvadhyar/.config/kscreenlockerrc
# /home/rahulvadhyar/.config/kservicemenurc
# /home/rahulvadhyar/.config/plasma-org.kde.plasma.desktop-appletsrc
# /home/rahulvadhyar/.config/spectaclerc
# /home/rahulvadhyar/.config/kdedefaults/kwinrc
# /home/rahulvadhyar/.config/kdedefaults/kdeglobals

#TUI with dnf config, installation of packages, git config, zsh config, nvidia driver installation, omz install, zsh pluginss, kde customization, rust setup, armcord, mission center, 
#vs code auto setup, mouse and keyboard settings, auto setting of wallpaper, toolbar customization