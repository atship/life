#安装winetricks
$ wget http://winetricks.org/winetricks
$ chmod +x winetricks

#安装wine
$ sudo yum install wine

#安装驱动
$ WINEPREFIX=~/.winertx ~/winetricks msxml3 gdiplus riched20 riched30 ie6 vcrun6 vcrun2005sp1
$ WINEPREFIX=~/.winertx ~/winetricks wenquanyi
$ WINEPREFIX=~/.winertx wine regedit  --> HKEY_LOCAL_MACHINE/Software/Microsoft/WindowsNT/FontSubstitutes/SimSun = WenQuanYi Micro Hei

#安装rtx
$ LANG=zh_CN.UTF8 WINEPREFIX=~/.winertx wine rtxclient2012formal.exe

#启动
env LANG=zh_CN.UTF8 WINEPREFIX="/home/hualin/.winertxc" wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/hualin/.winertxc/dosdevices/c:/users/Public/Desktop/腾讯通RTX.lnk
