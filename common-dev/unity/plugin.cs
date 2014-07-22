1, first, create dynamically library, whatever mac/win/linux/android/ios, corresponding to platform arch, x86/x86_64/arm/...

2, unitypro: put the binary file into the Assets/Plugins/ folder
   unityfree: put c/c++ library into the project root folder, and c# library into the Assets/Plugins/ folder.
   And after build for a target platform, copy the c/c++ library into the Data/Plugins/ folder
   
3, create a c# wrapper class
using System;
using System.Runtime.InteropServices;
public class MyPluginClass
{
    [DllImport("pluginName")]
    public static extern int MyPluginFunction(string param);
    
    [DllImport("pluginName")]
    public static extern string MyPluginFunction2(string param);
    
    ...
}

4,  c/c++ library must compile for specified platform, 
    linux/android->so, windows->dll, mac/ios->bundle, 
    and put them into the Plugins folder, like as Plugins/android, Plugins/linux ...
    c# library is run everywhere once compiled
    
