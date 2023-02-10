# Module: picom
# Description:
#       package for transparency window and more beautifull configuration

#!/bin/bash
echo 'Installing picom package ...'
sudo pacman -S --noconfirm picom
mkdir $HOME/.config/picom/