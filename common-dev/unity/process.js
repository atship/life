//声明一个程序信息类
var info : System.Diagnostics.ProcessStartInfo  =  new  System.Diagnostics.ProcessStartInfo();

//设置外部程序名
info.FileName  =  System.Environment.GetEnvironmentVariable("URHO3D_HOME").Replace("\\", "\\\\") + '\\\\Bin\\\\AssetImporter.exe';

//设置外部程序的启动参数（命令行参数）
info.Arguments  =  command;

//获取系统变量 %PATH%
System.Environment.GetEnvironmentVariable("PATH")