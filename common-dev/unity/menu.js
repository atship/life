// Ctrl % Shift # Alt &
// LEFT, RIGHT, UP, DOWN, F1 .. F12, HOME, END, PGUP, PGDN
// This code will add a submenu under Tools, and the hotkey is Ctrl + Shift + E
@MenuItem("Tools/This is test menu item %#E")
static function Good()
{
	Debug.Log("Good item triggered");
}