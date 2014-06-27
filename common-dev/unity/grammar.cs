// Grammar for c#

1, You can use Custom attribute
    1, define custome attribute class
        public class MyAttribute : System.Attribute
        {
            public MyAttribute(int param)
            {
                param_ = param;
            }
            
            public int param_;
        }
        
    2, use it in anywhere you want
        public class Test
        {
            [My(3)]
            public static void testFunc(){}
        }
        
    3, you can access the attribute like as MethodInfo.GetCustomAttributes(typeof(MyAttribute), false)[0].param_
    
    4, how to get method info? typeof(Test).GetMethod*()
    
2, You can use System.Reflection
    1, define a class
        public class TestClass 
        {
            public static void testFunc(){}
            public int testFunc2(int p1, int p2){}
        }
        
    2, write your method
        public void reflect()
        {
            Type tc = typeof(TestClass);
            
            MethodInfo[] methods = tc.GetMethods(BindingFlags.Public | BindingFlags.Static);
            MethodInfo testFunc2 = tc.GetMethods("testFunc2");
            
            foreach(MethodInfo method in methods)
            {
                ...
                method.Name
                method.ReturnType.Name
                method.IsStatic
                ParameterInfo[] params_ = method.GetParameters()
                params_[0].Name
                params_[0].ParameterType.Name
                ...
            }
        }
        
3, Use List<T>, Dictionary<T, T> insteadof Array, Hashtable, under System.Collections.Generic

4, How to iterate Dictionary, Hashtable
    foreach(T val in dict.Values)
        ...
        
    foreach(T key in dict.Keys)
        ...
        
5, use http://msdn.microsoft.com/en-us/library for searching

6, clear string
    myvar = string.Empty


    
