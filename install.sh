#!/bin/sh

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
setxkbmap -layout us -variant dvp -option compose:102 -option keypad:atm \
-option numpad:shift3 -option kpdl:semi -option caps:escape
