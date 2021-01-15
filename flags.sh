#!/bin/bash
# Thi little script replaces gnome layout labels with flag emoji
EVDEV=/usr/share/X11/xkb/rules/evdev.xml

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo!"
    exit 1
fi

if test -f $EVDEV.bak; then
    read -p "Backup file has been found. Do you want to restore? (y / N): " confirm
    if [[ $confirm = [yY] || $confirm = [yY][eE][sS] ]]; then
        cp $EVDEV.bak $EVDEV
        rm $EVDEV.bak
        echo "Settings restored successfully!"
        exit 1
    fi
fi

read -p "Use UK flag (default) for English layouts (instead of US flag)? (Y / n): " confirm
if [[ $confirm = [nN][oO] ]]; then
    enFlag="🇺🇸"
else
    enFlag="🇬🇧"
fi

declare -A flags=(
    ["de"]="🇩🇪"
    ["en"]=$enFlag
    ["es"]="🇪🇸"
    ["fr"]="🇫🇷"
    ["it"]="🇮🇹"
    ["ja"]="🇯🇵"
    ["ko"]="🇰🇷"
    ["pt"]="🇵🇹"
    ["ru"]="🇷🇺"
    ["uk"]="🇺🇦"
    ["zh"]="🇨🇳"
)

if test -f $EVDEV; then
    TAG="<shortDescription>"

    # Make a backup if not present
    cp -n $EVDEV $EVDEV.bak

    for KEY in "${!flags[@]}"; do
        # Replace labels with flag emoji
        sed -i "s/$TAG$KEY/$TAG${flags[$KEY]}/" $EVDEV
    done

    echo "Done! Restarting session is required!"
else 
    echo "$EVDEV doesn't exists! Aborting."
fi