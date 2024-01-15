#!/bin/bash

name_user=$1

if [[ ! $# -eq 1 ]]; then
	echo "Usage : $0 name_of_user"
	exit 1
fi

cd ~ || exit 0
# get nerd-fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Mononoki.zip
mkdir patched-fonts
cp -r Mononoki.zip patched-fonts/Mononoki.zip
cd ~/patched-fonts || exit 0
unzip Mononoki.zip
rm README.md
rm LICENSE.txt

cd ~ || exit 0
# copy in the location where i need the font
cp MononokiNerdFontMono-Regular.ttf Scripts/ || mkdir Scripts && cp MononokiNerdFontMono-Regular.ttf Scripts/
cp MononokiNerdFontMono-Regular.ttf .config/i3/config

cd ~ || exit 0
# install nerd-fonts
wget https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/install.sh
chmod +x install.sh
./install.sh

cd ~ || exit 0
# Install yay to install easily the packages
git clone https://aur.archlinux.org/yay.git
cd yay || exit 0
su -c makepkg -si "$name_user"
cd ~ || exit 0
rm -rf yay

cd ~ || exit 0

mkdir AppImage

cd ~ || exit 0

#install things used by my bar scripts
pacman -S zenity xorg-xinput raylib acpi xorg-xwininfo xdotool xorg-xrandr networkmanager pulseaudio feh picom python-pywal zsh

pacman -Rns i3lock
pacman -S i3lock-color
su -c yay i3lock-color "$name_user"
su -c yay autotiling "$name_user"

cd ~ || exit 0
# installation zsh + theme powerlevel10k
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo "Do you want to set zshrc to default (Y/n) :"
read -r Accept_powerlevel10k
if [[ "$Accept_powerlevel10k" = "y" ]]; then
	echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
fi

cd ~ || exit 0

#install apps
pacman -S Alacritty keepass thunderbird firefox flameshot neovim
su -c yay librewolf "$name_user"
su -c yay flameshot "$name_user"
su -c yay onlyoffice-bin "$name_user"

cd ~ || exit 0

#add to Path
echo "Do you want to add Scripts directory to PATH (Y/n) : "
read -r AcceptScriptsPath
# add Scripts directory to path
if [[ "$AcceptScriptsPath" = "y" ]]; then
	touch /etc/profile.d/env.sh
	echo 'export PATH="$PATH:/home/sandor/Scripts"' >>/etc/profile.d/env.sh
fi

cd ~ || exit 0

# configure lightdm-slick-greeter
# copy from github conf files and copy 
# lightdm.conf from github into /etc/lightdm/lightdm-slick-greeter.conf
# and copy slick-greeter.conf from github into /etc/lightdm/slick-greeter.conf
# and copy dragon-girl.jpg background images into /usr/share/backgrounds/dragon-girl.jpg
pacman -S lightdm-slick-greeter




