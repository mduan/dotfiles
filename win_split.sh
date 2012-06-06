#!/bin/bash

#WindowSplit Script Version 1
#Distributed under the terms of the GNU General Public Licence v2
#Writted by Jose Valdivia
#Email: domingovaldivia@gmail.com

#Pixel Free Size
#PF Space Between Windows
#ScreenMenu how many pixels does the window menus and pagers use
PF=0
ScreenMenu=30

#Max Resolution X and Y
X=`xrandr | grep "*" | awk '{print $1}' | awk -F "x" '{print $1}'`
Y=`xrandr | grep "*" | awk '{print $1}' | awk -F "x" '{print $2}'`

#Split Left Screen
SLX=$((($X/2)-$PF))
SLY=$((($Y/2)-$ScreenMenu))

#Split Right Screen
SRX=$((($X/2)+$PF))
SRY=$((($Y/2)+$PF))


echo $SLX x $SLY
case "$1" in


left)
wmctrl -r :ACTIVE: -e "1,0,0,$SLX,$Y"

;;

right)
wmctrl -r :ACTIVE: -e "1,$SRX,10,$SLX,$Y"
;;

top)
wmctrl -r :ACTIVE: -e "1,0,0,$X,$SLY"
;;

bottom)
wmctrl -r :ACTIVE: -e "1,$SRX,$SRY,$X,$SLY"
;;

topright)
wmctrl -r :ACTIVE: -e "1,$SRX,0,$SLX,$SLY"
;;

topleft)
wmctrl -r :ACTIVE: -e "1,0,0,$SLX,$SLY"
;;

bottomright)
wmctrl -r :ACTIVE: -e "1,$SRX,$SRY,$SLX,$SLY"
;;

bottomleft)
wmctrl -r :ACTIVE: -e "1,0,$SRY,$SLX,$SLY"
;;

full)
wmctrl -r :ACTIVE: -b "toggle,maximized_vert,maximized_horz"
;;

*)
echo "Usage: $0 {left|right|up|down}"
exit 1
;;
esac

exit 0
