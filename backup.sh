#!/bin/bash

# check to see is git command line installed in this machine
IS_GIT_AVAILABLE="$(git --version)"
if [[ $IS_GIT_AVAILABLE == *"version"* ]]; then
	echo "Git is Available"
else
	echo "Git is not installed"
	exit 1
fi

rm install.sh
rm -rf nvim
rm -rf alacritty
rm background
rm -rf i3-conf
rm -rf Scripts
rm .zshrc
rm neofetch_config
rm picom_conf
rm -rf pacman-hooks
rm -rf dwm

mkdir dwm
# get every files needed
cp ~/Bureau/reinstall.sh install.sh
cp -r ~/.config/alacritty alacritty
cp -r ~/.config/nvim nvim
cp -r ~/.config/i3 i3-conf
cp ~/.zshrc .zshrc
cp ~/Images/dragon-girl.jpg background
cp -r ~/Scripts Scripts
cp ~/.config/neofetch/config.conf neofetch_config
cp /etc/xdg/picom.conf picom_conf
cp -r /etc/pacman.d/hooks pacman-hooks
cp -r ~/dwm/* dwm/
gzip -r dwm
gunzip -r dwm
# Check git status
gs="$(git status | grep -i "modified")"
echo "${gs}"

# If there is a new change
if [[ $gs == *"modified"* ]]; then
	echo "push"
fi

# push to Github
git add -A
git commit -m "New backup $(date +'%Y-%m-%d %H:%M:%S')"
git push origin master
