import System.IO;

// File
// Directory
// FileUtil

// some path
Application.datapath // $PROJECT_DIR/Assets/
scene.path @see scenes.js // $PROJECT_DIR/Assets/[**/]sceneName.unity

// remove files in path
for (var file : String in Directory.GetFiles(path))
	FileUtil.DeleteFileOrDirectory(file);

// get asset file path	
AssetDatabase.GetAssetPath

// get asset file name, like as prefab, model, texture etc.
var assetPath : String = AssetDatabase.GetAssetPath(assetObject);
var assetFileName : String = assetPath.Substring(assetPath.LastIndexOf('/')+1);

// get model path from gameobject
var modelPath : String = AssetDatabase.GetAssetPath((gameobject.GetComponent(MeshFilter) as MeshFilter).sharedMesh);