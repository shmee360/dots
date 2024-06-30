#!/bin/sh

userresources=${XDG_CONFIG_HOME:-$HOME/.config}/x11/xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

setxkbmap -layout ca -variant eng

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Keyboard
setxkbmap us &

# Display Resolution
xrandr --dpi 284 &

# Compositor
picom -f &

dwmblocks &

feh --bg-center ~/pics/maui/107D5600/DSC_0077.JPG &

#  btpd &

# DWM
while :; do
	ssh-agent dwm
done
