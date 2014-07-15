using System;

// the serializ will occur in editor, when you play or export it to the platform, that is , the data will save in the scene
[Serializable]
public class SerializeClass
{
    public float field;// will serialize
    private float field;//will not serialize
    
    [SerializeField]
    private float field;//will serialize
    
    [Nonserialized]
    public Vector3 field;//will not serialize
}

//access the serialized data, this code can only run in Editor
void function()
{
    target = new SerializeClass();
    SerializedObject obj = new SerializedObject(target);
    SerializedProperty it = obj.GetIterator();
    while(it.Next(true/false))//enter children or not
    {
        it.name/it.type
        if (it.type == "bool/int/char/string/float/Array...")
            it.boolValue = false;
        
        if (it.propertyType == SerializedPropertyType.Boolean)
            it.boolValue = false;
    }
    obj.ApplyModifiedProperties();
}

//an example class
[Serializable]
public class Test : ScriptableObject
{
    public float data;
    public bool init;
    
    public void OnEnable()
    {
        // the comment may be wrong, I haven't verified it
        //add this indicate that the obj will under pure control of you, the unity will ignore it's lifecycle(gc)
        // and assembly reload will not cause it lost the data
        hideFlags = HideFlags.HideAndDontSave;
        if (!init)
        {
            data = 0.0f;
            init = true;
        }
    }
}