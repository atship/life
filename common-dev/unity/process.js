//����һ��������Ϣ��
var info : System.Diagnostics.ProcessStartInfo  =  new  System.Diagnostics.ProcessStartInfo();

//�����ⲿ������
info.FileName  =  System.Environment.GetEnvironmentVariable("URHO3D_HOME").Replace("\\", "\\\\") + '\\\\Bin\\\\AssetImporter.exe';

//�����ⲿ��������������������в�����
info.Arguments  =  command;

//��ȡϵͳ���� %PATH%
System.Environment.GetEnvironmentVariable("PATH")