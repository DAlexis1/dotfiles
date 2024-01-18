#!/bin/bash

if [[ "$USER" = "root" ]]; then
	echo "Don't run this program as root : it won't work"
	exit 0
fi

user=$USER

# install every program needed
echo "[*] Setting lightdm-slick-greeter configuration"
sudo rm /etc/lightdm/lightdm.conf
sudo cp /home/$user/dotfiles/lightgreeter-conf/lightdm.conf /etc/lightdm/
sudo cp /home/$user/dotfiles/lightgreeter-conf/slick-greeter.conf /etc/lightdm/
sudo mkdir /usr/share/backgrounds
sudo cp /home/$user/dotfiles/background /usr/share/backgrounds/dragon-girl.jpg

echo "[*] Installing programs from main repo"
sudo pacman -Rns i3-lock || sudo pacman -S --needed git unzip base-devel go zenity xorg-xinput raylib acpi xorg-xwininfo xdotool xorg-xrandr networkmanager pulseaudio libpulse feh picom python-pywal zsh alacritty keepass thunderbird firefox flameshot neovim lightdm-slick-greeter qutebrowser npm luarocks xclip xautolock xss-lock

echo "[*] Installing yay"
cd ~ || exit 0
git clone https://aur.archlinux.org/yay.git
cd ~/yay || exit 0
makepkg -siCc --noconfirm

echo "[*] Installing programs from AUR"
yay -S i3lock-color
yay -S autotiling
#yay -S librewolf
yay -S flameshot
yay -S onlyoffice-bin

# install nerd-fonts
echo "[*] Get fonts-file"
cd ~ || exit 0
mkdir ~/patched-fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Mononoki.zip -P ~/patched-fonts/
cd ~/patched-fonts || exit 0
unzip Mononoki.zip
rm README.md
rm LICENSE.txt

cd ~ || exit 0
echo "[*] Get install script"
wget https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/install.sh
chmod +x install.sh
./install.sh

echo "[*] Get oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "[*] Get powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "[*] Get syntax highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "[*] Setting zsh parameters"
rm ~/.zshrc
cp ~/dotfiles/.zshrc ~/.zshrc

echo "[*] Creating necessary directories for my script"
mkdir ~/Images
mkdir ~/Scripts
mkdir ~/AppImage

echo "[*] Copying files from github dotfiles"
cp -R ~/dotfiles/Scripts/* ~/Scripts/
cp ~/dotfiles/background ~/Images/dragon-girl.jpg
rm -rf .config/i3/
cp -R ~/dotfiles/i3-conf ~/.config/i3/
cp -R ~/dotfiles/alacritty ~/.config/
cp -R ~/dotfiles/nvim ~/.config/

echo "[*] Installing nerd-fonts in Scripts and i3config"
rm -rf ~/.config/i3/MononokiNerdFontMono-Regular.ttf
cp ~/patched-fonts/MononokiNerdFontMono-Regular.ttf ~/.config/i3/
rm -rf ~/Scripts/MononokiNerdFontMono-Regular.ttf
cp ~/patched-fonts/MononokiNerdFontMono-Regular.ttf ~/Scripts/

echo "Do you want to add Scripts directory to PATH (Y/n) : "
read -r AcceptScriptsPath
# add Scripts directory to path
if [[ "$AcceptScriptsPath" = "y" ]]; then
	sudo touch /etc/profile.d/env.sh
	sudo echo 'export PATH="$PATH:/home/'"${user}"'/Scripts"' | sudo tee -a /etc/profile.d/env.sh
fi

echo "[*] End of auto-settings"
echo "[Reboot to apply changes]"
exit 0
