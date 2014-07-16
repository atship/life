Application.systemLanguage 获取系统语言（win/mac/linux下可用，ios不可用，会传回unknown）

如果是ios，可以使用以下办法： (来源http://unity3d.9ria.com/?p=3378)

1.当Unity编译输出为iPhone应用程式完成之后，会开启Xcode，在此找出AppController.mm。

2.在-(id)initWithFrame:(CGRect)frame{...}的大括号中插入这句[[NSUserDefaultsstandardUserDefaults]setObject:[[NSLocalepreferredLanguages]objectAtIndex:0]forKey:@“YourLanguageKey”];

3.把以上这句代码的YourLanguageKey改为自己喜欢的字串，不改也成。

4.然后在Unity任意的Script中，只要呼叫PlayerPrefs.GetString(“YourLanguageKey”)就能取得代表语系的字串；en代表英文、zh-Hant代表中文繁体、zh-Hans代表中文简体。

步骤2的代码会在Awake()之前执行，所以我把PlayerPrefs.GetString(“YourLanguageKey”)放在Awake()中判断语系，并切换适当的语言环境给玩家；另外，也可在做这个判断之前使用if(Application.platform==RuntimePlatform.IPhonePlayer){...}来分辨目前的执行平台，毕竟只有在iPhone才需要这样特别处理。
