#!/bin/bash
#
# Author: danielpancake
# Release date: Jan 15, 2021
# Last updated: Oct 10, 2024
#
# https://danielpancake.github.io
#

EVDEV=/usr/share/X11/xkb/rules/evdev.xml

declare -A KEYBOARD_FLAGS=(
    ["al"]="🇦🇱"     # Albania
    ["et"]="🇪🇹"     # Ethiopia
    ["am"]="🇦🇲"     # Armenia
    ["ara"]="🇸🇦"    # Arabic (using Saudi Arabia as representative)
    ["eg"]="🇪🇬"     # Egypt
    ["iq"]="🇮🇶"     # Iraq
    ["ma"]="🇲🇦"     # Morocco
    ["sy"]="🇸🇾"     # Syria
    ["az"]="🇦🇿"     # Azerbaijan
    ["ml"]="🇲🇱"     # Mali
    ["bd"]="🇧🇩"     # Bangladesh
    ["by"]="🇧🇾"     # Belarus
    ["be"]="🇧🇪"     # Belgium
    ["dz"]="🇩🇿"     # Algeria
    ["ba"]="🇧🇦"     # Bosnia and Herzegovina
    ["brai"]="⠃⠗⠇" # Braille (using Braille symbols)
    ["bg"]="🇧🇬"     # Bulgaria
    ["mm"]="🇲🇲"     # Myanmar
    ["cn"]="🇨🇳"     # China
    ["hr"]="🇭🇷"     # Croatia
    ["cz"]="🇨🇿"     # Czech Republic
    ["dk"]="🇩🇰"     # Denmark
    ["af"]="🇦🇫"     # Afghanistan
    ["mv"]="🇲🇻"     # Maldives
    ["nl"]="🇳🇱"     # Netherlands
    ["bt"]="🇧🇹"     # Bhutan
    ["au"]="🇦🇺"     # Australia
    ["cm"]="🇨🇲"     # Cameroon
    ["gh"]="🇬🇭"     # Ghana
    ["nz"]="🇳🇿"     # New Zealand
    ["ng"]="🇳🇬"     # Nigeria
    ["za"]="🇿🇦"     # South Africa
    ["gb"]="🇬🇧"     # United Kingdom
    ["us"]="🇺🇸"     # United States
    # ["epo"]=""    # Esperanto 
    ["ee"]="🇪🇪"     # Estonia
    ["fo"]="🇫🇴"     # Faroe Islands
    ["ph"]="🇵🇭"     # Philippines
    ["fi"]="🇫🇮"     # Finland
    ["fr"]="🇫🇷"     # France
    ["ca"]="🇨🇦"     # Canada
    ["cd"]="🇨🇩"     # Democratic Republic of the Congo
    ["tg"]="🇹🇬"     # Togo
    ["ge"]="🇬🇪"     # Georgia
    ["de"]="🇩🇪"     # Germany
    ["at"]="🇦🇹"     # Austria
    ["ch"]="🇨🇭"     # Switzerland
    ["gr"]="🇬🇷"     # Greece
    ["il"]="🇮🇱"     # Israel
    ["hu"]="🇭🇺"     # Hungary
    ["is"]="🇮🇸"     # Iceland
    ["in"]="🇮🇳"     # India
    ["id"]="🇮🇩"     # Indonesia
    ["ie"]="🇮🇪"     # Ireland
    ["it"]="🇮🇹"     # Italy
    ["jp"]="🇯🇵"     # Japan
    ["kz"]="🇰🇿"     # Kazakhstan
    ["kh"]="🇰🇭"     # Cambodia
    ["kr"]="🇰🇷"     # South Korea
    ["kg"]="🇰🇬"     # Kyrgyzstan
    ["la"]="🇱🇦"     # Laos
    ["lv"]="🇱🇻"     # Latvia
    ["lt"]="🇱🇹"     # Lithuania
    ["mk"]="🇲🇰"     # North Macedonia
    ["my"]="🇲🇾"     # Malaysia
    ["mt"]="🇲🇹"     # Malta
    ["md"]="🇲🇩"     # Moldova
    ["mn"]="🇲🇳"     # Mongolia
    ["me"]="🇲🇪"     # Montenegro
    ["np"]="🇳🇵"     # Nepal
    ["gn"]="🇬🇳"     # Guinea
    ["no"]="🇳🇴"     # Norway
    ["ir"]="🇮🇷"     # Iran
    ["pl"]="🇵🇱"     # Poland
    ["pt"]="🇵🇹"     # Portugal
    ["br"]="🇧🇷"     # Brazil
    ["ro"]="🇷🇴"     # Romania
    ["ru"]="🇷🇺"     # Russia
    ["rs"]="🇷🇸"     # Serbia
    ["lk"]="🇱🇰"     # Sri Lanka
    ["sk"]="🇸🇰"     # Slovakia
    ["si"]="🇸🇮"     # Slovenia
    ["es"]="🇪🇸"     # Spain
    # ["latam"]=""  # Latin America
    ["ke"]="🇰🇪"     # Kenya
    ["tz"]="🇹🇿"     # Tanzania
    ["se"]="🇸🇪"     # Sweden
    ["tw"]="🇹🇼"     # Taiwan
    ["tj"]="🇹🇯"     # Tajikistan
    ["th"]="🇹🇭"     # Thailand
    ["bw"]="🇧🇼"     # Botswana
    ["tm"]="🇹🇲"     # Turkmenistan
    ["tr"]="🇹🇷"     # Turkey
    ["ua"]="🇺🇦"     # Ukraine
    ["pk"]="🇵🇰"     # Pakistan
    ["uz"]="🇺🇿"     # Uzbekistan
    ["vn"]="🇻🇳"     # Vietnam
    ["sn"]="🇸🇳"     # Senegal
    ["custom"]="🛠️"
)

# Check if privileges are sufficient
if [ ! -w $EVDEV ]; then
    echo "Permission denied! No write access to $EVDEV."
    echo "Please run this script as root."
    exit 1
fi

# Check if xmlstarlet is installed
if ! command -v xmlstarlet &> /dev/null; then
    echo "xmlstarlet is not installed. Please install it first."
    exit 1
fi

# Ask for restoring the backup file
if [ -f $EVDEV.bak ]; then
    read -p "Backup file has been found. Do you want to restore? (y / N): " confirm
    case $confirm in
        [yY][eE][sS]|[yY])
            cp $EVDEV.bak $EVDEV
            rm $EVDEV.bak

            echo "Restored successfully!"
            exit 0
            ;;
        *)
            ;;
    esac
fi

# Main script
if [ -f $EVDEV ]; then
    # Prompt before modifying the file
    read -p "Are you ready to modify $EVDEV? (Y / n): " confirm
    case $confirm in
        [nN][oO]|[nN])
            echo "Aborted."
            exit 0
            ;;
        *)
            ;;
    esac
    echo "Modifying $EVDEV..."

    # Backup the original file (only once)
    cp -n $EVDEV $EVDEV.bak

    # Replace the language labels with the flag emoji
    for FLAG_LABEL in "${!KEYBOARD_FLAGS[@]}"; do
        FLAG_EMOJI=${KEYBOARD_FLAGS[$FLAG_LABEL]}

        xmlstarlet edit --inplace \
            -u "//layoutList/layout/configItem[name='$FLAG_LABEL']/shortDescription" \
            -v "$FLAG_EMOJI" \
            $EVDEV
    done
else
    echo "$EVDEV doesn't exists! Aborting."
    exit 1
fi

echo "Done! Restarting GNOME session is required!"
exit 0
