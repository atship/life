1, first, create dynamically library, whatever mac/win/linux/android/ios
2, put the binary file into the Assets/Plugins/ folder, and unityfree will log error for your plugins, you can put it into the assets dir to avoid the warning
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