// iterate scenes that enabled in build settings
for (var scene : UnityEditor.EditorBuildSettingsScene in UnityEditor.EditorBuildSettings.scenes)
{
	if (scene.enabled)
	{
		Debug.Log("scene path " + scene.path);
		
		EditorApplication.OpenScene(scene.path);
		
		// iterate all game objects in the scene
		for (var gameObject : GameObject in GameObject.FindObjectsOfType(typeof(GameObject)))
		{
			
		}
	}
}