~$ sudo yum install wine.i686
~$
~$ wget http://winetricks.org/winetricks
~$ chmod +x winetricks 
~$ 
~$ ./winetricks ie6 tahoma [directx9 dotnet40]
~$ 
#设置 HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProductId = 00346-OEM-8992752-50005
~$ 
~$ WINEPREFIX=~/.wineunity42 WINEARCH=win32 wine ~/Downloads/Unity-setup.4.2.2.exe
~$ 
~$ WINEPREFIX=~/.wineunity42 wine ~/.wineunity42/drive_c/Program\ Files/Unity/Editor/Unity.exe
~$
#如果提示缺dnsapi.dll，则使用winecfg，使用内置library优先于native
#！重要！如果不创建的话，运行游戏即崩溃，并且Hierarchy里的对象全部消失
~$ mkdir -p ~/.wineunity42/drive_c/users/yourname/AppData/LocalLow
