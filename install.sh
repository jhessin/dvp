#!/usr/bin/env bash

source ./functions.sh

# DISCLAIMER
echo DO NOT JUST RUN THIS FILE!
echo this will remove and replace your ~/.local/bin directory.
echo If you want to save anything from there do that before running this.
if ! confirm "Are you sure you want to continue"; then
  exit 1;
fi

rm -rf ~/.local/bin
git clone https://github.com/jhessin/bin.git ~/.local/bin

dirs="/usr/share/keymaps/i386/dvorak /usr/share/kbd/keymaps/i386/dvorak"
for dir in $dirs
do
  echo "Check $dir."
  if [ -d "$dir" ] ; then
    dest=$dir
    break
  fi
done

if [ ! -d "$dest" ] ; then
  echo "Searching..."
  dest=`find /usr/share/ -type d|grep 'keymaps/i386/dvorak'|head -n1`
fi

if [ ! -d "$dest" ] ; then
  echo -e "\033[31mCannot find keymaps directory.\033[0m"
  exit 1
fi

command="cp dvp.map dvpx.map $dest"
echo $command
sudo $command
if [ $? -ne 0 ]; then
  echo -e "\033[31mFailed.\033[0m"
  exit 2
else
  echo -e "\033[32mSucceeded.\033[0m"
fi

localectl set-x11-keymap us pc105 dvp compose:102,numpad:shift3,kpdl:semi,keypad:atm,caps:escape
localectl set-keymap --no-convert dvp
echo "setxkbmap -layout us -variant dvp -option compose:102 -option keypad:atm \
-option numpad:shift3 -option kpdl:semi -option caps:escape" >> ~/.profile

echo Test your keyboard layout - it should be dvp now
read
if confirm "Do you wish to reboot now"; then
  sudo reboot
fi
