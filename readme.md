# GNOME keyboard layout with emoji flags

This bash script replaces the default GNOME keyboard layout codes with emoji flags.

![Before / after comparison](https://raw.githubusercontent.com/danielpancake/gnome-flags-layout/master/assets/before-after.png)

## Usage

To run the script, use the following command (requires `curl` and elevated privileges):

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/danielpancake/gnome-flags-layout/master/flags.sh)"
```

The script will create a backup of the original layout file in the same directory, which can be restored by running the script again and following the prompts.

## Dependencies

- xmlstarlet
