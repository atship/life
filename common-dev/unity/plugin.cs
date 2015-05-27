1, first, create dynamically library, whatever mac/win/linux/android/ios, corresponding to platform arch, x86/x86_64/arm/...
    native example:
        in header file:
        #pragma once
        #define DLLEXPORT __declspec(dllexport)
        extern "C"
        {
            DLLEXPORT int GetInt();
        }
        
        in cpp file:
        #include "header.h"
        extern "C"
        {
            int GetInt()
            {
                return 0;
            }
        }

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

4, c/c++ library must compile for specified platform, 
    linux/android->so, windows->dll, mac/ios->bundle, 
    and put them into the Plugins folder, like as Plugins/android, Plugins/linux ...
    c# library is run everywhere once compiled
    
5, debug plugin (managed dll)
    visual studio:
        this will need pro or ultimate version and with unityvs addons. skip here, because I don't have them.
    mono develop:
        1, open the plugin solution
        2, build it and use command "pdb2mdb.exe target.dll" to produce file target.dll.mdb
        3, copy the target.dll and target.dll.mdb into the folder Assets/Plugins/
        4, attach to the unity process with mono develop
        5, set the breakpoints you need
        6, run in the unity editor
        7, this will break in the mono develop, you can use F10 to step over, F11 to step in, Shift+F11 to step out
        
   debug plugin (native dll)
    windows:
        visual studio:
            I am using visual studio express 2013
            1, open the plugin solution
            2, build it and copy target.dll and target.pdb into the unity's project root folder(unity free) or Assets/Plugins/(unity pro)
            3, create c# wrapper class and use it in the unity project
            4, attach to the unity process with vs2013
            5, set the breakpoints you need
            6, run in the unity editor
            7, the vs2013 will break when meet the breakpoints, you can use F10 to step over, F11 to step in, Shift+F11 to step out
            
    Linux and Mac and android and IOS are unknown

6, call c# function in c/c++ plugins
    Well, this is not a good idea, because this method will need more and more delegate functions. Anyway, if you want to write log info to the unity editor console,
    this is also a good idea.
    1, typedef function pointer (typedef void (*DebugFunc)(const char*))
    2, export a settle function (DLLEXPORT void SetDebugFunc(DebugFunc f))
    3, save the DebugFunc pointer(f) and call it everywhere you need
    4, export the dll and copy it into the unity project root(unity free) or Assets/Plugins/(unity pro)
    5, write a c# wrapper class
        using System;
        using System.Runtime.InteropServices;
        
        [DllImport("target.dll")]
        public static extern void SetDebugFunc(IntPtr func); //the function address is a IntPtr in c#
        
        [UnmanagedFunctionPointer(CallingConverion.Cdecl)]
        public delegate void PrintDebug(string infoFromCpp);
        
        static void RealPrint(string info)
        {
            Debug.Log("Info from cpp: " + info);
        }
        
        void Awake()
        {
            PrintDebug d = new PrintDebug(RealPrint);
            IntPtr func = Marshal.GetFunctionPointerForDelegate(d);
            SetDebugFunc(func);
        }
     6, run the project in the editor, you will see the log you printed from c/c++ plugins
    