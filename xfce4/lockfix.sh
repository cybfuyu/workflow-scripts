#!/bin/bash
# This script exists to address a weird bug I've personally faced when using XFCE on my current workstation, in which dual monitors will mirror whenever xfce screen lock commences.
# It's a very inefficient workaround, but essentially will determine whether or not xfce4-screensaver-command has started the lock, then we run an arandr script to re-adjust the displays.

echo "Checking for lock..."
while true
do
    if xfce4-screensaver-command --query | grep -q 'is active'; then
        bash ~/.screenlayout/display.sh
    fi
    sleep 1
done
