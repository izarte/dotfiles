# Module: albert 
# Description:
#       user friendly searching bar package
# Usage:
#       albert or windows + space (key binding)

#!/bin/bash
echo 'Installing albert package ...'
paru -S --noconfirm albert
cp albert.conf $HOME/.config/albert/albert.conf