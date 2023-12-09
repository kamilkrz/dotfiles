#!/bin/bash
revert() {
  rm /tmp/*screen*.png
  xset dpms 0 0 0
}
lockscreens="$HOME/.config/i3-lockscreen/"
rnd_lck=("$(find "$lockscreens" -type f | sort -R)")
arr_lck=($rnd_lck)
trap revert HUP INT TERM
xset +dpms dpms 0 0 5
scrot -d 0 /tmp/locking_screen.png
convert -scale 10% -scale 1000% /tmp/locking_screen.png /tmp/screen_blur.png
convert -composite -gravity south /tmp/screen_blur.png "${arr_lck[0]}" -geometry +300x100 /tmp/screen.png 
i3lock -ef -i /tmp/screen.png -p default
revert
