#!/usr/bin/env bash

dir="$HOME/.config/polybar"
themes=($(ls --hide="launch.sh" $dir))

launch_bar() {
	# Terminate already running bar instances
	killall -q polybar

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

	# Launch the bar
	for m in $(xrandr --listactivemonitors | cut -d"/" -f1 | awk '{if($3>1000)print$2}' | sed -r "s/(\*|\+)//g"); do
		# for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar -q main -c "$dir/config.ini" &
	done

	for m in $(xrandr --listactivemonitors | cut -d"/" -f1 | awk '{if($3<=1000)print$2}' | sed -r "s/(\*|\+)//g"); do
		# for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar -q main -c "$dir/config_short.ini" &
	done

}

launch_bar
