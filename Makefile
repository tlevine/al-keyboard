letter-usage.png:
	./compare-al-us.r

install:
	cp xkb /usr/share/X11/xkb/symbols/al

dvorak.png:
	setxkbmap al -variant dvorak
	xkbprint :0 /tmp/keyboard-layout.ps
	inkscape --without-gui --export-png=dvorak.png \
	         --export-area='80:230:640:450' \
		 --export-background='#FFFFFF' \
		 /tmp/keyboard-layout.ps
